import 'package:flutter/material.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';

class GuideDetailScreen extends StatelessWidget {
  final LegalGuide guide;

  const GuideDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(guide.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accentContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(guide.category, style: AppText.bodySm.copyWith(color: AppColors.secondary)),
            ),
            const SizedBox(height: 16),
            Text(guide.title, style: AppText.headlineMd),
            const SizedBox(height: 20),
            Text(
              'Detailed content for this guide will be available soon. '
              'Please check back later or explore other resources.',
              style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
