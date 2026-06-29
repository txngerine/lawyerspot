import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/article_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final cms = Get.find<CmsController>();

    final related = cms.publishedArticles
        .where((a) => a.category == article.category && a.slug != article.slug)
        .take(3)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Hero(
                tag: 'article_${article.slug}',
                child: Image.network(
                  article.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: AppColors.surfaceContainer,
                    child: const Center(child: Icon(Icons.article_outlined, size: 64, color: AppColors.outline)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.goldDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(article.category,
                      style: AppText.labelCaps.copyWith(color: AppColors.goldDark)),
                ),
                if (article.trending) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_up, size: 12, color: AppColors.error),
                        const SizedBox(width: 4),
                        Text('Trending', style: AppText.labelCaps.copyWith(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Text(article.title, style: AppText.displayLgMobile.copyWith(fontSize: 22, height: 1.25)),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surfaceContainer,
                  child: Icon(Icons.person_outline, color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.author, style: AppText.titleLg),
                      Text('${article.date} \u2022 ${article.readTime}',
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(article.content, style: AppText.bodyMd.copyWith(height: 1.7)),
            if (related.isNotEmpty) ...[
              const Divider(height: 32),
              Text('Related Articles', style: AppText.headlineMd),
              const SizedBox(height: 12),
              ...related.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SoftCard(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: a)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            a.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: AppColors.surfaceContainer,
                              child: const Icon(Icons.article_outlined, color: AppColors.outline),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.schedule, size: 12, color: AppColors.outline),
                                  const SizedBox(width: 4),
                                  Text(a.readTime, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
