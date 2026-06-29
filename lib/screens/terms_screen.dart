import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CmsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Use')),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final page = ctrl.siteContent?.termsPage;
        if (page == null || page.title.isEmpty) {
          return const Center(child: Text('No information available.'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(page.title, style: AppText.headlineMd),
              if (page.lastUpdated.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Last updated: ${page.lastUpdated}',
                    style: AppText.bodySm.copyWith(color: AppColors.outline)),
              ],
              const SizedBox(height: 16),
              Text(page.body, style: AppText.bodyMd),
            ],
          ),
        );
      }),
    );
  }
}
