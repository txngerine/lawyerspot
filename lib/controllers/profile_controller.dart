import 'package:dio/dio.dart';
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
      final lawyerData = data['lawyer'] as Map<String, dynamic>? ?? data;
      profile.value = Lawyer.fromJson(lawyerData);
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
      final response = await Get.find<ProfileService>().updateProfile(data);
      final lawyerData = response['lawyer'] as Map<String, dynamic>?;
      if (lawyerData != null) {
        profile.value = Lawyer.fromJson(lawyerData);
      } else {
        await loadProfile();
      }
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
    } on DioException catch (e) {
      errorMessage.value = e.response?.data?['message'] as String? ??
          e.response?.statusMessage ??
          'Password change failed';
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
