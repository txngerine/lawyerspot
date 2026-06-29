import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/qa_controller.dart';

class QuestionDetailScreen extends StatefulWidget {
  final String question;
  final String body;
  final String questionId;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.body,
    required this.questionId,
  });

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<QAController>().loadQuestionDetail(widget.questionId);
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qa = Get.find<QAController>();
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Question'),
      body: Obx(() {
        if (qa.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final detail = qa.currentQuestion.value;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.question, style: AppText.headlineMd),
                  const SizedBox(height: 12),
                  Text(widget.body, style: AppText.bodyMd),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Your Answer', style: AppText.titleLg),
            const SizedBox(height: 8),
            TextField(
              controller: _answerController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Write your legal answer...',
              ),
            ),
            const SizedBox(height: 12),
            GoldButton(
              label: 'Submit Answer',
              onPressed: () async {
                if (_answerController.text.trim().isEmpty) return;
                await qa.submitAnswer(widget.questionId, _answerController.text.trim());
                _answerController.clear();
              },
            ),
            if (detail?.myAnswer != null) ...[
              const SizedBox(height: 20),
              Text('Your Existing Answer', style: AppText.titleLg),
              const SizedBox(height: 8),
              SoftCard(
                child: Text(detail!.myAnswer!.body, style: AppText.bodyMd),
              ),
            ],
          ],
        );
      }),
    );
  }
}
