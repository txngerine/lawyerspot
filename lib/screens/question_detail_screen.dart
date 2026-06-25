import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({super.key, required this.question, required this.body});

  final String question;
  final String body;

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Question Details'),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Property Law',
                            style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                      ),
                      const Spacer(),
                      Text('2h ago', style: AppText.bodySm.copyWith(color: AppColors.outlineVariant)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.question, style: AppText.displayLgMobile.copyWith(fontSize: 22, height: 1.25)),
                  const SizedBox(height: 12),
                  Text(widget.body, style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant, height: 1.5)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.surfaceContainer,
                        child: Icon(Icons.person_outline, color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(width: 10),
                      Text('Anonymous User', style: AppText.titleLg),
                    ],
                  ),
                  const Divider(height: 32),
                  Text('3 Answers from Verified Lawyers', style: AppText.titleLg),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const VerifiedAvatar(size: 40, initials: 'SJ'),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sarah Jenkins, Esq.', style: AppText.titleLg),
                                Text('Real Estate Attorney • CA',
                                    style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Under California Civil Code Section 1950.5, a landlord has 21 days after '
                          'you move out to either return your deposit in full or provide a good faith '
                          'estimate of deductions along with the remaining balance. If they fail to do '
                          'so, they forfeit the right to keep any portion of the deposit for damages, '
                          'cleaning, or unpaid rent. You can indeed sue in small claims court for the '
                          'return of the deposit plus statutory damages of up to twice the amount of '
                          'the deposit if you can prove bad faith retention.',
                          style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.outlineVariant.withOpacity(0.3))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _answerController,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: 'Write your professional answer...'),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Answer submitted.')));
                        _answerController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      child: const Text('Submit Answer'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
