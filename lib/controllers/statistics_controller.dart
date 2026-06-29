import 'package:get/get.dart';
import '../models/statistics_model.dart';
import '../services/statistics_service.dart';

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
      stats.value = await Get.find<StatisticsService>().getOverview();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
