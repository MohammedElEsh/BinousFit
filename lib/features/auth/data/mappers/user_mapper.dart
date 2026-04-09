import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Maps [UserModel] to [UserEntity].
class UserMapper {
  UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
    );
  }
}
