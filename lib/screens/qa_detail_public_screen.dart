import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/qa_controller.dart';
import '../models/qa_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class QaDetailPublicScreen extends StatefulWidget {
  const QaDetailPublicScreen({super.key, required this.post});

  final QaPost post;

  @override
  State<QaDetailPublicScreen> createState() => _QaDetailPublicScreenState();
}

class _QaDetailPublicScreenState extends State<QaDetailPublicScreen> {
  final _qaCtrl = Get.find<QAController>();

  @override
  void initState() {
    super.initState();
    _qaCtrl.loadPublicAnswers(widget.post.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q&A Details'),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final detail = _qaCtrl.publicQaDetail.value;
          final isLoading = _qaCtrl.isLoading.value;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(widget.post.category,
                        style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(widget.post.title, style: AppText.displayLgMobile.copyWith(fontSize: 22, height: 1.25)),
              const SizedBox(height: 12),
              Text(widget.post.content, style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant, height: 1.5)),
              const Divider(height: 32),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (detail == null || detail.answers.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.forum_outlined, size: 48, color: AppColors.outline.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        Text('No answers yet',
                            style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                )
              else ...[
                Text('${detail.answers.length} Answer${detail.answers.length == 1 ? '' : 's'}',
                    style: AppText.titleLg),
                const SizedBox(height: 12),
                ...detail.answers.map(
                  (answer) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SoftCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColors.surfaceContainer,
                                child: Icon(Icons.person_outline, size: 16, color: AppColors.onSurfaceVariant),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(answer.lawyerName, style: AppText.titleLg),
                                    Text(answer.createdAt,
                                        style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(answer.body, style: AppText.bodyMd.copyWith(height: 1.5)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
