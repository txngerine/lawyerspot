import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cms_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ActsListScreen extends StatefulWidget {
  const ActsListScreen({super.key});

  @override
  State<ActsListScreen> createState() => _ActsListScreenState();
}

class _ActsListScreenState extends State<ActsListScreen> {
  final _cms = Get.find<CmsController>();

  @override
  Widget build(BuildContext context) {
    final acts = _cms.siteContent?.acts ?? [];

    return Scaffold(
      appBar: const BrandAppBar(
        showBack: true,
        title: 'Acts',
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (_cms.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_cms.errorMessage.value != null) {
            return Center(
              child: Text(_cms.errorMessage.value!,
                  style: AppText.bodyMd, textAlign: TextAlign.center),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            itemCount: acts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final act = acts[i];
              return SoftCard(
                onTap: () {
                  // Navigate to /act/{slug}
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(act.title,
                        style: AppText.titleLg,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    if (act.act.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(act.act,
                            style: AppText.labelCaps.copyWith(
                                color: AppColors.goldDark)),
                      ),
                    ],
                    if (act.body.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        act.body.length > 100
                            ? '${act.body.substring(0, 100)}...'
                            : act.body,
                        style: AppText.bodySm.copyWith(
                            color: AppColors.onSurfaceVariant),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
