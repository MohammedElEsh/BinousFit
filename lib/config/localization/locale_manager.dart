import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/local_storage_service.dart';

/// Supported locales and persistence helpers.
class LocaleManager {
  LocaleManager._();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static Future<void> changeLocale(
    BuildContext context,
    Locale locale,
  ) async {
    await context.setLocale(locale);
  }

  static Future<Locale?> getSavedLocale(LocalStorageService local) async {
    final code = await local.getString(AppConstants.keyLocale);
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  static Future<void> saveLocale(
    LocalStorageService local,
    Locale locale,
  ) async {
    await local.setString(AppConstants.keyLocale, locale.languageCode);
  }
}
