import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'article_editor_screen.dart';

class ArticleManagementScreen extends StatefulWidget {
  const ArticleManagementScreen({super.key});

  @override
  State<ArticleManagementScreen> createState() => _ArticleManagementScreenState();
}

class _ArticleManagementScreenState extends State<ArticleManagementScreen> {
  final _controller = Get.find<ArticleController>();

  @override
  void initState() {
    super.initState();
    _controller.loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'My Articles'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ArticleEditorScreen()),
        ),
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.errorMessage.value != null && _controller.articles.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_controller.errorMessage.value!, style: AppText.bodyMd),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _controller.loadArticles,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: _controller.loadArticles,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            itemCount: _controller.articles.length,
            itemBuilder: (context, index) {
              final article = _controller.articles[index];
              return Dismissible(
                key: ValueKey(article.slug),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  return await Get.defaultDialog<bool>(
                    title: 'Delete Article',
                    middleText: 'Are you sure you want to delete "${article.title}"?',
                    textConfirm: 'Delete',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    onConfirm: () => Get.back(result: true),
                  );
                },
                onDismissed: (_) => _controller.deleteArticle(article.slug),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SoftCard(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticleEditorScreen(article: article),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(article.title, style: AppText.titleLg),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildStatusBadge(article.status),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(article.excerpt, style: AppText.bodySm, maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.folder_outlined, size: 14, color: AppColors.outline),
                                  const SizedBox(width: 4),
                                  Text(article.category, style: AppText.labelCaps.copyWith(fontSize: 10, color: AppColors.outline)),
                                  const SizedBox(width: 16),
                                  Icon(Icons.calendar_today, size: 14, color: AppColors.outline),
                                  const SizedBox(width: 4),
                                  Text(article.date, style: AppText.labelCaps.copyWith(fontSize: 10, color: AppColors.outline)),
                                  const SizedBox(width: 16),
                                  Icon(Icons.schedule, size: 14, color: AppColors.outline),
                                  const SizedBox(width: 4),
                                  Text(article.readTime, style: AppText.labelCaps.copyWith(fontSize: 10, color: AppColors.outline)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, color: AppColors.outline),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isPublished = status == 'published';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isPublished ? AppColors.success.withOpacity(0.1) : AppColors.outline.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status == 'published' ? 'Published' : 'Draft',
        style: AppText.labelCaps.copyWith(
          fontSize: 9,
          color: isPublished ? AppColors.success : AppColors.outline,
        ),
      ),
    );
  }
}
