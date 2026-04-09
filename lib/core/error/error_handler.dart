import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failure.dart';

/// Maps exceptions and Dio errors to typed [Failure] instances.
class ErrorHandler {
  ErrorHandler._();

  static Failure mapException(Object error) {
    if (error is Failure) {
      return error;
    }
    if (error is DioException) {
      return mapDioException(error);
    }
    if (error is ServerException) {
      return ServerFailure(message: error.message);
    }
    if (error is CacheException) {
      return CacheFailure(message: error.message);
    }
    if (error is NetworkException) {
      return NetworkFailure(message: error.message);
    }
    return UnknownFailure(message: error.toString());
  }

  static Failure mapDioException(DioException e) {
    final status = e.response?.statusCode;
    final msg = e.message ?? e.response?.statusMessage;
    if (status == 401 || status == 403) {
      return AuthFailure(message: msg);
    }
    if (status != null && status >= 500) {
      return ServerFailure(message: msg);
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkFailure(message: msg);
    }
    return ServerFailure(message: msg);
  }
}
