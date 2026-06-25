import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ConsultationDetailScreen extends StatelessWidget {
  const ConsultationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Consultation Detail'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Center(
              child: Column(
                children: [
                  Text('Thursday, October 26', style: AppText.headlineMd),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.schedule, size: 18, color: AppColors.navy.withOpacity(0.7)),
                      const SizedBox(width: 6),
                      Text('10:00 AM - 11:00 AM EST',
                          style: AppText.titleLg.copyWith(color: AppColors.navy.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.video_camera_front_outlined),
                label: const Text('JOIN CALL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.navy,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const VerifiedAvatar(size: 56, initials: 'EV'),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Eleanor Vance', style: AppText.titleLg),
                            const SizedBox(height: 2),
                            Text('Corporate Restructuring Inquiry',
                                style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _infoColumn('Email', 'e.vance@vancecorp.com'),
                      ),
                      Expanded(
                        child: _infoColumn('Phone', '+1 (555) 019-8273'),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  CapsLabel('Reason for Consultation', color: AppColors.outline),
                  const SizedBox(height: 8),
                  Text(
                    'Client is seeking preliminary advice regarding a potential merger with '
                    'a competitor. They need guidance on anti-trust compliance and an overview '
                    'of the required regulatory filings before proceeding with formal negotiations.',
                    style: AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lock_outline, size: 18, color: AppColors.outline),
                          const SizedBox(width: 8),
                          Text('Private Notes', style: AppText.titleLg),
                        ],
                      ),
                      Text('AUTO-SAVED', style: AppText.labelCaps.copyWith(color: AppColors.outline)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Add private notes for this consultation...',
                      fillColor: AppColors.ivory,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.gold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Attached Documents', style: AppText.titleLg),
                      Text('VIEW ALL', style: AppText.labelCaps.copyWith(color: AppColors.navy)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.description_outlined, color: AppColors.navy),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vance_Merger_Brief.pdf',
                                  style: AppText.bodySm.copyWith(fontWeight: FontWeight.w700, color: AppColors.navy)),
                              Text('Added Oct 24 • 2.4 MB',
                                  style: AppText.labelCaps.copyWith(fontSize: 10, color: AppColors.outline)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CapsLabel(label, color: AppColors.outline),
        const SizedBox(height: 4),
        Text(value, style: AppText.bodyMd.copyWith(color: AppColors.navy)),
      ],
    );
  }
}
