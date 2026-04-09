import 'package:hive/hive.dart';

import '../constants/app_constants.dart';

/// Global key-value cache backed by Hive.
class CacheService {
  CacheService(this._box);

  final Box<dynamic> _box;

  static Future<CacheService> open(Box<dynamic> box) async {
    return CacheService(box);
  }

  Future<void> set(String key, dynamic value) => _box.put(key, value);

  T? get<T>(String key) {
    final v = _box.get(key);
    if (v is T) {
      return v;
    }
    return null;
  }

  Future<void> remove(String key) => _box.delete(key);

  Future<void> clear() => _box.clear();

  static String get defaultBoxName => AppConstants.hiveBoxCache;
}
