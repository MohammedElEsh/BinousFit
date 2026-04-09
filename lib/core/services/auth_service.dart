import 'package:jwt_decoder/jwt_decoder.dart';

import 'secure_storage_service.dart';

/// Access and refresh token lifecycle; tokens are injected via [AuthInterceptor], not manually per request.
class AuthService {
  AuthService(this._secure);

  final SecureStorageService _secure;

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  Future<void> saveToken({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _secure.write(_accessKey, accessToken);
    if (refreshToken != null) {
      await _secure.write(_refreshKey, refreshToken);
    }
  }

  Future<String?> getToken() => _secure.read(_accessKey);

  Future<String?> getRefreshToken() => _secure.read(_refreshKey);

  Future<void> clearToken() async {
    await _secure.delete(_accessKey);
    await _secure.delete(_refreshKey);
  }

  Future<bool> isLoggedIn() async {
    final t = await getToken();
    return t != null && t.isNotEmpty;
  }

  /// Whether the stored access token is missing or JWT-expired.
  Future<bool> isAccessTokenExpired() async {
    final t = await getToken();
    if (t == null || t.isEmpty) {
      return true;
    }
    return JwtDecoder.isExpired(t);
  }
}
