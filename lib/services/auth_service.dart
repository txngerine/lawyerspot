import '../config/api_config.dart';
import '../models/auth_model.dart';
import 'base_service.dart';

class AuthService extends BaseService {
  Future<AuthResponse> login(LoginRequest request) async {
    final response = await post(ApiConfig.login, request.toJson());
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Login failed');
    }
    final data = AuthResponse.fromJson(response.body as Map<String, dynamic>);
    BaseService.setToken(data.token);
    return data;
  }

  Future<void> register(RegisterRequest request) async {
    final response = await post(ApiConfig.register, request.toJson());
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Registration failed');
    }
  }

  Future<void> logout() async {
    await post(ApiConfig.logout, {});
    BaseService.setToken(null);
  }
}
