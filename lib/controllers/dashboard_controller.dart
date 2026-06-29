import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/dashboard_model.dart';


class DashboardController extends GetxController {
  final summary = DashboardSummary().obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();
  final consultations = mockUpcomingConsultations().obs;

  @override
  void onInit() {
    loadSummary();
    super.onInit();
  }

  Future<void> loadSummary() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // summary.value = await Get.find<DashboardService>().getSummary();
      summary.value = mockDashboardSummary();
      consultations.value = mockUpcomingConsultations();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      // Fall back to mock data on error
      summary.value = mockDashboardSummary();
      consultations.value = mockUpcomingConsultations();
    } finally {
      isLoading.value = false;
    }
  }
}
