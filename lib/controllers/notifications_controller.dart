import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/notification_model.dart';


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
      // TODO: Replace mock with real API call when backend is ready
      // notifications.value =
      //     await Get.find<NotificationService>().getNotifications();
      notifications.value = mockNotifications();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      notifications.value = mockNotifications();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      // TODO: Replace mock with real API call when backend is ready
      // await Get.find<NotificationService>().markAsRead(id);
      await loadNotifications();
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
