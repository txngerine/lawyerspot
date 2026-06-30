import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Notifications'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text('Stay updated on your practice.',
                style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 20),

            Row(
              children: [
                Text('Today', style: AppText.headlineMd),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text('2 New', style: AppText.labelCaps.copyWith(fontSize: 9, color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _notificationCard(
              icon: Icons.event_outlined,
              title: 'Consultation Reminder',
              subtitle: 'Upcoming video call with Sarah Jenkins regarding Family Law.',
              trailing: '10:00 AM',
              unread: true,
              action: 'Join Call',
            ),
            const SizedBox(height: 10),
            _notificationCard(
              icon: Icons.quiz_outlined,
              title: 'New Q&A Inquiry',
              subtitle: 'A verified user asked a new question in Corporate Structuring.',
              trailing: '2h ago',
              unread: true,
            ),
            const SizedBox(height: 28),

            Text('Earlier', style: AppText.headlineMd.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 12),
            _notificationCard(
              icon: Icons.verified_outlined,
              title: 'Verification Approved',
              subtitle: 'Your Bar Association credentials have been successfully verified.',
              trailing: 'Yesterday',
              unread: false,
            ),
            const SizedBox(height: 10),
            _notificationCard(
              icon: Icons.star_outline,
              title: 'New 5-Star Review',
              subtitle: '"Excellent counsel and very responsive..." - Client A.',
              trailing: 'Mon',
              unread: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required bool unread,
    String? action,
  }) {
    return SoftCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (unread)
            Container(width: 3, height: 56, color: AppColors.accentContainer, margin: const EdgeInsets.only(right: 12))
          else
            const SizedBox(width: 0),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: AppText.titleLg)),
                    Text(trailing,
                        style: AppText.labelCaps.copyWith(
                            color: unread ? AppColors.secondary : AppColors.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                if (action != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accentContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(action, style: AppText.labelCaps.copyWith(color: AppColors.primary)),
                  ),
                ],
              ],
            ),
          ),
          if (unread)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(left: 8, top: 4),
              decoration: const BoxDecoration(color: AppColors.accentContainer, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
