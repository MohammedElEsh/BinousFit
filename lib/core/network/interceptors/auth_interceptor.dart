import 'package:dio/dio.dart';

import '../../services/auth_service.dart';

/// Injects Bearer token from [AuthService] into every outgoing request.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authService);

  final AuthService _authService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
