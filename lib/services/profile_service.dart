import '../config/api_config.dart';
import '../models/user_model.dart';
import 'base_service.dart';

class ProfileService extends BaseService {
  Future<UserModel> getProfile() async {
    final response = await get(ApiConfig.profile);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load profile');
    }
    return UserModel.fromJson(response.body as Map<String, dynamic>);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final response = await put(ApiConfig.profile, data);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to update profile');
    }
  }

  Future<bool> getVerificationStatus() async {
    final response = await get(ApiConfig.profileVerificationStatus);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load verification status');
    }
    return (response.body as Map<String, dynamic>)['is_verified'] as bool;
  }
}
