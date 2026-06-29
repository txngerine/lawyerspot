import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/qa_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'qa_detail_public_screen.dart';

class QaBrowsePublicScreen extends StatefulWidget {
  const QaBrowsePublicScreen({super.key});

  @override
  State<QaBrowsePublicScreen> createState() => _QaBrowsePublicScreenState();
}

class _QaBrowsePublicScreenState extends State<QaBrowsePublicScreen> {
  final _cms = Get.find<CmsController>();
  String? _selectedCategory;

  List<QaPost> get _filteredPosts {
    final posts = _cms.publishedQaPosts;
    if (_selectedCategory == null) return posts;
    return posts.where((p) => p.category == _selectedCategory).toList();
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
        title: const Text('Legal Q&A'),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final cmsData = _cms.cmsData.value;
          final content = cmsData?.siteContent;
          final posts = _filteredPosts;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cmsData != null && cmsData.trendingTopics.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trending Topics', style: AppText.labelCaps),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: cmsData.trendingTopics.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, i) {
                            final topic = cmsData.trendingTopics[i];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.navy.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(topic, style: AppText.bodySm.copyWith(color: AppColors.navy)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: (content?.qaCategories.length ?? 0) + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isAll = i == 0;
                      final cat = isAll ? null : content!.qaCategories[i - 1];
                      final active = isAll ? _selectedCategory == null : cat!.name == _selectedCategory;
                      return SelectableChip(
                        label: isAll ? 'All' : cat!.name,
                        selected: active,
                        onTap: () => setState(() => _selectedCategory = isAll ? null : cat!.name),
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
                    itemCount: posts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final post = posts[i];
                      return SoftCard(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => QaDetailPublicScreen(post: post)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(post.category,
                                      style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.forum_outlined,
                                        size: 14,
                                        color: post.answers > 0 ? AppColors.gold : AppColors.outline),
                                    const SizedBox(width: 4),
                                    Text('${post.answers}',
                                        style: AppText.labelCaps.copyWith(
                                            color: post.answers > 0 ? AppColors.goldDark : AppColors.outline)),
                                    const SizedBox(width: 12),
                                    Icon(Icons.visibility_outlined, size: 14, color: AppColors.outline),
                                    const SizedBox(width: 4),
                                    Text('${post.views}',
                                        style: AppText.labelCaps.copyWith(color: AppColors.outline)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(post.title, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Text(post.excerpt,
                                style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                          ],
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
