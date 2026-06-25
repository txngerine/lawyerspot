import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'edit_profile_screen.dart';
import 'consultations_list_screen.dart';
import 'qa_history_screen.dart';
import 'statistics_screen.dart';
import 'notifications_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
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
                          boxShadow: [BoxShadow(color: AppColors.navy.withOpacity(0.06), blurRadius: 8)],
                        ),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.surfaceContainerHigh,
                          child: Icon(Icons.person, size: 40, color: AppColors.navy),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 2,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.navy,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.verified, size: 15, color: AppColors.gold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Eleanor Vance, Esq.', style: AppText.headlineMd),
                  const SizedBox(height: 2),
                  Text('Senior Partner • Corporate Law',
                      style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.navy,
                      backgroundColor: AppColors.goldLight.withOpacity(0.7),
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
                _SettingsItem(Icons.person_outline, 'My Profile',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
                _SettingsItem(Icons.event_note_outlined, 'My Consultations',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConsultationsListScreen()))),
                _SettingsItem(Icons.forum_outlined, 'My Q&A Answers',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QAHistoryScreen()))),
                _SettingsItem(Icons.bar_chart_outlined, 'Statistics',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StatisticsScreen()))),
              ],
            ),
            const SizedBox(height: 16),

            _settingsGroup(
              title: 'Preferences',
              items: [
                _SettingsItem(Icons.notifications_active_outlined, 'Notification Preferences', () {}),
                _SettingsItem(Icons.account_balance_outlined, 'Bank/Payment Details', () {}),
                _SettingsItem(Icons.help_outline, 'Help & Support', () {}),
              ],
              danger: _SettingsItem(Icons.logout, 'Logout', () {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pro Status Active',
                            style: AppText.titleLg.copyWith(color: AppColors.gold)),
                        const SizedBox(height: 4),
                        Text(
                          'Your verified lawyer status is current. Next document review is '
                          'scheduled for Oct 2024.',
                          style: AppText.bodySm.copyWith(color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.gold,
                      side: const BorderSide(color: AppColors.gold),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Details'),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                leading: Icon(item.icon, color: AppColors.navy.withOpacity(0.7)),
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
