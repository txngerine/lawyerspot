import '../config/api_config.dart';
import '../models/notification_model.dart';
import 'base_service.dart';

class NotificationService extends BaseService {
  Future<List<NotificationModel>> getNotifications() async {
    final response = await get(ApiConfig.notifications);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load notifications');
    }
    final list = response.body as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> markAsRead(String id) async {
    final response = await put(ApiConfig.notificationRead(id), {});
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to mark notification as read');
    }
  }
}
