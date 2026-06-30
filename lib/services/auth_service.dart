import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/auth_model.dart';
import 'base_service.dart';

class AuthService {
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      debugPrint('[Auth] login request data: ${request.toJson()}');
      final response = await BaseService.instance.dio.post(
        ApiConfig.login,
        data: request.toJson(),
      );
      debugPrint('[Auth] login response: ${response.data}');
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<AuthResponse> lawyerSignup(LawyerSignupRequest request) async {
    try {
      debugPrint('[Auth] lawyerSignup request data: ${request.toJson()}');
      final response = await BaseService.instance.dio.post(
        ApiConfig.lawyerSignup,
        data: request.toJson(),
      );
      debugPrint('[Auth] lawyerSignup response: ${response.data}');
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<AuthResponse> clientSignup(ClientSignupRequest request) async {
    try {
      debugPrint('[Auth] clientSignup request data: ${request.toJson()}');
      final response = await BaseService.instance.dio.post(
        ApiConfig.clientSignup,
        data: request.toJson(),
      );
      debugPrint('[Auth] clientSignup response: ${response.data}');
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      debugPrint('[Auth] logout request data: {}');
      final response = await BaseService.instance.dio.post(ApiConfig.logout);
      debugPrint('[Auth] logout response: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<SessionUser> getMe() async {
    try {
      final response = await BaseService.instance.dio.get(ApiConfig.authMe);
      debugPrint('[Auth] getMe response: ${response.data}');
      return SessionUser.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  static String _extractMessage(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final detail = (e.response!.data as Map<String, dynamic>)['detail'];
      if (detail is String && detail.isNotEmpty) return detail;
    }
    if (e.response?.statusCode == 404) return 'Server endpoint not found. Please try again later.';
    if (e.response?.statusCode == 500) return 'Server error. Please try again later.';
    return e.response?.statusMessage ?? 'Connection failed. Check your internet.';
  }
}
