import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import 'notifications_screen.dart';
import 'qa_history_screen.dart';
import 'statistics_screen.dart';
import 'article_management_screen.dart';
import 'conversation_list_screen.dart';
import 'subscription_screen.dart';
import 'change_password_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final profile = Get.find<ProfileController>();
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final userName = auth.sessionUser.value?.name ?? 'Adv. Rajesh';
          final p = profile.profile.value;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              Text('Good morning, $userName', style: AppText.headlineMd),
              const SizedBox(height: 4),
              Text('Here is a summary of your workspace today.',
                  style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StatTile(
                      label: 'Experience',
                      value: '${p?.experience ?? 0} yrs',
                      icon: Icons.work_outline,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatTile(
                      label: 'Rating',
                      value: p != null ? p.rating.toStringAsFixed(1) : '--',
                      icon: Icons.star_outline,
                      caption: '${p?.reviews ?? 0} reviews',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              SoftCard(
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: CircleAvatar(
                        backgroundColor: AppColors.surfaceContainerHigh,
                        backgroundImage: p?.image.isNotEmpty == true
                            ? NetworkImage(p!.image)
                            : null,
                        child: p?.image.isNotEmpty != true
                            ? Text(
                                auth.sessionUser.value?.name.isNotEmpty == true
                                    ? auth.sessionUser.value!.name[0].toUpperCase()
                                    : 'A',
                                style: AppText.titleLg,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p?.name ?? userName, style: AppText.titleLg),
                          const SizedBox(height: 4),
                          Text(p?.practice ?? 'Lawyer',
                              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text('Workspace', style: AppText.headlineMd),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.article_outlined,
                      label: 'My\nArticles',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const ArticleManagementScreen())),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.forum_outlined,
                      label: 'My\nQ&A',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const QAHistoryScreen())),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.insights_outlined,
                      label: 'View\nStatistics',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const StatisticsScreen())),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.chat_outlined,
                      label: 'Messages',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const ConversationListScreen())),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.subscriptions_outlined,
                      label: 'Subscription',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _WorkspaceLink(
                      icon: Icons.lock_outline,
                      label: 'Change\nPassword',
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const ChangePasswordScreen())),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _WorkspaceLink extends StatelessWidget {
  const _WorkspaceLink({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: AppText.labelCaps.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
