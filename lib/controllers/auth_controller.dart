import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final rememberMe = false.obs;
  final obscurePassword = true.obs;
  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  void toggleRememberMe() => rememberMe.toggle();
  void toggleObscurePassword() => obscurePassword.toggle();

  Future<void> signIn() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
        rememberMe: rememberMe.value,
      );
      await Get.find<AuthService>().login(request);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await Get.find<AuthService>().logout();
    } catch (_) {}
    isLoggedIn.value = false;
    emailController.clear();
    passwordController.clear();
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
