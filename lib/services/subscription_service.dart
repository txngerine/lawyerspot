import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/subscription_model.dart';
import 'base_service.dart';

class SubscriptionService {
  Future<SubscriptionInfo> getSubscription() async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.subscription);
    debugPrint('[Subscription] getSubscription response: ${response.data}');
    return SubscriptionInfo.fromJson(response.data as Map<String, dynamic>);
  }

  Future<SubscriptionRenewResponse> renew(String planId) async {
    debugPrint('[Subscription] renew request data: {planId: $planId}');
    final response = await BaseService.instance.dio.post(
      ApiConfig.renewSubscription,
      data: {'planId': planId},
    );
    debugPrint('[Subscription] renew response: ${response.data}');
    return SubscriptionRenewResponse.fromJson(
        response.data as Map<String, dynamic>);
  }
}
