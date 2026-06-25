// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Statistics'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text('Performance Overview', style: AppText.headlineMd),
            const SizedBox(height: 4),
            Text('Your practice statistics for the last 30 days.',
                style:
                    AppText.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _ratingCard()),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatTile(
                    label: 'Total Clients',
                    value: '87',
                    icon: Icons.groups_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatTile(
                    label: 'Response Rate',
                    value: '98%',
                    icon: Icons.forum_outlined,
                    caption: 'Avg. 2.4 hrs',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Consultations Booked', style: AppText.titleLg),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 140,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _bar('W1', 0.4, false),
                        _bar('W2', 0.65, false),
                        _bar('W3', 0.85, true),
                        _bar('W4', 0.5, false),
                      ],
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
                      Text('Profile Views', style: AppText.titleLg),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text('30 Days', style: AppText.labelCaps),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CustomPaint(painter: _LineChartPainter()),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Oct 1',
                          style: AppText.labelCaps.copyWith(fontSize: 10)),
                      Text('Oct 15',
                          style: AppText.labelCaps.copyWith(fontSize: 10)),
                      Text('Oct 31',
                          style: AppText.labelCaps.copyWith(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingCard() {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CapsLabel('Avg. Rating'),
                  const SizedBox(height: 6),
                  Text('4.9', style: AppText.displayLgMobile),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.goldLight.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: const Icon(Icons.star, color: AppColors.goldDark),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < 4 ? Icons.star : Icons.star_half,
                size: 16,
                color: AppColors.goldDark,
              );
            }),
          ),
          const SizedBox(height: 6),
          Text('Based on 142 reviews',
              style:
                  AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _bar(String label, double heightFraction, bool highlighted) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${(heightFraction * 28).round()}',
              style: AppText.labelCaps.copyWith(
                fontSize: 10,
                color:
                    highlighted ? AppColors.navy : AppColors.onSurfaceVariant,
                fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            FractionallySizedBox(
              heightFactor: heightFraction,
              child: Container(
                decoration: BoxDecoration(
                  color: highlighted ? AppColors.goldLight : AppColors.navy,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: AppText.labelCaps.copyWith(
                    color: highlighted
                        ? AppColors.navy
                        : AppColors.onSurfaceVariant,
                    fontWeight:
                        highlighted ? FontWeight.w800 : FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  // Roughly mirrors the polyline points used in the HTML profile-views chart.
  static const _points = [0.30, 0.50, 0.35, 0.70, 0.55, 0.80];

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final fillPath = Path();
    final dx = size.width / (_points.length - 1);

    for (int i = 0; i < _points.length; i++) {
      final x = dx * i;
      final y = size.height * (1 - _points[i]);
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gold.withOpacity(0.25),
          AppColors.gold.withOpacity(0.0)
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = Colors.white;
    final dotStroke = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (int i = 0; i < _points.length; i++) {
      final x = dx * i;
      final y = size.height * (1 - _points[i]);
      final isLast = i == _points.length - 1;
      canvas.drawCircle(Offset(x, y), isLast ? 5 : 3.5,
          isLast ? (Paint()..color = AppColors.gold) : dotPaint);
      if (!isLast) canvas.drawCircle(Offset(x, y), 3.5, dotStroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
