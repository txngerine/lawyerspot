import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final pageController = PageController();
  final step = 0.obs;
  static const totalSteps = 4;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final practiceController = TextEditingController();
  final barIdController = TextEditingController();
  final citySlug = Rxn<String>();
  final bioController = TextEditingController();
  final agreedToTerms = false.obs;
  final specialization = <String>[].obs;

  bool get isLastStep => step.value == totalSteps - 1;

  void goToStep(int s) {
    step.value = s;
    if (s < totalSteps) {
      pageController.animateToPage(
        s,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  void next() async {
    if (step.value < totalSteps - 1) {
      goToStep(step.value + 1);
    }
  }

  void back() {
    if (step.value == 0) {
      Get.back();
    } else {
      goToStep(step.value - 1);
    }
  }

  void toggleSpecialization(String area) {
    if (specialization.contains(area)) {
      specialization.remove(area);
    } else {
      specialization.add(area);
    }
  }

  void toggleTerms() => agreedToTerms.toggle();

  @override
  void onClose() {
    pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    practiceController.dispose();
    barIdController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
