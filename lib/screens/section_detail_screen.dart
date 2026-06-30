import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SectionDetailScreen extends StatelessWidget {
  const SectionDetailScreen({
    super.key,
    required this.title,
    required this.code,
    required this.body,
    this.punishment,
    this.category,
  });

  final String title;
  final String code;
  final String body;
  final String? punishment;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        showBack: true,
        title: code,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(code,
                    style: AppText.titleLg.copyWith(color: AppColors.secondary)),
              ),
              const SizedBox(height: 12),
              Text(title, style: AppText.displayLgMobile),
              if (category != null && category!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(category!,
                      style: AppText.labelCaps.copyWith(color: AppColors.primary)),
                ),
              ],
              if (body.isNotEmpty) ...[
                const SizedBox(height: 20),
                SoftCard(
                  child: Text(body,
                      style: AppText.bodyMd,
                      textAlign: TextAlign.justify),
                ),
              ],
              if (punishment != null && punishment!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text('Punishment', style: AppText.headlineMd),
                const SizedBox(height: 8),
                SoftCard(
                  child: Text(punishment!,
                      style: AppText.bodyMd,
                      textAlign: TextAlign.justify),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
