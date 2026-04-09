import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

/// Register API body.
@JsonSerializable()
class RegisterRequestDto {
  const RegisterRequestDto({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String email;
  final String password;

  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);
}
