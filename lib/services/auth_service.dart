import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/auth_model.dart';
import 'base_service.dart';

class AuthService {
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await BaseService.instance.dio.post(
        ApiConfig.login,
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: _extractMessage(e),
      );
    }
  }

  Future<AuthResponse> lawyerSignup(LawyerSignupRequest request) async {
    try {
      final response = await BaseService.instance.dio.post(
        ApiConfig.lawyerSignup,
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: _extractMessage(e),
      );
    }
  }

  Future<AuthResponse> clientSignup(ClientSignupRequest request) async {
    try {
      final response = await BaseService.instance.dio.post(
        ApiConfig.clientSignup,
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: _extractMessage(e),
      );
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await BaseService.instance.dio.post(ApiConfig.logout);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: _extractMessage(e),
      );
    }
  }

  Future<SessionUser> getMe() async {
    try {
      final response = await BaseService.instance.dio.get(ApiConfig.authMe);
      return SessionUser.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: _extractMessage(e),
      );
    }
  }

  static String _extractMessage(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final detail = (e.response!.data as Map<String, dynamic>)['detail'];
      if (detail is String && detail.isNotEmpty) return detail;
    }
    return e.response?.statusMessage ?? 'Something went wrong';
  }
}
