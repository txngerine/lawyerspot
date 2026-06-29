import 'package:get/get.dart';
import '../models/qa_model.dart';
import '../services/qa_service.dart';

class QAController extends GetxController {
  final questions = <QuestionListItem>[].obs;
  final myAnswers = <Answer>[].obs;
  final currentQuestion = Rxn<QuestionWithAnswer>();
  final publicQaDetail = Rxn<QaDetail>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();
  final selectedFilter = 'All Areas'.obs;

  List<QuestionListItem> get filteredQuestions {
    if (selectedFilter.value == 'All Areas') return questions;
    return questions.where((q) => q.category == selectedFilter.value).toList();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      questions.value = await Get.find<QaService>().listQuestions();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMyAnswers() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      myAnswers.value = await Get.find<QaService>().listMyAnswers();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadQuestionDetail(String id) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      currentQuestion.value = await Get.find<QaService>().getQuestionDetail(id);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitAnswer(String questionId, String body) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<QaService>().submitAnswer(questionId, body);
      await loadQuestionDetail(questionId);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAnswer(String id) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<QaService>().deleteAnswer(id);
      await loadMyAnswers();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPublicAnswers(String slug) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      publicQaDetail.value = await Get.find<QaService>().getPublicAnswers(slug);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    loadQuestions();
  }
}
