import 'package:flutter/material.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class CourtDetailScreen extends StatelessWidget {
  const CourtDetailScreen({
    super.key,
    required this.court,
  });

  final CourtEntry court;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        showBack: true,
        title: court.name,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(court.name, style: AppText.displayLgMobile),
              if (court.city.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: AppColors.outline),
                    const SizedBox(width: 6),
                    Text(court.city,
                        style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ],
              if (court.body.isNotEmpty) ...[
                const SizedBox(height: 20),
                SoftCard(
                  child: Text(court.body,
                      style: AppText.bodyMd,
                      textAlign: TextAlign.justify),
                ),
              ],
              if (court.metaTitle.isNotEmpty || court.metaDescription.isNotEmpty) ...[
                const SizedBox(height: 24),
                if (court.metaTitle.isNotEmpty) ...[
                  Text('Meta Title', style: AppText.headlineMd),
                  const SizedBox(height: 6),
                  Text(court.metaTitle,
                      style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                ],
                if (court.metaDescription.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text('Meta Description', style: AppText.headlineMd),
                  const SizedBox(height: 6),
                  Text(court.metaDescription,
                      style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
