import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'consultation_detail_screen.dart';
import 'notifications_screen.dart';

class ConsultationsListScreen extends StatefulWidget {
  const ConsultationsListScreen({super.key});

  @override
  State<ConsultationsListScreen> createState() => _ConsultationsListScreenState();
}

class _ConsultationsListScreenState extends State<ConsultationsListScreen> {
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Consultations', style: AppText.displayLg.copyWith(fontSize: 26)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _segment('Upcoming', _showUpcoming, () => setState(() => _showUpcoming = true)),
                        ),
                        Expanded(
                          child: _segment('Past', !_showUpcoming, () => setState(() => _showUpcoming = false)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _showUpcoming ? _upcomingList(context) : _pastList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _segment(String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: active
              ? [BoxShadow(color: AppColors.navy.withOpacity(0.06), blurRadius: 6)]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppText.titleLg.copyWith(
            color: active ? AppColors.navy : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _upcomingList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        _ConsultationCard(
          name: 'Eleanor Vance',
          subject: 'Corporate Restructuring',
          subjectIcon: Icons.business_center_outlined,
          dateLabel: 'Today',
          timeLabel: '10:00 AM',
          actionLabel: 'Join Call',
          highlighted: true,
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ConsultationDetailScreen())),
        ),
        const SizedBox(height: 12),
        _ConsultationCard(
          initials: 'JM',
          name: 'James Morrison',
          subject: 'Intellectual Property Dispute',
          subjectIcon: Icons.gavel_outlined,
          dateLabel: 'Tomorrow, Oct 24',
          timeLabel: '2:30 PM',
          actionLabel: 'Starts in 28h',
          highlighted: false,
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ConsultationDetailScreen())),
        ),
        const SizedBox(height: 12),
        _ConsultationCard(
          name: 'Arthur Pendelton',
          subject: 'Real Estate Trust',
          subjectIcon: Icons.real_estate_agent_outlined,
          dateLabel: 'Thursday, Oct 26',
          timeLabel: '11:15 AM',
          actionLabel: 'Scheduled',
          highlighted: false,
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ConsultationDetailScreen())),
        ),
      ],
    );
  }

  Widget _pastList(BuildContext context) {
    return Center(
      child: Text('No past consultations yet.',
          style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  const _ConsultationCard({
    required this.name,
    required this.subject,
    required this.subjectIcon,
    required this.dateLabel,
    required this.timeLabel,
    required this.actionLabel,
    required this.highlighted,
    required this.onTap,
    this.initials,
  });

  final String name;
  final String subject;
  final IconData subjectIcon;
  final String dateLabel;
  final String timeLabel;
  final String actionLabel;
  final bool highlighted;
  final VoidCallback onTap;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              VerifiedAvatar(size: 48, initials: initials ?? name.substring(0, 1)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppText.titleLg),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(subjectIcon, size: 14, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(subject,
                              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dateLabel, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    Text(timeLabel, style: AppText.headlineMd.copyWith(fontSize: 20)),
                  ],
                ),
              ),
              if (highlighted)
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldLight,
                    foregroundColor: AppColors.navy,
                  ),
                  child: Text(actionLabel),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(actionLabel,
                      style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
