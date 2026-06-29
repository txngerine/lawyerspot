import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'court_detail_screen.dart';

class CourtsListScreen extends StatefulWidget {
  const CourtsListScreen({super.key});

  @override
  State<CourtsListScreen> createState() => _CourtsListScreenState();
}

class _CourtsListScreenState extends State<CourtsListScreen> {
  final _searchController = TextEditingController();
  final _cms = Get.find<CmsController>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = _cms.siteContent?.courtsPage;
    final courts = _cms.siteContent?.courts ?? [];

    return Scaffold(
      appBar: BrandAppBar(
        showBack: true,
        title: page?.title.isNotEmpty == true ? page!.title : 'Courts',
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

          final filtered = _filterCourts(courts);

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
                    hintText: 'Search courts...',
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
                    final court = filtered[i];
                    return SoftCard(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourtDetailScreen(court: court),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(court.name,
                              style: AppText.titleLg,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          if (court.city.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 14, color: AppColors.outline),
                                const SizedBox(width: 4),
                                Text(court.city,
                                    style: AppText.bodySm.copyWith(
                                        color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  List<CourtEntry> _filterCourts(List<CourtEntry> courts) {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return courts;
    return courts.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.city.toLowerCase().contains(query);
    }).toList();
  }
}
