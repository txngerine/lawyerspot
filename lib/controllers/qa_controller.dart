import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/qa_model.dart';


class QAController extends GetxController {
  final questions = <QuestionModel>[].obs;
  final answers = <AnswerModel>[].obs;
  final myAnswers = <MyAnswerModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();
  final selectedFilter = 'All Areas'.obs;

  static List<String> get filters => mockFilterLabels();

  List<QuestionModel> get filteredQuestions {
    if (selectedFilter.value == 'All Areas') return questions;
    return questions.where((q) => q.area == selectedFilter.value).toList();
  }

  @override
  void onInit() {
    loadQuestions();
    super.onInit();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // questions.value =
      //     await Get.find<QAService>().getQuestions(area: selectedFilter.value);
      questions.value = mockQuestions();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      questions.value = mockQuestions();
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    loadQuestions();
  }

  Future<void> loadAnswers(String questionId) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // answers.value = await Get.find<QAService>().getAnswers(questionId);
      answers.value = mockAnswers();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      answers.value = mockAnswers();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitAnswer(String questionId, String body) async {
    try {
      // TODO: Replace mock with real API call when backend is ready
      // await Get.find<QAService>().submitAnswer(questionId, body);
      await loadAnswers(questionId);
      Get.snackbar('Submitted', 'Answer submitted.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loadMyAnswers() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // myAnswers.value = await Get.find<QAService>().getMyAnswers();
      myAnswers.value = mockMyAnswers();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      myAnswers.value = mockMyAnswers();
    } finally {
      isLoading.value = false;
    }
  }
}
