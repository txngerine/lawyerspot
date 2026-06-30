import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _bioController = TextEditingController();
  final _feeController = TextEditingController();
  final _cityController = TextEditingController();
  bool _available = true;

  @override
  void initState() {
    super.initState();
    final p = Get.find<ProfileController>().profile.value;
    if (p != null) {
      _bioController.text = p.bio;
      _feeController.text = p.fee.toString();
      _cityController.text = p.location;
      _available = p.online;
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _feeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCtrl = Get.find<ProfileController>();
    return Scaffold(
      appBar: BrandAppBar(
        onNotificationsTap: () {},
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final p = profileCtrl.profile.value;
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                children: [
                  Center(
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
                                  BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 10),
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppColors.surfaceContainerHigh,
                                backgroundImage: p?.image.isNotEmpty == true
                                    ? NetworkImage(p!.image)
                                    : null,
                                child: p?.image.isNotEmpty != true
                                    ? const Icon(Icons.person, size: 40, color: AppColors.primary)
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
                                    color: AppColors.primaryContainer,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.check_circle, size: 16, color: AppColors.accent),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(p?.name ?? 'Lawyer', style: AppText.headlineMd),
                        if (p?.firm != null && p!.firm.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text('${p.firm}',
                              style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SoftCard(
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _available ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Availability Status', style: AppText.titleLg),
                              Text(_available ? 'Currently accepting consultations'
                                      : 'Not accepting consultations',
                                  style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        Switch(
                          value: _available,
                          activeTrackColor: AppColors.primaryContainer,
                          onChanged: (v) => setState(() => _available = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _section(
                    title: 'Bio & Experience',
                    children: [
                      const CapsLabel('Professional Biography'),
                      const SizedBox(height: 8),
                      TextField(controller: _bioController, maxLines: 4),
                      const SizedBox(height: 16),
                      CapsLabel('Experience (${p?.experience ?? 0} years)'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Specialization', style: AppText.headlineMd.copyWith(fontSize: 19)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (p?.specialization ?? []).map((area) {
                            return Chip(
                              label: Text(area, style: AppText.bodySm.copyWith(color: AppColors.primary)),
                              backgroundColor: AppColors.accent.withOpacity(0.1),
                              side: BorderSide(color: AppColors.accent.withOpacity(0.4)),
                              shape: const StadiumBorder(),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () {},
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _section(
                    title: 'Consultation Fee',
                    children: [
                      const CapsLabel('Fee (INR)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _feeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(prefixText: '₹ '),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _section(
                    title: 'Location',
                    children: [
                      const CapsLabel('City'),
                      const SizedBox(height: 8),
                      TextField(controller: _cityController),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await profileCtrl.updateProfile({
                      'bio': _bioController.text,
                      'fee': int.tryParse(_feeController.text) ?? 0,
                      'location': _cityController.text,
                      'online': _available,
                    });
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile changes saved.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.save_outlined, size: 18),
                  label: const Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.headlineMd.copyWith(fontSize: 19)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
