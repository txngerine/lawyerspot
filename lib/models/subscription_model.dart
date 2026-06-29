import 'cms_model.dart';

class SubscriptionInfo {
  final String planId;
  final SubscriptionPlan plan;
  final String? expiresAt;
  final String status;
  final List<SubscriptionPlan> availablePlans;

  SubscriptionInfo({
    this.planId = '',
    required this.plan,
    this.expiresAt,
    this.status = 'active',
    this.availablePlans = const [],
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      SubscriptionInfo(
        planId: json['planId'] as String? ?? '',
        plan: SubscriptionPlan.fromJson(
            json['plan'] as Map<String, dynamic>? ?? {}),
        expiresAt: json['expiresAt'] as String?,
        status: json['status'] as String? ?? 'active',
        availablePlans: (json['availablePlans'] as List<dynamic>?)
                ?.map((e) =>
                    SubscriptionPlan.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class SubscriptionRenewResponse {
  final bool success;
  final String planId;
  final String expiresAt;
  final String status;
  final String message;

  SubscriptionRenewResponse({
    this.success = true,
    this.planId = '',
    this.expiresAt = '',
    this.status = 'active',
    this.message = '',
  });

  factory SubscriptionRenewResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionRenewResponse(
        success: json['success'] as bool? ?? true,
        planId: json['planId'] as String? ?? '',
        expiresAt: json['expiresAt'] as String? ?? '',
        status: json['status'] as String? ?? 'active',
        message: json['message'] as String? ?? '',
      );
}
