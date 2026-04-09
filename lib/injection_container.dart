import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/router/app_router.dart';
import 'core/connection/network_info.dart';
import 'core/network/dio_client.dart';
import 'core/services/auth_service.dart';
import 'core/services/cache_service.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/secure_storage_service.dart';
import 'features/auth/auth_injection.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'features/splash/presentation/bloc/splash_cubit.dart';

/// Global service locator.
final sl = GetIt.instance;

/// Registers core + feature modules. Call after [Hive] / prefs are ready.
Future<void> configureDependencies() async {
  sl
    ..registerLazySingleton<SecureStorageService>(SecureStorageServiceImpl.new)
    ..registerLazySingleton<AuthService>(
      () => AuthService(sl<SecureStorageService>()),
    )
    ..registerSingleton<LocalStorageService>(LocalStorageServiceImpl());

  await sl<LocalStorageService>().init();

  if (!Hive.isBoxOpen(CacheService.defaultBoxName)) {
    await Hive.openBox<dynamic>(CacheService.defaultBoxName);
  }
  final box = Hive.box<dynamic>(CacheService.defaultBoxName);
  sl.registerSingleton<CacheService>(CacheService(box));

  sl
    ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<ConnectivityService>()),
    )
    ..registerLazySingleton<DioClient>(
      () => DioClient(sl<AuthService>()),
    )
    ..registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  initAuthModule(sl);

  sl
    ..registerFactory<SplashCubit>(
      () => SplashCubit(
        authService: sl<AuthService>(),
        localStorage: sl<LocalStorageService>(),
      ),
    )
    ..registerFactory<OnboardingCubit>(
      () => OnboardingCubit(sl<LocalStorageService>()),
    )
    ..registerLazySingleton<GoRouter>(
      () => createAppRouter(
        sl<AuthService>(),
        sl<LocalStorageService>(),
      ),
    );
}
