import 'package:get/get.dart';
import '../models/consultation_model.dart';
import '../services/consultation_service.dart';

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
      final status = showUpcoming.value ? 'upcoming' : 'past';
      consultations.value =
          await Get.find<ConsultationService>().getConsultations(status);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleTab(bool upcoming) {
    showUpcoming.value = upcoming;
    loadConsultations();
  }
}
