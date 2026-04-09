import 'package:equatable/equatable.dart';

/// Typed failures for domain and presentation (Left in Either).
sealed class Failure extends Equatable {
  const Failure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
