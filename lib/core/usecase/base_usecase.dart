import '../utils/typedefs.dart';

/// Single-responsibility use case contract.
abstract class UseCase<Type, Params> {
  EitherFailure<Type> call(Params params);
}
