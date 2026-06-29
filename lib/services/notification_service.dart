import '../models/notification_model.dart';
import 'base_service.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    final response = await BaseService.instance.dio.get('/notifications');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> markAsRead(String id) async {
    await BaseService.instance.dio.put('/notifications/$id/read');
  }
}
