import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/statistics_model.dart';


class StatisticsController extends GetxController {
  final stats = StatisticsModel().obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();

  @override
  void onInit() {
    loadStatistics();
    super.onInit();
  }

  Future<void> loadStatistics() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // stats.value = await Get.find<StatisticsService>().getOverview();
      stats.value = mockStatistics();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      stats.value = mockStatistics();
    } finally {
      isLoading.value = false;
    }
  }
}
