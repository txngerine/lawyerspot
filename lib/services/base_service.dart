import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../config/api_config.dart';

class BaseService {
  late final Dio dio;
  static BaseService? _instance;

  BaseService._() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  static Future<BaseService> init() async {
    if (_instance != null) return _instance!;
    _instance = BaseService._();

    final dir = await getApplicationDocumentsDirectory();
    final jar = PersistCookieJar(
      storage: FileStorage('${dir.path}/.cookies'),
    );
    _instance!.dio.interceptors.add(CookieManager(jar));

    if (Platform.isAndroid) {
      _instance!.dio.interceptors.add(
        BadCertificateHandler((cert, host, port) => true),
      );
    }

    return _instance!;
  }

  static BaseService get instance {
    if (_instance == null) {
      throw Exception('BaseService not initialized. Call BaseService.init() first.');
    }
    return _instance!;
  }
}

class BadCertificateHandler extends Interceptor {
  final bool Function(X509Certificate, String, int) handler;

  BadCertificateHandler(this.handler);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }
}
