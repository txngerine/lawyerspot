import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'consultation_detail_screen.dart';
import 'notifications_screen.dart';
import 'qa_history_screen.dart';
import 'statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
            Text('Good morning, Adv. Rajesh', style: AppText.headlineMd),
            const SizedBox(height: 4),
            Text('Here is a summary of your workspace today.',
                style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Consultations',
                    value: '42',
                    icon: Icons.event_note_outlined,
                    caption: 'This Month',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatTile(
                    label: 'Q&A Answers',
                    value: '128',
                    icon: Icons.forum_outlined,
                    caption: 'All Time',
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: 0.85,
                          strokeWidth: 5,
                          backgroundColor: AppColors.goldDark.withOpacity(0.1),
                          color: AppColors.goldDark,
                        ),
                        Text('85%', style: AppText.labelCaps.copyWith(color: AppColors.navy)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profile Quality', style: AppText.titleLg),
                        const SizedBox(height: 4),
                        Text('Add case histories to reach 100%.',
                            style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Action required banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.goldLight.withOpacity(0.18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.goldLight.withOpacity(0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.goldDark),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Action Required', style: AppText.titleLg),
                        const SizedBox(height: 4),
                        Text(
                          'Your recent bar council ID upload is pending verification. '
                          'Expedite the process by reviewing the document clarity.',
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Text('REVIEW SUBMISSION',
                            style: AppText.labelCaps.copyWith(color: AppColors.goldDark)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Consultations", style: AppText.headlineMd),
                Text('View All',
                    style: AppText.labelCaps.copyWith(color: AppColors.goldDark)),
              ],
            ),
            const SizedBox(height: 12),
            SoftCard(
              borderColor: AppColors.goldDark,
              child: _ConsultationRow(
                initials: 'SK',
                name: 'Sanjay Kumar',
                time: '10:30 AM (In 5 mins)',
                actionLabel: 'Join Call',
                highlighted: true,
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const ConsultationDetailScreen())),
              ),
            ),
            const SizedBox(height: 10),
            SoftCard(
              child: Opacity(
                opacity: 0.85,
                child: _ConsultationRow(
                  initials: 'AM',
                  name: 'Anita Menon',
                  time: '02:00 PM',
                  actionLabel: 'Details',
                  highlighted: false,
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const ConsultationDetailScreen())),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text('Workspace', style: AppText.headlineMd),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _WorkspaceLink(
                    icon: Icons.manage_accounts_outlined,
                    label: 'Manage\nProfile',
                    onTap: () {},
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
          ],
        ),
      ),
    );
  }
}

class _ConsultationRow extends StatelessWidget {
  const _ConsultationRow({
    required this.initials,
    required this.name,
    required this.time,
    required this.actionLabel,
    required this.highlighted,
    required this.onTap,
  });

  final String initials;
  final String name;
  final String time;
  final String actionLabel;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VerifiedAvatar(size: 48, initials: initials),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppText.titleLg),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 14, color: AppColors.outline),
                  const SizedBox(width: 4),
                  Text(time, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                ],
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: highlighted ? AppColors.gold : AppColors.surfaceContainer,
            foregroundColor: highlighted ? AppColors.navy : AppColors.navy,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: const StadiumBorder(),
          ),
          child: Text(actionLabel, style: AppText.labelCaps.copyWith(color: AppColors.navy)),
        ),
      ],
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
          Icon(icon, color: AppColors.navy),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: AppText.labelCaps.copyWith(color: AppColors.navy)),
        ],
      ),
    );
  }
}
