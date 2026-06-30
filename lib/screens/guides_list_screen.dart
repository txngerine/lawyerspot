import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../models/cms_model.dart';
import '../theme/app_theme.dart';
import 'guide_detail_screen.dart';

class GuidesListScreen extends StatelessWidget {
  const GuidesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CmsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Legal Guides')),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final guides = ctrl.siteContent?.legalGuides ?? <LegalGuide>[];
        if (guides.isEmpty) {
          return const Center(child: Text('No guides available.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: guides.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final guide = guides[index];
            return Card(
              child: ListTile(
                title: Text(guide.title, style: AppText.titleLg),
                subtitle: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(guide.category, style: AppText.bodySm.copyWith(color: AppColors.secondary)),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GuideDetailScreen(guide: guide),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
