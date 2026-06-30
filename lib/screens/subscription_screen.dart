import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/subscription_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _controller = Get.find<SubscriptionController>();

  @override
  void initState() {
    super.initState();
    _controller.loadSubscription();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.success;
      case 'expiring_soon':
        return AppColors.secondary;
      case 'expired':
        return AppColors.error;
      default:
        return AppColors.outline;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Active';
      case 'expiring_soon':
        return 'Expiring Soon';
      case 'expired':
        return 'Expired';
      default:
        return status;
    }
  }

  Future<void> _confirmRenew(String planId, String planName) async {
    final confirmed = await Get.defaultDialog<bool>(
      title: 'Change Plan',
      middleText: 'Switch to $planName?',
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(result: true),
    );
    if (confirmed == true) {
      await _controller.renew(planId);
      if (_controller.errorMessage.value == null) {
        Get.snackbar('Success', 'Subscription updated', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', _controller.errorMessage.value!, snackPosition: SnackPosition.BOTTOM);
        _controller.errorMessage.value = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Subscription'),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.subscription.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.errorMessage.value != null && _controller.subscription.value == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_controller.errorMessage.value!, style: AppText.bodyMd),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _controller.loadSubscription,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final sub = _controller.subscription.value;
        if (sub == null) {
          return Center(child: Text('No subscription info', style: AppText.bodyMd));
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sub.plan.name, style: AppText.headlineMd),
                            const SizedBox(height: 4),
                            Text(
                              '${sub.plan.currency} ${sub.plan.priceMonthly}/mo',
                              style: AppText.titleLg.copyWith(color: AppColors.secondary),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: _statusColor(sub.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          _statusLabel(sub.status),
                          style: AppText.labelCaps.copyWith(color: _statusColor(sub.status)),
                        ),
                      ),
                    ],
                  ),
                  if (sub.expiresAt != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.event, size: 14, color: AppColors.outline),
                        const SizedBox(width: 6),
                        Text('Expires: ${sub.expiresAt}', style: AppText.bodySm),
                      ],
                    ),
                  ],
                  if (sub.plan.features.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    Text('Features', style: AppText.titleLg),
                    const SizedBox(height: 8),
                    ...sub.plan.features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                            const SizedBox(width: 8),
                            Expanded(child: Text(f, style: AppText.bodySm)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (sub.availablePlans.isNotEmpty) ...[
              const SizedBox(height: 28),
              Text('Available Plans', style: AppText.headlineMd),
              const SizedBox(height: 16),
              ...sub.availablePlans
                  .where((p) => p.active && p.id != sub.planId)
                  .map(
                    (plan) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SoftCard(
                        borderColor: plan.highlight ? AppColors.secondary : null,
                        onTap: () => _confirmRenew(plan.id, plan.name),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(plan.name, style: AppText.titleLg),
                                ),
                                Text(
                                  '${plan.currency} ${plan.priceMonthly}/mo',
                                  style: AppText.titleLg.copyWith(color: AppColors.secondary),
                                ),
                              ],
                            ),
                            if (plan.description.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(plan.description, style: AppText.bodySm),
                            ],
                            if (plan.features.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              ...plan.features.map(
                                (f) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check, size: 14, color: AppColors.success),
                                      const SizedBox(width: 6),
                                      Expanded(child: Text(f, style: AppText.bodySm.copyWith(fontSize: 12))),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            GoldButton(
                              label: 'Switch to ${plan.name}',
                              onPressed: () => _confirmRenew(plan.id, plan.name),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          ],
        );
      }),
    );
  }
}
