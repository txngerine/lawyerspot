import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationsController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();

  @override
  void onInit() {
    loadNotifications();
    super.onInit();
  }

  List<NotificationModel> get todayNotifications =>
      notifications.where((n) => n.trailing.contains(':')).toList();

  List<NotificationModel> get earlierNotifications =>
      notifications.where((n) => !n.trailing.contains(':')).toList();

  Future<void> loadNotifications() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      notifications.value =
          await Get.find<NotificationService>().getNotifications();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await Get.find<NotificationService>().markAsRead(id);
      await loadNotifications();
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
