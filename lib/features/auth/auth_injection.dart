import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/auth_service.dart';
import '../../core/connection/network_info.dart';
import '../../core/services/cache_service.dart';
import 'data/datasource/auth_api.dart';
import 'data/datasource/auth_local_datasource.dart';
import 'data/datasource/auth_remote_datasource.dart';
import 'data/mappers/user_mapper.dart';
import 'data/repository/auth_repository_impl.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/usecases/get_cached_user_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'presentation/bloc/auth_cubit.dart';

/// Registers auth feature dependencies in [GetIt].
void initAuthModule(GetIt sl) {
  sl
    ..registerLazySingleton<UserMapper>(UserMapper.new)
    ..registerLazySingleton<AuthApi>(() => AuthApi(sl<Dio>()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<AuthApi>()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<CacheService>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: sl<AuthRemoteDataSource>(),
        local: sl<AuthLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        authService: sl<AuthService>(),
        userMapper: sl<UserMapper>(),
      ),
    )
    ..registerFactory<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()))
    ..registerFactory<RegisterUseCase>(
      () => RegisterUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<LogoutUseCase>(() => LogoutUseCase(sl<AuthRepository>()))
    ..registerFactory<GetCachedUserUseCase>(
      () => GetCachedUserUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        loginUseCase: sl<LoginUseCase>(),
        registerUseCase: sl<RegisterUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        getCachedUserUseCase: sl<GetCachedUserUseCase>(),
      ),
    );
}
