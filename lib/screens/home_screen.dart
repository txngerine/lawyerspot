import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cmsController = Get.find<CmsController>();

  @override
  void initState() {
    super.initState();
    if (cmsController.cmsData.value == null) {
      cmsController.fetchCms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LawyerSpot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context).pushNamed('/search'),
          ),
        ],
      ),
      body: Obx(() {
        if (cmsController.isLoading.value && cmsController.cmsData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cmsController.errorMessage.value != null && cmsController.cmsData.value == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cmsController.errorMessage.value!, style: AppText.bodyMd, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  GoldButton(label: 'Retry', onPressed: cmsController.fetchCms),
                ],
              ),
            ),
          );
        }
        final cms = cmsController.cmsData.value;
        if (cms == null) return const SizedBox();

        return RefreshIndicator(
          onRefresh: cmsController.fetchCms,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              _buildHeroSection(cms),
              _buildStatsRow(cms.stats),
              _buildSectionTitle('Practice Areas'),
              _buildPracticeAreasGrid(cms.practiceAreas),
              _buildSectionTitle('Top Lawyers'),
              _buildTopLawyersCarousel(),
              _buildSectionTitle('Latest Articles'),
              _buildArticlesList(),
              _buildSectionTitle('Questions & Answers'),
              _buildQaList(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeroSection(CmsData cms) {
    final hero = cms.siteContent.hero;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hero.title, style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.primary)),
          const SizedBox(height: 8),
          Text(hero.subtitle, style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
          if (hero.badges.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: hero.badges.map((badge) => Chip(
                label: Text(badge, style: AppText.labelCaps.copyWith(color: AppColors.secondary)),
                backgroundColor: AppColors.accentContainer.withOpacity(0.15),
                side: BorderSide.none,
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(List<StatItem> stats) {
    if (stats.isEmpty) return const SizedBox();
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: stats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final stat = stats[i];
          return Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stat.value, style: AppText.displayLg.copyWith(fontSize: 24)),
                Text(stat.label, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(title, style: AppText.headlineMd),
    );
  }

  Widget _buildPracticeAreasGrid(List<PracticeArea> areas) {
    if (areas.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: areas.length,
        itemBuilder: (context, i) {
          final area = areas[i];
          return SoftCard(
            onTap: () => Navigator.of(context).pushNamed('/practice/${area.slug}'),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(area.name, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('${area.lawyers} Lawyers', style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopLawyersCarousel() {
    final lawyers = cmsController.topLawyers;
    if (lawyers.isEmpty) return const SizedBox();
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: lawyers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final lawyer = lawyers[i];
          return SizedBox(
            width: 200,
            child: SoftCard(
              onTap: () => Navigator.of(context).pushNamed('/lawyers/${lawyer.slug}'),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.surfaceContainerHigh,
                        backgroundImage: lawyer.image.isNotEmpty ? NetworkImage(lawyer.image) : null,
                        child: lawyer.image.isEmpty
                            ? Text(_initials(lawyer.name), style: AppText.titleLg.copyWith(color: AppColors.primary.withOpacity(0.6)))
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lawyer.name, style: AppText.titleLg.copyWith(fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text(lawyer.practice, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _ratingRow(lawyer.rating),
                  const SizedBox(height: 4),
                  Text('₹${lawyer.fee}', style: AppText.titleLg.copyWith(color: AppColors.secondary)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticlesList() {
    final articles = cmsController.publishedArticles.where((a) => a.trending).toList();
    if (articles.isEmpty) return const SizedBox();
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: articles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final article = articles[i];
          return SizedBox(
            width: 220,
            child: SoftCard(
              onTap: () => Navigator.of(context).pushNamed('/articles/${article.slug}'),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: AppColors.surfaceContainerHigh,
                      child: article.image.isNotEmpty
                          ? Image.network(article.image, fit: BoxFit.cover)
                          : const Icon(Icons.article_outlined, color: AppColors.outline),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.category, style: AppText.labelCaps.copyWith(color: AppColors.secondary)),
                        const SizedBox(height: 4),
                        Text(article.title, style: AppText.titleLg.copyWith(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(article.author, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQaList() {
    final qas = cmsController.publishedQaPosts;
    if (qas.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: qas.take(5).map((qa) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SoftCard(
            onTap: () => Navigator.of(context).pushNamed('/qa/${qa.slug}'),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(qa.category, style: AppText.labelCaps.copyWith(color: AppColors.secondary)),
                      const SizedBox(height: 4),
                      Text(qa.title, style: AppText.titleLg.copyWith(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    Icon(Icons.forum_outlined, size: 18, color: qa.answers > 0 ? AppColors.accent : AppColors.outline),
                    const SizedBox(height: 2),
                    Text('${qa.answers}', style: AppText.bodySm.copyWith(color: qa.answers > 0 ? AppColors.secondary : AppColors.outline)),
                  ],
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _ratingRow(double rating) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          i < rating.round() ? Icons.star : Icons.star_border,
          size: 16,
          color: AppColors.accent,
        );
      }),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '';
  }
}
