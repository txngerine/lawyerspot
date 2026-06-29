import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/qa_model.dart';
import 'base_service.dart';

class QaService {
  Future<List<QuestionListItem>> listQuestions() async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.lawyerQaQuestions);
    debugPrint('[QA] listQuestions response: ${response.data}');
    final list =
        (response.data as Map<String, dynamic>)['questions'] as List<dynamic>;
    return list
        .map((e) => QuestionListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Answer>> listMyAnswers() async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.lawyerQaAnswers);
    debugPrint('[QA] listMyAnswers response: ${response.data}');
    final list =
        (response.data as Map<String, dynamic>)['answers'] as List<dynamic>;
    return list.map((e) => Answer.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<QuestionWithAnswer> getQuestionDetail(String id) async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.lawyerQaQuestion(id));
    debugPrint('[QA] getQuestionDetail response: ${response.data}');
    return QuestionWithAnswer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Answer> submitAnswer(String questionId, String body) async {
    debugPrint('[QA] submitAnswer request data: {questionId: $questionId, body: $body}');
    final response = await BaseService.instance.dio.post(
      ApiConfig.lawyerQaAnswer(questionId),
      data: {'body': body},
    );
    debugPrint('[QA] submitAnswer response: ${response.data}');
    final data =
        (response.data as Map<String, dynamic>)['answer'] as Map<String, dynamic>;
    return Answer.fromJson(data);
  }

  Future<Map<String, dynamic>> deleteAnswer(String id) async {
    debugPrint('[QA] deleteAnswer request id: $id');
    final response =
        await BaseService.instance.dio.delete(ApiConfig.deleteAnswer(id));
    debugPrint('[QA] deleteAnswer response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }

  Future<QaDetail> getPublicAnswers(String slug) async {
    final response = await BaseService.instance.dio.get(ApiConfig.qaAnswers(slug));
    debugPrint('[QA] getPublicAnswers response: ${response.data}');
    return QaDetail.fromJson(response.data as Map<String, dynamic>);
  }
}
