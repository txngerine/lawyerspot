import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/consultation_model.dart';


class ConsultationsController extends GetxController {
  final consultations = <ConsultationModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();
  final showUpcoming = true.obs;

  @override
  void onInit() {
    loadConsultations();
    super.onInit();
  }

  Future<void> loadConsultations() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // final status = showUpcoming.value ? 'upcoming' : 'past';
      // consultations.value =
      //     await Get.find<ConsultationService>().getConsultations(status);
      consultations.value = mockFullUpcomingConsultations();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      consultations.value = mockFullUpcomingConsultations();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleTab(bool upcoming) {
    showUpcoming.value = upcoming;
    loadConsultations();
  }
}
