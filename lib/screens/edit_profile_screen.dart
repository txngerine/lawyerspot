import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _profileCtrl = Get.find<ProfileController>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _firmController = TextEditingController();
  final _addressController = TextEditingController();
  final _feeController = TextEditingController();
  final _practiceController = TextEditingController();
  final _citySlugController = TextEditingController();
  bool _online = true;
  List<String> _languages = [];
  List<String> _specialization = [];
  final _languageController = TextEditingController();
  final _specializationController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final p = _profileCtrl.profile.value;
    if (p != null) {
      _nameController.text = p.name;
      _phoneController.text = p.phone;
      _emailController.text = p.email;
      _bioController.text = p.bio;
      _firmController.text = p.firm;
      _addressController.text = p.address;
      _feeController.text = p.fee.toString();
      _practiceController.text = p.practice;
      _citySlugController.text = p.citySlug;
      _online = p.online;
      _languages = List.from(p.languages);
      _specialization = List.from(p.specialization);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _firmController.dispose();
    _addressController.dispose();
    _feeController.dispose();
    _practiceController.dispose();
    _citySlugController.dispose();
    _languageController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  Future<void> _save() async {
    final data = <String, dynamic>{
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'bio': _bioController.text.trim(),
      'firm': _firmController.text.trim(),
      'address': _addressController.text.trim(),
      'fee': int.tryParse(_feeController.text) ?? 0,
      'online': _online,
      'practice': _practiceController.text.trim(),
      'citySlug': _citySlugController.text.trim(),
      'languages': _languages,
      'specialization': _specialization,
    };
    data.removeWhere((_, v) => v == '' || (v is List && v.isEmpty));

    if (_imageFile != null) {
      final bytes = await _imageFile!.readAsBytes();
      final base64 = base64Encode(bytes);
      data['image'] = 'data:image/jpeg;base64,$base64';
    }

    await _profileCtrl.updateProfile(data);

    if (!mounted) return;
    if (_profileCtrl.errorMessage.value != null) {
      Get.snackbar('Error', _profileCtrl.errorMessage.value!,
          snackPosition: SnackPosition.BOTTOM);
      _profileCtrl.errorMessage.value = null;
    } else {
      Get.snackbar('Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Edit Profile'),
      body: Obx(() {
        final p = _profileCtrl.profile.value;
        return _profileCtrl.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 104,
                                height: 104,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            AppColors.primary.withOpacity(0.08),
                                        blurRadius: 10),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.surfaceContainerHigh,
                                  backgroundImage: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : (p?.image.isNotEmpty == true
                                          ? NetworkImage(p!.image)
                                          : null),
                                  child: _imageFile == null &&
                                          (p?.image.isNotEmpty != true)
                                      ? const Icon(Icons.person,
                                          size: 40, color: AppColors.primary)
                                      : null,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 2,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.camera_alt,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Tap to change photo',
                            style: AppText.bodySm.copyWith(
                                color: AppColors.outline)),
                      ],
                    ),
                  ),
                  _section(title: 'Basic Information', children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _section(title: 'Professional Details', children: [
                    TextFormField(
                      controller: _firmController,
                      decoration: const InputDecoration(labelText: 'Firm'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _practiceController,
                      decoration: const InputDecoration(labelText: 'Practice Area'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _citySlugController,
                      decoration: const InputDecoration(
                          labelText: 'City Slug', hintText: 'e.g. mumbai'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _feeController,
                      decoration: const InputDecoration(
                          labelText: 'Consultation Fee',
                          prefixText: '₹ '),
                      keyboardType: TextInputType.number,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _section(title: 'Bio', children: [
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(labelText: 'Professional Biography'),
                      maxLines: 4,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _section(title: 'Languages', children: [
                    _chipInput(
                      controller: _languageController,
                      chips: _languages,
                      hint: 'Add language',
                      onAdd: (v) {
                        if (v.trim().isNotEmpty && !_languages.contains(v.trim())) {
                          setState(() => _languages.add(v.trim()));
                        }
                      },
                      onDelete: (i) => setState(() => _languages.removeAt(i)),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _section(title: 'Specialization', children: [
                    _chipInput(
                      controller: _specializationController,
                      chips: _specialization,
                      hint: 'Add specialization',
                      onAdd: (v) {
                        if (v.trim().isNotEmpty &&
                            !_specialization.contains(v.trim())) {
                          setState(() => _specialization.add(v.trim()));
                        }
                      },
                      onDelete: (i) => setState(() => _specialization.removeAt(i)),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  SoftCard(
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _online ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Availability', style: AppText.titleLg),
                              Text(
                                  _online
                                      ? 'Accepting consultations'
                                      : 'Not accepting consultations',
                                  style: AppText.bodySm.copyWith(
                                      color: AppColors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        Switch(
                          value: _online,
                          activeTrackColor: AppColors.primaryContainer,
                          onChanged: (v) => setState(() => _online = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  GoldButton(
                    label: 'Save Changes',
                    onPressed: _save,
                  ),
                ],
              );
      }),
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

  Widget _chipInput({
    required TextEditingController controller,
    required List<String> chips,
    required String hint,
    required void Function(String) onAdd,
    required void Function(int) onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: hint),
                onSubmitted: (v) {
                  onAdd(v);
                  controller.clear();
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                onAdd(controller.text);
                controller.clear();
              },
              icon: const Icon(Icons.add_circle_outline,
                  color: AppColors.secondary),
            ),
          ],
        ),
        if (chips.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips.asMap().entries.map((e) {
              return Chip(
                label: Text(e.value,
                    style: AppText.bodySm.copyWith(color: AppColors.primary)),
                backgroundColor: AppColors.accent.withOpacity(0.1),
                side: BorderSide(color: AppColors.accent.withOpacity(0.4)),
                shape: const StadiumBorder(),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => onDelete(e.key),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
