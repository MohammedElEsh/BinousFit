import 'package:equatable/equatable.dart';

/// Auth tokens in domain layer.
class TokenEntity extends Equatable {
  const TokenEntity({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresAt];
}
