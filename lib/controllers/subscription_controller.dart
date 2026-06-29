import 'package:get/get.dart';
import '../models/subscription_model.dart';
import '../services/subscription_service.dart';

class SubscriptionController extends GetxController {
  final subscription = Rxn<SubscriptionInfo>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  Future<void> loadSubscription() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      subscription.value = await Get.find<SubscriptionService>().getSubscription();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> renew(String planId) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<SubscriptionService>().renew(planId);
      await loadSubscription();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
