import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../controllers/section_controller.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class BnsSectionsScreen extends StatefulWidget {
  const BnsSectionsScreen({super.key});

  @override
  State<BnsSectionsScreen> createState() => _BnsSectionsScreenState();
}

class _BnsSectionsScreenState extends State<BnsSectionsScreen> {
  final _searchController = TextEditingController();
  final _cms = Get.find<CmsController>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = _cms.siteContent?.bnsPage;
    final sections = _cms.siteContent?.bnsSections ?? [];

    return Scaffold(
      appBar: BrandAppBar(
        showBack: true,
        title: page?.title.isNotEmpty == true ? page!.title : 'BNS Sections',
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (_cms.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_cms.errorMessage.value != null) {
            return Center(
              child: Text(_cms.errorMessage.value!,
                  style: AppText.bodyMd, textAlign: TextAlign.center),
            );
          }

          final filtered = _filterSections(sections);

          return Column(
            children: [
              if (page?.subtitle.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Text(page!.subtitle,
                      style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search sections...',
                    prefixIcon: Icon(Icons.search, size: 20),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final section = filtered[i];
                    return SoftCard(
                      onTap: () => Get.find<SectionController>()
                          .loadSection(section.slug),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(section.code,
                                style: AppText.labelCaps.copyWith(color: AppColors.secondary)),
                          ),
                          const SizedBox(height: 10),
                          Text(section.title,
                              style: AppText.titleLg,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          if (section.body.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              section.body.length > 100
                                  ? '${section.body.substring(0, 100)}...'
                                  : section.body,
                              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (page?.footerNote.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: Text(page!.footerNote,
                      style: AppText.bodySm.copyWith(color: AppColors.outline),
                      textAlign: TextAlign.center),
                ),
            ],
          );
        }),
      ),
    );
  }

  List<BnsSectionEntry> _filterSections(List<BnsSectionEntry> sections) {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return sections;
    return sections.where((s) {
      return s.title.toLowerCase().contains(query) ||
          s.code.toLowerCase().contains(query);
    }).toList();
  }
}
