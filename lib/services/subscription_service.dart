import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/subscription_model.dart';
import 'base_service.dart';

class SubscriptionService {
  Future<SubscriptionInfo> getSubscription() async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.subscription);
    return SubscriptionInfo.fromJson(response.data as Map<String, dynamic>);
  }

  Future<SubscriptionRenewResponse> renew(String planId) async {
    final response = await BaseService.instance.dio.post(
      ApiConfig.renewSubscription,
      data: {'planId': planId},
    );
    return SubscriptionRenewResponse.fromJson(
        response.data as Map<String, dynamic>);
  }
}
