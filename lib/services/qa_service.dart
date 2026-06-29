import '../config/api_config.dart';
import '../models/qa_model.dart';
import 'base_service.dart';

class QAService extends BaseService {
  Future<List<QuestionModel>> getQuestions({String? area}) async {
    final query = <String, String>{};
    if (area != null && area != 'All Areas') {
      query['area'] = area;
    }
    final response = await get(ApiConfig.questions, query: query);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load questions');
    }
    final list = response.body as List<dynamic>;
    return list
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<QuestionModel> getQuestion(String id) async {
    final response = await get(ApiConfig.question(id));
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load question');
    }
    return QuestionModel.fromJson(response.body as Map<String, dynamic>);
  }

  Future<List<AnswerModel>> getAnswers(String questionId) async {
    final response = await get(ApiConfig.questionAnswers(questionId));
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load answers');
    }
    final list = response.body as List<dynamic>;
    return list
        .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> submitAnswer(String questionId, String body) async {
    final response =
        await post(ApiConfig.questionAnswers(questionId), {'body': body});
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to submit answer');
    }
  }

  Future<List<MyAnswerModel>> getMyAnswers() async {
    final response = await get(ApiConfig.myAnswers);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load my answers');
    }
    final list = response.body as List<dynamic>;
    return list
        .map((e) => MyAnswerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
