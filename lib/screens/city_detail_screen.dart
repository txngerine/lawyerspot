import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/cms_model.dart';
import '../models/lawyer_model.dart';
import '../theme/app_theme.dart';

class CityDetailScreen extends StatelessWidget {
  final City city;

  const CityDetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CmsController>();

    return Scaffold(
      appBar: AppBar(title: Text(city.name)),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final lawyers = (ctrl.cmsData.value?.lawyers ?? [])
            .where((l) => l.citySlug == city.slug).toList();
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(city.name, style: AppText.headlineMd),
            const SizedBox(height: 4),
            Text(city.state, style: AppText.bodyMd.copyWith(color: AppColors.outline)),
            const SizedBox(height: 20),
            Text('${lawyers.length} Lawyer${lawyers.length == 1 ? '' : 's'} in ${city.name}',
                style: AppText.titleLg),
            const SizedBox(height: 12),
            if (lawyers.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: Text('No lawyers listed in this city yet.',
                      style: AppText.bodyMd.copyWith(color: AppColors.outline)),
                ),
              )
            else
              for (final l in lawyers) _LawyerCard(lawyer: l),
          ],
        );
      }),
    );
  }
}

class _LawyerCard extends StatelessWidget {
  final Lawyer lawyer;

  const _LawyerCard({required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).pushNamed('/lawyers/${lawyer.slug}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.surfaceContainerHigh,
                  backgroundImage: lawyer.image.isNotEmpty
                      ? NetworkImage(lawyer.image)
                      : null,
                  child: lawyer.image.isEmpty
                      ? Text(
                          lawyer.name.isNotEmpty
                              ? lawyer.name[0].toUpperCase()
                              : '?',
                          style: AppText.titleLg.copyWith(color: AppColors.primary.withOpacity(0.6)),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lawyer.name, style: AppText.titleLg),
                      const SizedBox(height: 2),
                      Text(lawyer.practice, style: AppText.bodySm),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (lawyer.rating > 0) ...[
                            Icon(Icons.star, size: 16, color: AppColors.accent),
                            const SizedBox(width: 4),
                            Text(lawyer.rating.toString(),
                                style: AppText.bodySm.copyWith(color: AppColors.secondary)),
                            const SizedBox(width: 12),
                          ],
                          Text(
                            '₹${lawyer.fee}',
                            style: AppText.bodySm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
