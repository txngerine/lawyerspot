import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/qa_controller.dart';
import 'question_detail_screen.dart';

class QABrowseScreen extends StatelessWidget {
  const QABrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qa = Get.find<QAController>();
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () {},
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (qa.isLoading.value && qa.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Browse Questions', style: AppText.titleLg.copyWith(fontSize: 19)),
                    const SizedBox(height: 4),
                    Text('Help the community and build your reputation.',
                        style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: Obx(() {
                        final filters = ['All Areas', ...qa.questions.map((q) => q.category).toSet()];
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filters.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, i) {
                            final f = filters[i];
                            final active = f == qa.selectedFilter.value;
                            return SelectableChip(
                              label: f,
                              selected: active,
                              onTap: () => qa.setFilter(f),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: qa.loadQuestions,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    itemCount: qa.filteredQuestions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final q = qa.filteredQuestions[i];
                      return SoftCard(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuestionDetailScreen(
                              question: q.title,
                              body: q.excerpt,
                              questionId: q.id,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(q.category, style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.forum_outlined,
                                        size: 14,
                                        color: q.answers > 0 ? AppColors.gold : AppColors.outline),
                                    const SizedBox(width: 4),
                                    Text('${q.answers} Answer${q.answers == 1 ? '' : 's'}',
                                        style: AppText.labelCaps.copyWith(
                                            color: q.answers > 0 ? AppColors.goldDark : AppColors.outline)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(q.title, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Text(q.excerpt,
                                style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.surfaceContainer,
                                  child: Icon(Icons.person_outline, size: 14, color: AppColors.onSurfaceVariant),
                                ),
                                const SizedBox(width: 8),
                                Text(q.answeredByMe ? 'Answered by you' : 'Open question',
                                    style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
