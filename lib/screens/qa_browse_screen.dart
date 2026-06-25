import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'notifications_screen.dart';
import 'question_detail_screen.dart';

class QABrowseScreen extends StatefulWidget {
  const QABrowseScreen({super.key});

  @override
  State<QABrowseScreen> createState() => _QABrowseScreenState();
}

class _QuestionData {
  const _QuestionData({
    required this.area,
    required this.answers,
    required this.title,
    required this.preview,
    required this.author,
    required this.timeAgo,
  });

  final String area;
  final int answers;
  final String title;
  final String preview;
  final String author;
  final String timeAgo;
}

class _QABrowseScreenState extends State<QABrowseScreen> {
  String _filter = 'All Areas';
  static const _filters = ['All Areas', 'Property Law', 'Family Law', 'Corporate', 'Criminal Defense'];

  static const _questions = [
    _QuestionData(
      area: 'Property Law',
      answers: 3,
      title: 'Landlord refusing to return security deposit after 30 days despite no damages. '
          'What are my options?',
      preview: 'I moved out of my apartment in California over a month ago. The walkthrough was '
          "clean, no issues noted. Now the landlord is ghosting my calls and hasn't returned the "
          '\$2000 deposit. Can I sue for triple damages?',
      author: 'Anonymous User',
      timeAgo: '2h ago',
    ),
    _QuestionData(
      area: 'Family Law',
      answers: 0,
      title: 'Modifying child custody agreement due to relocation out of state for work.',
      preview: 'I have been offered a significant promotion that requires moving from NY to TX. '
          'I currently share 50/50 custody. How difficult is it to modify the agreement to allow '
          'me to take the children with me?',
      author: 'Michael T.',
      timeAgo: '5h ago',
    ),
    _QuestionData(
      area: 'Corporate',
      answers: 1,
      title: 'Structuring equity vesting for co-founders in an LLC vs C-Corp.',
      preview: 'We are three co-founders starting a tech company. We want to implement a 4-year '
          'vesting schedule with a 1-year cliff. Are there significant tax or structural differences '
          'if we form an LLC instead of a Delaware C-Corp?',
      author: 'StartupFounder',
      timeAgo: '1d ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All Areas'
        ? _questions
        : _questions.where((q) => q.area == _filter).toList();

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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Browse Questions', style: AppText.titleLg.copyWith(fontSize: 19)),
                  const SizedBox(height: 4),
                  Text('Help the community and build your reputation.',
                      style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final f = _filters[i];
                        final active = f == _filter;
                        return SelectableChip(
                          label: f,
                          selected: active,
                          onTap: () => setState(() => _filter = f),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final q = filtered[i];
                  return SoftCard(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => QuestionDetailScreen(question: q.title, body: q.preview)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(q.area, style: AppText.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
                            ),
                            Row(
                              children: [
                                Icon(Icons.forum_outlined,
                                    size: 14,
                                    color: q.answers > 0 ? AppColors.gold : AppColors.outline),
                                const SizedBox(width: 4),
                                Text('${q.answers} Answer${q.answers == 1 ? '' : 's'}',
                                    style: AppText.labelCaps.copyWith(
                                        color: q.answers > 0 ? AppColors.goldDark : AppColors.outline)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(q.title, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text(q.preview,
                            style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.surfaceContainer,
                              child: Icon(Icons.person_outline, size: 14, color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(width: 8),
                            Text(q.author, style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                            const Spacer(),
                            Text(q.timeAgo, style: AppText.bodySm.copyWith(color: AppColors.outlineVariant)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
