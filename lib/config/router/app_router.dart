import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/local_storage_service.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'route_guard.dart';
import 'route_names.dart';

/// Central [GoRouter] with redirect guard and feature routes.
GoRouter createAppRouter(
  AuthService authService,
  LocalStorageService localStorage,
) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (context, state) => RouteGuard.redirect(
      state,
      authService,
      localStorage,
    ),
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const _PlaceholderHomePage(),
      ),
    ],
  );
}

/// Authenticated landing placeholder (no dedicated home feature in spec).
class _PlaceholderHomePage extends StatelessWidget {
  const _PlaceholderHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Authenticated — replace with home feature')),
    );
  }
}
