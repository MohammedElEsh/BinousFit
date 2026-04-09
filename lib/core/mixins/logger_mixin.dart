import '../services/logger_service.dart';

/// Logging helpers for cubits and services.
mixin LoggerMixin {
  LoggerService get logger => LoggerService.instance;

  void log(String message) => logger.d(message);

  void logWarning(String message) => logger.w(message);

  void logError(String message, [Object? error, StackTrace? stackTrace]) =>
      logger.e(message, error, stackTrace);
}
