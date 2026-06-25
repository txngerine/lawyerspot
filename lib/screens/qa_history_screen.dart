import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class QAHistoryScreen extends StatelessWidget {
  const QAHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'My Q&A Answers'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text('My Q&A Impact', style: AppText.headlineMd),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SoftCard(
                    child: Column(
                      children: [
                        const Icon(Icons.forum_outlined, size: 32, color: AppColors.navy),
                        const SizedBox(height: 8),
                        Text('24', style: AppText.displayLgMobile),
                        const SizedBox(height: 4),
                        Text('TOTAL ANSWERS', style: AppText.labelCaps),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.lightbulb, size: 32, color: AppColors.gold),
                        const SizedBox(height: 8),
                        Text('18', style: AppText.displayLgMobile.copyWith(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('MARKED HELPFUL', style: AppText.labelCaps.copyWith(color: AppColors.gold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Answers', style: AppText.headlineMd),
                Row(
                  children: [
                    Icon(Icons.filter_list, size: 18, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Icon(Icons.sort, size: 18, color: AppColors.onSurfaceVariant),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _answerCard(
              area: 'Corporate Law',
              date: 'Oct 24, 2023',
              helpful: 12,
              question: 'What are the immediate tax implications of dissolving an LLC in California?',
              preview: 'When dissolving an LLC in California, you must first file a Certificate of '
                  'Cancellation (Form LLC-4/7) with the Secretary of State. The primary tax implication '
                  'involves the final franchise tax payment...',
            ),
            const SizedBox(height: 12),
            _answerCard(
              area: 'Intellectual Property',
              date: 'Oct 18, 2023',
              helpful: 5,
              question: 'Can I trademark a phrase that is commonly used in my specific industry but not registered?',
              preview: 'Trademarking a commonly used phrase within your specific industry can be highly '
                  'challenging. The USPTO generally requires that a trademark be "distinctive"...',
            ),
            const SizedBox(height: 12),
            _answerCard(
              area: 'Real Estate',
              date: 'Oct 12, 2023',
              helpful: 1,
              question: 'How long does a landlord have to return a security deposit in New York?',
              preview: 'Under New York state law, specifically the Housing Stability and Tenant '
                  'Protection Act of 2019, a landlord must return the security deposit within 14 days...',
            ),
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.navy,
                  side: BorderSide(color: AppColors.outlineVariant),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const Text('Load More Answers'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _answerCard({
    required String area,
    required String date,
    required int helpful,
    required String question,
    required String preview,
  }) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(area, style: AppText.labelCaps.copyWith(fontSize: 9)),
                  ),
                  const SizedBox(width: 8),
                  Text(date, style: AppText.bodySm.copyWith(color: AppColors.outline, fontSize: 11)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.goldLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 12, color: AppColors.goldDark),
                    const SizedBox(width: 4),
                    Text('$helpful Helpful', style: AppText.labelCaps.copyWith(fontSize: 9, color: AppColors.goldDark)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(question, style: AppText.titleLg, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(preview,
              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
