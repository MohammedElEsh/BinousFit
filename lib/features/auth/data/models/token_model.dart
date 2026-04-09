import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

/// Token payload from API.
@JsonSerializable()
class TokenModel {
  const TokenModel({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
