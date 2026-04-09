import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

/// Hive boxes plus SharedPreferences for simple flags (locale, onboarding).
abstract class LocalStorageService {
  Future<void> init();
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<Box<dynamic>> openBox(String name);
}

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl();

  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await Hive.initFlutter();
  }

  @override
  Future<String?> getString(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(key, value);
  }

  @override
  Future<Box<dynamic>> openBox(String name) async {
    if (!Hive.isBoxOpen(name)) {
      return Hive.openBox<dynamic>(name);
    }
    return Hive.box<dynamic>(name);
  }
}

/// Default cache box name helper.
Future<Box<dynamic>> openAppCacheBox(LocalStorageService service) =>
    service.openBox(AppConstants.hiveBoxCache);
