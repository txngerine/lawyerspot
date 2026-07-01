import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/statistics_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<StatisticsController>();
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Statistics'),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.errorMessage.value != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ctrl.errorMessage.value!, style: AppText.bodyMd),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: ctrl.loadStatistics,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final s = ctrl.stats.value;
        return SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              Text('Performance Overview', style: AppText.headlineMd),
              const SizedBox(height: 4),
              Text('Your practice statistics for the last 30 days.',
                  style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _ratingCard(s.rating, s.reviewCount)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatTile(
                      label: 'Total Clients',
                      value: '${s.totalClients}',
                      icon: Icons.groups_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatTile(
                      label: 'Response Rate',
                      value: '${s.responseRate}%',
                      icon: Icons.forum_outlined,
                      caption: 'Avg. ${s.averageResponseHours.toStringAsFixed(1)} hrs',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (s.weeklyConsultations.isNotEmpty)
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Consultations Booked', style: AppText.titleLg),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: s.weeklyConsultations.asMap().entries.map((e) {
                            final maxVal = s.weeklyConsultations.reduce(
                                (a, b) => a > b ? a : b);
                            final fraction = maxVal > 0 ? e.value / maxVal : 0.0;
                            final highlighted = e.key == s.weeklyConsultations.length - 1;
                            return _bar('W${e.key + 1}', fraction, highlighted);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Profile Views', style: AppText.titleLg),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text('30 Days', style: AppText.labelCaps),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('${s.profileViews} views',
                        style: AppText.displayLgMobile),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _ratingCard(double rating, int reviewCount) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CapsLabel('Avg. Rating'),
                  const SizedBox(height: 6),
                  Text(rating.toStringAsFixed(1), style: AppText.displayLgMobile),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.accentContainer.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: const Icon(Icons.star, color: AppColors.secondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < rating.round() ? Icons.star : Icons.star_border,
                size: 16,
                color: AppColors.secondary,
              );
            }),
          ),
          const SizedBox(height: 6),
          Text('Based on $reviewCount reviews',
              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _bar(String label, double heightFraction, bool highlighted) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${(heightFraction * 28).round()}',
              style: AppText.labelCaps.copyWith(
                fontSize: 10,
                color: highlighted ? AppColors.primary : AppColors.onSurfaceVariant,
                fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            FractionallySizedBox(
              heightFactor: heightFraction.clamp(0.05, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: highlighted ? AppColors.accentContainer : AppColors.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: AppText.labelCaps.copyWith(
                    color: highlighted ? AppColors.primary : AppColors.onSurfaceVariant,
                    fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
