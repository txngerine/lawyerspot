import 'package:get/get.dart';
import '../models/auth_model.dart';
import '../models/lawyer_model.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final profile = Rxn<Lawyer>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final data = await Get.find<ProfileService>().getProfile();
      profile.value = Lawyer.fromJson(data);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<ProfileService>().updateProfile(data);
      await loadProfile();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String current, String newPwd) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final req = ChangePasswordRequest(
        currentPassword: current,
        newPassword: newPwd,
      );
      await Get.find<ProfileService>().changePassword(req);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
