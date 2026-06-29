import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/qa_controller.dart';

class QAHistoryScreen extends StatelessWidget {
  const QAHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qa = Get.find<QAController>();
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'My Q&A Answers'),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (qa.isLoading.value && qa.myAnswers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              Text('My Q&A Impact', style: AppText.headlineMd),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SoftCard(
                      child: Column(
                        children: [
                          const Icon(Icons.forum_outlined, size: 32, color: AppColors.navy),
                          const SizedBox(height: 8),
                          Text('${qa.myAnswers.length}', style: AppText.displayLgMobile),
                          const SizedBox(height: 4),
                          Text('TOTAL ANSWERS', style: AppText.labelCaps),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.navy,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.lightbulb, size: 32, color: AppColors.gold),
                          const SizedBox(height: 8),
                          Text('${qa.myAnswers.length}', style: AppText.displayLgMobile.copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('ANSWERS', style: AppText.labelCaps.copyWith(color: AppColors.gold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text('Recent Answers', style: AppText.headlineMd),
              const SizedBox(height: 12),
              ...qa.myAnswers.map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SoftCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (a.questionCategory != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceContainer,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Text(a.questionCategory!,
                                          style: AppText.labelCaps.copyWith(fontSize: 9)),
                                    ),
                                  if (a.createdAt.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    Text(a.createdAt,
                                        style: AppText.bodySm.copyWith(
                                            color: AppColors.outline, fontSize: 11)),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (a.questionTitle != null)
                            Text(a.questionTitle!, style: AppText.titleLg, maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 6),
                          Text(a.body,
                              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
