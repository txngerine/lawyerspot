import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/user_model.dart';


class ProfileController extends GetxController {
  final profile = Rxn<UserModel>();
  final isVerified = false.obs;
  final isLoading = true.obs;
  final errorMessage = Rxn<String>();
  final isAvailable = true.obs;

  final bioController = TextEditingController();
  final yearsController = TextEditingController();
  final feeController = TextEditingController();
  final cityController = TextEditingController();
  final practiceAreas = <String>{}.obs;

  @override
  void onInit() {
    loadProfile();
    super.onInit();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      // TODO: Replace mock with real API call when backend is ready
      // profile.value = await Get.find<ProfileService>().getProfile();
      profile.value = mockUser();
      final p = profile.value!;
      bioController.text = p.bio ?? mockEditorBio();
      yearsController.text = p.yearsExperience?.toString() ?? mockEditorYears();
      feeController.text = p.consultationFee?.toString() ?? mockEditorFee();
      cityController.text = p.cities.isNotEmpty ? p.cities.first : mockEditorCity();
      practiceAreas.assignAll(p.practiceAreas.isNotEmpty ? p.practiceAreas : mockEditorPracticeAreas().toList());
      isAvailable.value = p.isAvailable;
      isVerified.value = p.isVerified;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      profile.value = mockUser();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile() async {
    try {
      // TODO: Replace mock with real API call when backend is ready
      // await Get.find<ProfileService>().updateProfile({...});
      Get.snackbar('Saved', 'Profile changes saved.',
          snackPosition: SnackPosition.BOTTOM);
      await loadProfile();
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toggleAvailability() => isAvailable.toggle();

  void removeArea(String area) => practiceAreas.remove(area);

  @override
  void onClose() {
    bioController.dispose();
    yearsController.dispose();
    feeController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
