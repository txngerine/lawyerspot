import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import 'subscription_screen.dart';
import 'change_password_screen.dart';
import 'conversation_list_screen.dart';
import 'article_management_screen.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final profile = Get.find<ProfileController>();
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () {},
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final p = profile.profile.value;
          final name = auth.sessionUser.value?.name ?? 'Lawyer';
          final practice = p?.practice ?? '';
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              SoftCard(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 8)],
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            backgroundImage: p?.image.isNotEmpty == true
                                ? NetworkImage(p!.image)
                                : null,
                            child: p?.image.isNotEmpty != true
                                ? Text(name[0].toUpperCase(),
                                    style: AppText.titleLg.copyWith(fontSize: 32))
                                : null,
                          ),
                        ),
                        if (p?.verified == true)
                          Positioned(
                            right: 0,
                            bottom: 2,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.verified, size: 15, color: AppColors.accent),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(name, style: AppText.headlineMd),
                    if (practice.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(practice,
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        backgroundColor: AppColors.accentContainer.withOpacity(0.7),
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _settingsGroup(
                title: 'Professional Hub',
                items: [
                  _SettingsItem(Icons.article_outlined, 'My Articles',
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ArticleManagementScreen()))),
                  _SettingsItem(Icons.chat_outlined, 'Messages',
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ConversationListScreen()))),
                  _SettingsItem(Icons.subscriptions_outlined, 'Subscription',
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SubscriptionScreen()))),
                ],
              ),
              const SizedBox(height: 16),

              _settingsGroup(
                title: 'Preferences',
                items: [
                  _SettingsItem(Icons.lock_outline, 'Change Password',
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ChangePasswordScreen()))),
                  _SettingsItem(Icons.help_outline, 'Help & Support', () {}),
                ],
                danger: _SettingsItem(Icons.logout, 'Logout', () {
                  auth.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _settingsGroup({
    required String title,
    required List<_SettingsItem> items,
    _SettingsItem? danger,
  }) {
    return SoftCard(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(title, style: AppText.titleLg),
          ),
          const SizedBox(height: 4),
          ...items.map((item) => ListTile(
                leading: Icon(item.icon, color: AppColors.primary.withOpacity(0.7)),
                title: Text(item.label, style: AppText.bodyMd),
                trailing: const Icon(Icons.chevron_right, color: AppColors.outlineVariant),
                onTap: item.onTap,
              )),
          if (danger != null) ...[
            const Divider(height: 8, indent: 12, endIndent: 12),
            ListTile(
              leading: Icon(danger.icon, color: AppColors.error.withOpacity(0.8)),
              title: Text(danger.label, style: AppText.bodyMd.copyWith(color: AppColors.error)),
              onTap: danger.onTap,
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsItem {
  const _SettingsItem(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
