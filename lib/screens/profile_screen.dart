import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileCtrl = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    if (_profileCtrl.profile.value == null) {
      _profileCtrl.loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () {},
      ),
      body: Obx(() {
        if (_profileCtrl.isLoading.value && _profileCtrl.profile.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_profileCtrl.errorMessage.value != null &&
            _profileCtrl.profile.value == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_profileCtrl.errorMessage.value!,
                    style: AppText.bodyMd),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _profileCtrl.loadProfile,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final p = _profileCtrl.profile.value;
        return RefreshIndicator(
          onRefresh: _profileCtrl.loadProfile,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              _buildHeader(p),
              const SizedBox(height: 20),
              _buildStats(p),
              const SizedBox(height: 20),
              _buildContactSection(p),
              if ((p?.specialization ?? []).isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSection('Specialization', _buildChips(
                  p!.specialization,
                  AppColors.accent.withOpacity(0.1),
                  AppColors.accent.withOpacity(0.3),
                  AppColors.primary,
                  FontWeight.w600,
                )),
              ],
              if ((p?.languages ?? []).isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSection('Languages', _buildChips(
                  p!.languages,
                  AppColors.surfaceContainer,
                  Colors.transparent,
                  AppColors.onSurfaceVariant,
                  FontWeight.w500,
                )),
              ],
              if (p?.bio != null && p!.bio.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSection('About', Text(p.bio, style: AppText.bodyMd)),
              ],
              if (p?.subscriptionPlanId != null &&
                  p!.subscriptionPlanId.isNotEmpty &&
                  p.subscriptionPlanId != 'basic') ...[
                const SizedBox(height: 16),
                _buildSection(
                    'Subscription',
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            p.subscriptionPlanId.toUpperCase(),
                            style: AppText.labelCaps
                                .copyWith(color: AppColors.secondary),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Manage'),
                        ),
                      ],
                    )),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(dynamic p) {
    return SoftCard(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.06),
                        blurRadius: 8),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  backgroundImage: p?.image.isNotEmpty == true
                      ? NetworkImage(p!.image)
                      : null,
                  child: p?.image.isNotEmpty != true
                      ? Text(
                          (p?.name.isNotEmpty == true ? p!.name[0] : '?')
                              .toUpperCase(),
                          style: AppText.titleLg.copyWith(fontSize: 32),
                        )
                      : null,
                ),
              ),
              if (p?.verified == true)
                Positioned(
                  right: 0,
                  bottom: 2,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.verified,
                        size: 15, color: AppColors.accent),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(p?.name ?? 'Lawyer',
              style: AppText.headlineMd,
              textAlign: TextAlign.center),
          if (p?.practice != null && p!.practice.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(p.practice,
                style: AppText.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant)),
          ],
          if (p?.firm != null && p!.firm.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(p.firm,
                style: AppText.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant)),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: p?.online == true
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.outline.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: p?.online == true
                        ? AppColors.success
                        : AppColors.outline,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  p?.online == true ? 'Available' : 'Unavailable',
                  style: AppText.labelCaps.copyWith(
                    color: p?.online == true
                        ? AppColors.success
                        : AppColors.outline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const EditProfileScreen()),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              backgroundColor: AppColors.accentContainer.withOpacity(0.7),
              side: BorderSide.none,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                  horizontal: 28, vertical: 12),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(dynamic p) {
    return SoftCard(
      child: Row(
        children: [
          _statItem(Icons.star_outline, 'Rating',
              p?.rating != null ? p.rating.toStringAsFixed(1) : '--',
              caption: '${p?.reviews ?? 0} reviews'),
          Container(
            width: 1,
            height: 40,
            color: AppColors.outlineVariant.withOpacity(0.3),
          ),
          _statItem(Icons.work_outline, 'Experience',
              '${p?.experience ?? 0} yrs'),
          Container(
            width: 1,
            height: 40,
            color: AppColors.outlineVariant.withOpacity(0.3),
          ),
          _statItem(Icons.currency_rupee, 'Fee',
              p?.fee != null ? '₹${p.fee}' : '--'),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String label, String value,
      {String? caption}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.primary.withOpacity(0.6)),
          const SizedBox(height: 6),
          Text(value,
              style: AppText.titleLg.copyWith(fontSize: 18),
              textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(label,
              style: AppText.labelCaps.copyWith(fontSize: 9),
              textAlign: TextAlign.center),
          if (caption != null) ...[
            const SizedBox(height: 1),
            Text(caption,
                style: AppText.labelCaps.copyWith(
                    fontSize: 8, color: AppColors.outline),
                textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }

  Widget _buildContactSection(dynamic p) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact',
              style: AppText.headlineMd.copyWith(fontSize: 19)),
          const SizedBox(height: 16),
          _contactRow(Icons.email_outlined, p?.email ?? ''),
          if (p?.phone != null && p!.phone.isNotEmpty) ...[
            const SizedBox(height: 12),
            _contactRow(Icons.phone_outlined, p.phone),
          ],
          if (p?.location != null && p!.location.isNotEmpty) ...[
            const SizedBox(height: 12),
            _contactRow(Icons.location_on_outlined, p.location),
          ],
          if (p?.address != null && p!.address.isNotEmpty) ...[
            const SizedBox(height: 12),
            _contactRow(Icons.home_outlined, p.address),
          ],
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text,
              style: AppText.bodyMd,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppText.headlineMd.copyWith(fontSize: 19)),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildChips(
    List<String> items,
    Color bg,
    Color border,
    Color textColor,
    FontWeight weight,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((s) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: border),
          ),
          child: Text(s,
              style: AppText.bodySm.copyWith(
                  color: textColor, fontWeight: weight)),
        );
      }).toList(),
    );
  }
}
