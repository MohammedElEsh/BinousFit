import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User JSON from API.
@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final String id;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
