import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CmsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final about = ctrl.siteContent?.about;
        if (about == null || about.title.isEmpty) {
          return const Center(child: Text('No information available.'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(about.title, style: AppText.headlineMd),
              const SizedBox(height: 16),
              Text(about.body, style: AppText.bodyMd),
            ],
          ),
        );
      }),
    );
  }
}
