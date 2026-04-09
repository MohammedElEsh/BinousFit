import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

/// Shorthand for async use case / repository results.
typedef EitherFailure<T> = Future<Either<Failure, T>>;
