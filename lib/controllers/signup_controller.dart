import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/mock_data.dart';


class SignupController extends GetxController {
  final pageController = PageController();
  final step = 0.obs;
  static const totalSteps = 4;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  // Step 1
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final barNumberController = TextEditingController();
  final barState = Rxn<String>();

  // Step 2
  final yearsExperience = mockDefaultYearsExperience().obs;
  final practiceAreas = mockDefaultPracticeAreas().obs;
  static List<String> get allPracticeAreas => mockPracticeAreas();

  // Step 3
  final cities = mockDefaultCities().obs;
  final cityController = TextEditingController();
  final feeController = TextEditingController(text: mockDefaultFee());

  // Step 4
  final bioController = TextEditingController();
  final agreedToTerms = false.obs;

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
    } else {
      await _register();
    }
  }

  Future<void> _register() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // final request = RegisterRequest(...);
      // await Get.find<AuthService>().register(request);
      step.value = totalSteps;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void back() {
    if (step.value == 0) {
      Get.back();
    } else {
      goToStep(step.value - 1);
    }
  }

  void toggleArea(String area) {
    if (practiceAreas.contains(area)) {
      practiceAreas.remove(area);
    } else {
      practiceAreas.add(area);
    }
  }

  void addCity(String city) {
    if (city.trim().isNotEmpty) {
      cities.add(city.trim());
      cityController.clear();
    }
  }

  void removeCity(String city) => cities.remove(city);

  void toggleTerms() => agreedToTerms.toggle();

  @override
  void onClose() {
    pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    barNumberController.dispose();
    cityController.dispose();
    feeController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
