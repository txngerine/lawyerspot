import 'package:get/get.dart';
import '../config/api_config.dart';

class BaseService extends GetConnect {
  static String? _token;

  static void setToken(String? token) {
    _token = token;
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) {
      if (_token != null) {
        request.headers['Authorization'] = 'Bearer $_token';
      }
      return request;
    });
    super.onInit();
  }
}
