import 'dart:async';

import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/local_storage_service.dart';
import 'route_names.dart';

/// Redirect logic: onboarding completion + auth for protected routes.
class RouteGuard {
  RouteGuard._();

  static FutureOr<String?> redirect(
    GoRouterState state,
    AuthService auth,
    LocalStorageService local,
  ) async {
    final path = state.uri.path;
    final onboarded =
        await local.getBool(AppConstants.keyOnboardingSeen) ?? false;
    final loggedIn = await auth.isLoggedIn();

    if (path == RouteNames.splash || path == RouteNames.onboarding) {
      return null;
    }

    if (!onboarded) {
      return RouteNames.onboarding;
    }

    if (path == RouteNames.home && !loggedIn) {
      return RouteNames.login;
    }

    if ((path == RouteNames.login || path == RouteNames.register) &&
        loggedIn) {
      return RouteNames.home;
    }

    return null;
  }
}
