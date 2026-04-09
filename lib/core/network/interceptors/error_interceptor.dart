import 'package:dio/dio.dart';

import '../../error/error_handler.dart';
import '../../services/logger_service.dart';

/// Maps HTTP layer errors to app failures and logs 401/403/5xx.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = ErrorHandler.mapDioException(err);
    final code = err.response?.statusCode;
    if (code == 401 || code == 403) {
      LoggerService.instance.w('Auth error: ${failure.message}');
    } else if (code != null && code >= 500) {
      LoggerService.instance.e('Server error', err, err.stackTrace);
    }
    handler.next(err);
  }
}
