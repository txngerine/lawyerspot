import 'package:flutter/material.dart';
import '../models/lawyer_model.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class LawyerProfileScreen extends StatelessWidget {
  const LawyerProfileScreen({super.key, required this.lawyer});

  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyer Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _buildHeader(),
          _buildStatsRow(),
          if (lawyer.verified) _buildContactSection(),
          if (lawyer.bio.isNotEmpty) _buildSection('About', Text(lawyer.bio, style: AppText.bodyMd)),
          if (lawyer.specialization.isNotEmpty)
            _buildSection('Specialization', Wrap(
              spacing: 8,
              runSpacing: 8,
              children: lawyer.specialization.map((s) => Chip(
                label: Text(s, style: AppText.bodySm.copyWith(color: AppColors.secondary)),
                backgroundColor: AppColors.accentContainer.withOpacity(0.15),
                side: BorderSide.none,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )).toList(),
            )),
          if (lawyer.languages.isNotEmpty)
            _buildSection('Languages', Wrap(
              spacing: 8,
              runSpacing: 8,
              children: lawyer.languages.map((l) => Chip(
                label: Text(l, style: AppText.bodySm.copyWith(color: AppColors.primary)),
                backgroundColor: AppColors.surfaceContainer,
                side: BorderSide.none,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )).toList(),
            )),
          if (lawyer.education.isNotEmpty) _buildEducationSection(),
          if (lawyer.timeline.isNotEmpty) _buildTimelineSection(),
          if (lawyer.courts.isNotEmpty) _buildCourtsSection(),
          if (lawyer.awards.isNotEmpty) _buildAwardsSection(),
          if (lawyer.practiceGroups.isNotEmpty) _buildPracticeGroups(),
          if (lawyer.clientReviews.isNotEmpty) _buildReviewsSection(),
          if (lawyer.profileFaq.isNotEmpty) _buildFaqSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.surfaceContainerHigh,
                  backgroundImage: lawyer.image.isNotEmpty ? NetworkImage(lawyer.image) : null,
                  child: lawyer.image.isEmpty
                      ? Text(_initials(lawyer.name), style: AppText.displayLg.copyWith(color: AppColors.primary.withOpacity(0.6)))
                      : null,
                ),
                if (lawyer.verified)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 3),
                      ),
                      child: const Icon(Icons.check, size: 16, color: AppColors.accent),
                    ),
                  ),
                if (lawyer.online)
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(BorderSide(color: AppColors.surface, width: 3)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(lawyer.name, style: AppText.headlineMd),
          const SizedBox(height: 4),
          Text(lawyer.practice, style: AppText.bodyMd.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: AppColors.outline),
              const SizedBox(width: 4),
              Text(lawyer.location, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          _statItem('Rating', lawyer.rating.toStringAsFixed(1), Icons.star, AppColors.accent),
          _statDivider(),
          _statItem('Reviews', '${lawyer.reviews}', Icons.reviews_outlined, AppColors.outline),
          _statDivider(),
          _statItem('Experience', '${lawyer.experience} yrs', Icons.business_center_outlined, AppColors.outline),
          _statDivider(),
          _statItem('Fee', '₹${lawyer.fee}', Icons.currency_rupee, AppColors.secondary),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 4),
          Text(value, style: AppText.titleLg.copyWith(fontSize: 15)),
          Text(label, style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.outlineVariant.withOpacity(0.4),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact', style: AppText.titleLg),
          const SizedBox(height: 12),
          if (lawyer.phone.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.phone_outlined, size: 18, color: AppColors.outline),
                  const SizedBox(width: 10),
                  Text(lawyer.phone, style: AppText.bodyMd),
                ],
              ),
            ),
          if (lawyer.email.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 18, color: AppColors.outline),
                const SizedBox(width: 10),
                Text(lawyer.email, style: AppText.bodyMd),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Education', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...lawyer.education.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${e.degree} - ${e.institution}', style: AppText.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                      if (e.year.isNotEmpty)
                        Text(e.year, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Experience', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...lawyer.timeline.map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.title, style: AppText.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                      if (t.org.isNotEmpty)
                        Text(t.org, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      if (t.year.isNotEmpty)
                        Text(t.year, style: AppText.bodySm.copyWith(color: AppColors.outline)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCourtsSection() {
    return _buildSection('Courts', Wrap(
      spacing: 8,
      runSpacing: 8,
      children: lawyer.courts.map((c) => Chip(
        label: Text(c, style: AppText.bodySm.copyWith(color: AppColors.primary)),
        backgroundColor: AppColors.surfaceContainer,
        side: BorderSide.none,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      )).toList(),
    ));
  }

  Widget _buildAwardsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Awards', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...lawyer.awards.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.emoji_events_outlined, size: 18, color: AppColors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title, style: AppText.bodyMd),
                      if (a.year.isNotEmpty)
                        Text(a.year, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPracticeGroups() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Practice Areas', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...lawyer.practiceGroups.map((pg) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pg.title, style: AppText.titleLg.copyWith(fontSize: 15)),
                if (pg.areas.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: pg.areas.map((a) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(a, style: AppText.bodySm.copyWith(color: AppColors.primary)),
                    )).toList(),
                  ),
                ],
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Reviews (${lawyer.clientReviews.length})', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...lawyer.clientReviews.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SoftCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.surfaceContainerHigh,
                        backgroundImage: r.avatar.isNotEmpty ? NetworkImage(r.avatar) : null,
                        child: r.avatar.isEmpty
                            ? Icon(Icons.person_outline, size: 16, color: AppColors.onSurfaceVariant)
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(r.author, style: AppText.titleLg.copyWith(fontSize: 14)),
                                if (r.verified) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.verified, size: 14, color: AppColors.secondary),
                                ],
                              ],
                            ),
                            _ratingRow(r.rating),
                          ],
                        ),
                      ),
                      if (r.date.isNotEmpty)
                        Text(r.date, style: AppText.bodySm.copyWith(color: AppColors.outline, fontSize: 11)),
                    ],
                  ),
                  if (r.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(r.text, style: AppText.bodySm),
                  ],
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FAQ', style: AppText.headlineMd.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          SoftCard(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: lawyer.profileFaq.map((faq) => ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                title: Text(faq.question, style: AppText.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                children: [
                  Text(faq.answer, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingRow(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating.round() ? Icons.star : Icons.star_border,
          size: 12,
          color: AppColors.accent,
        );
      }),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '';
  }
}
