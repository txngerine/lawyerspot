import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/auth_model.dart';
import 'base_service.dart';

class ProfileService {
  Future<Map<String, dynamic>> getProfile() async {
    final response = await BaseService.instance.dio.get(ApiConfig.lawyerProfile);
    debugPrint('[Profile] getProfile response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    debugPrint('[Profile] updateProfile request data: $data');
    final response = await BaseService.instance.dio.patch(
      ApiConfig.lawyerProfile,
      data: data,
    );
    debugPrint('[Profile] updateProfile response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request) async {
    debugPrint('[Profile] changePassword request data: ${request.toJson()}');
    final response = await BaseService.instance.dio.post(
      ApiConfig.changePassword,
      data: request.toJson(),
    );
    debugPrint('[Profile] changePassword response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }
}
