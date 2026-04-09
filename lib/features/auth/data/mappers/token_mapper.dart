import '../../domain/entities/token_entity.dart';
import '../models/token_model.dart';

/// Maps [TokenModel] to [TokenEntity].
class TokenMapper {
  TokenEntity toEntity(TokenModel model) {
    return TokenEntity(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      expiresAt:
          model.expiresAt != null ? DateTime.tryParse(model.expiresAt!) : null,
    );
  }
}
