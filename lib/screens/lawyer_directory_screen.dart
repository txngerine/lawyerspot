import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/lawyer_model.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class LawyerDirectoryScreen extends StatefulWidget {
  const LawyerDirectoryScreen({super.key});

  @override
  State<LawyerDirectoryScreen> createState() => _LawyerDirectoryScreenState();
}

class _LawyerDirectoryScreenState extends State<LawyerDirectoryScreen> {
  final cmsController = Get.find<CmsController>();

  String _selectedCity = 'All';
  String _selectedPractice = 'All';
  String _sortBy = 'rating';
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    if (cmsController.cmsData.value == null) {
      cmsController.fetchCms();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Lawyer> get _filteredLawyers {
    final cms = cmsController.cmsData.value;
    if (cms == null) return [];

    var lawyers = List<Lawyer>.from(cms.lawyers);

    if (_selectedCity != 'All') {
      final city = _selectedCity.toLowerCase();
      lawyers = lawyers.where((l) =>
        l.citySlug.toLowerCase() == city ||
        l.location.toLowerCase().contains(city)
      ).toList();
    }

    if (_selectedPractice != 'All') {
      final practice = _selectedPractice.toLowerCase();
      lawyers = lawyers.where((l) =>
        l.practice.toLowerCase().contains(practice) ||
        l.specialization.any((s) => s.toLowerCase().contains(practice))
      ).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      lawyers = lawyers.where((l) =>
        l.name.toLowerCase().contains(q) ||
        l.location.toLowerCase().contains(q) ||
        l.practice.toLowerCase().contains(q) ||
        l.firm.toLowerCase().contains(q) ||
        l.bio.toLowerCase().contains(q) ||
        l.specialization.any((s) => s.toLowerCase().contains(q))
      ).toList();
    }

    switch (_sortBy) {
      case 'rating':
        lawyers.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'experience':
        lawyers.sort((a, b) => b.experience.compareTo(a.experience));
        break;
      case 'fee':
        lawyers.sort((a, b) => a.fee.compareTo(b.fee));
        break;
    }

    return lawyers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyers in India'),
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

        final lawyers = _filteredLawyers;

        return RefreshIndicator(
          onRefresh: cmsController.fetchCms,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildFilterBar(cms),
              ),
              if (lawyers.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 48, color: AppColors.outline),
                        const SizedBox(height: 12),
                        Text('No lawyers found', style: AppText.bodyMd),
                        const SizedBox(height: 4),
                        Text('Try adjusting your filters', style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  sliver: SliverList.separated(
                    itemCount: lawyers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) => _buildLawyerCard(lawyers[i]),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFilterBar(CmsData cms) {
    final cities = ['All', ...cms.cities.map((c) => c.name)];
    final practices = ['All', ...cms.practiceAreas.map((p) => p.name)];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search lawyers by name, location, practice...',
              prefixIcon: const Icon(Icons.search, color: AppColors.outline),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
            ),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    labelText: 'City',
                    isDense: true,
                  ),
                  items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c, style: AppText.bodySm))).toList(),
                  onChanged: (v) => setState(() => _selectedCity = v ?? 'All'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedPractice,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    labelText: 'Practice',
                    isDense: true,
                  ),
                  items: practices.map((p) => DropdownMenuItem(value: p, child: Text(p, style: AppText.bodySm, overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (v) => setState(() => _selectedPractice = v ?? 'All'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _sortBy,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    labelText: 'Sort',
                    isDense: true,
                  ),
                  items: [
                    DropdownMenuItem(value: 'rating', child: Text('Rating', style: AppText.bodySm)),
                    DropdownMenuItem(value: 'experience', child: Text('Experience', style: AppText.bodySm)),
                    DropdownMenuItem(value: 'fee', child: Text('Fee (Low)', style: AppText.bodySm)),
                  ],
                  onChanged: (v) => setState(() => _sortBy = v ?? 'rating'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLawyerCard(Lawyer lawyer) {
    return SoftCard(
      onTap: () => Navigator.of(context).pushNamed('/lawyers/${lawyer.slug}'),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.surfaceContainerHigh,
            backgroundImage: lawyer.image.isNotEmpty ? NetworkImage(lawyer.image) : null,
            child: lawyer.image.isEmpty
                ? Text(_initials(lawyer.name), style: AppText.headlineMd.copyWith(color: AppColors.primary.withOpacity(0.6)))
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(lawyer.name, style: AppText.titleLg, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    if (lawyer.verified)
                      const Icon(Icons.verified, size: 18, color: AppColors.secondary),
                    if (lawyer.online) ...[
                      const SizedBox(width: 4),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _ratingRow(lawyer.rating),
                    const SizedBox(width: 6),
                    Text('(${lawyer.reviews})', style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.business_center_outlined, size: 14, color: AppColors.outline),
                    const SizedBox(width: 4),
                    Text('${lawyer.experience} yrs', style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(width: 12),
                    Icon(Icons.location_on_outlined, size: 14, color: AppColors.outline),
                    const SizedBox(width: 4),
                    Expanded(child: Text(lawyer.location, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(lawyer.practice, style: AppText.bodySm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
                if (lawyer.specialization.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: lawyer.specialization.take(3).map((s) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(s, style: AppText.labelCaps.copyWith(color: AppColors.primary, fontSize: 10)),
                    )).toList(),
                  ),
                ],
                const SizedBox(height: 6),
                Text('₹${lawyer.fee}', style: AppText.titleLg.copyWith(color: AppColors.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingRow(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating.round() ? Icons.star : Icons.star_border,
          size: 14,
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
