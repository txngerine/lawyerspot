import 'package:get/get.dart';
import '../models/dashboard_model.dart';
import '../models/consultation_model.dart';
import '../services/dashboard_service.dart';
import '../services/consultation_service.dart';

class DashboardController extends GetxController {
  final summary = DashboardSummary().obs;
  final consultations = <ConsultationModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();

  @override
  void onInit() {
    loadSummary();
    super.onInit();
  }

  Future<void> loadSummary() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      summary.value = await Get.find<DashboardService>().getSummary();
      consultations.value =
          await Get.find<ConsultationService>().getConsultations('upcoming');
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
