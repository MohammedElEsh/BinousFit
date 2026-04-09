import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../services/auth_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Application Dio instance with base URL, timeouts, and interceptors.
class DioClient {
  DioClient(AuthService authService) : dio = _createDio(authService);

  final Dio dio;

  static Dio _createDio(AuthService authService) {
    final options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
      headers: <String, dynamic>{
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
    );
    final d = Dio(options);
    d.interceptors.addAll([
      AuthInterceptor(authService),
      ErrorInterceptor(),
      loggingInterceptor(),
    ]);
    return d;
  }
}
