import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/common.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _controller = Get.find<ProfileController>();
  final _currentPwdController = TextEditingController();
  final _newPwdController = TextEditingController();
  final _confirmPwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPwdController.dispose();
    _newPwdController.dispose();
    _confirmPwdController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await _controller.changePassword(
      _currentPwdController.text,
      _newPwdController.text,
    );

    if (_controller.errorMessage.value != null) {
      Get.snackbar('Error', _controller.errorMessage.value!,
          snackPosition: SnackPosition.BOTTOM);
      _controller.errorMessage.value = null;
    } else {
      Get.snackbar('Success', 'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Change Password'),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                TextFormField(
                  controller: _currentPwdController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Current Password'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter current password' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPwdController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter new password';
                    if (v.length < 8) return 'Minimum 8 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPwdController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirm New Password'),
                  validator: (v) {
                    if (v != _newPwdController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                GoldButton(
                  label: 'Change Password',
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
