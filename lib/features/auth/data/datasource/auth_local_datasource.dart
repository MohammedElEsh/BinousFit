import 'dart:convert';

import '../../../../core/services/cache_service.dart';
import '../models/user_model.dart';

/// Cached user profile (Hive).
abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._cache);

  final CacheService _cache;
  static const _userKey = 'auth_cached_user';

  @override
  Future<void> cacheUser(UserModel user) async {
    await _cache.set(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearUser() => _cache.remove(_userKey);

  @override
  Future<UserModel?> getCachedUser() async {
    final raw = _cache.get<String>(_userKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return UserModel.fromJson(map);
  }
}
