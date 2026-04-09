import 'package:fpdart/fpdart.dart';

import '../error/error_handler.dart';
import '../error/failure.dart';

/// Wraps async work in try/catch and returns [Either] with typed [Failure].
Future<Either<Failure, T>> safeCall<T>(Future<T> Function() body) async {
  try {
    final result = await body();
    return Right(result);
  } catch (e, _) {
    return Left(ErrorHandler.mapException(e));
  }
}
