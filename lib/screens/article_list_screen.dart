import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/article_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'article_detail_screen.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final _cms = Get.find<CmsController>();
  String? _selectedCategory;

  List<String> get _categories {
    final cats = _cms.publishedArticles.map((a) => a.category).toSet().toList();
    cats.sort();
    return cats;
  }

  List<Article> get _filteredArticles {
    final articles = _cms.publishedArticles;
    if (_selectedCategory == null) return articles;
    return articles.where((a) => a.category == _selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    if (_cms.cmsData.value == null) {
      _cms.fetchCms();
    }
  }

  Future<void> _onRefresh() async {
    await _cms.fetchCms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Articles'),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final articles = _filteredArticles;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isAll = i == 0;
                      final active = isAll ? _selectedCategory == null : _categories[i - 1] == _selectedCategory;
                      final label = isAll ? 'All' : _categories[i - 1];
                      return SelectableChip(
                        label: label,
                        selected: active,
                        onTap: () => setState(() => _selectedCategory = isAll ? null : _categories[i - 1]),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: articles.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final article = articles[i];
                      return _ArticleCard(
                        article: article,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article, required this.onTap});

  final Article article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(
              children: [
                Image.network(
                  article.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: AppColors.surfaceContainer,
                    child: const Center(child: Icon(Icons.article_outlined, size: 48, color: AppColors.outline)),
                  ),
                ),
                if (article.trending)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.trending_up, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('Trending', style: AppText.labelCaps.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(article.category, style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                    ),
                    const Spacer(),
                    Text(article.date, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(article.title, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(article.excerpt,
                    style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.surfaceContainer,
                      child: Icon(Icons.person_outline, size: 14, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(article.author,
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Icon(Icons.schedule, size: 14, color: AppColors.outline),
                    const SizedBox(width: 4),
                    Text(article.readTime, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
