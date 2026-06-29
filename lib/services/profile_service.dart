import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/auth_model.dart';
import 'base_service.dart';

class ProfileService {
  Future<Map<String, dynamic>> getProfile() async {
    final response = await BaseService.instance.dio.get(ApiConfig.lawyerProfile);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final response = await BaseService.instance.dio.patch(
      ApiConfig.lawyerProfile,
      data: data,
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request) async {
    final response = await BaseService.instance.dio.post(
      ApiConfig.changePassword,
      data: request.toJson(),
    );
    return response.data as Map<String, dynamic>;
  }
}
