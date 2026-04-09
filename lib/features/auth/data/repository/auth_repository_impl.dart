import 'package:fpdart/fpdart.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_local_datasource.dart';
import '../datasource/auth_remote_datasource.dart';
import '../mappers/user_mapper.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';

/// Auth repository: remote + local + [safeCall] + [NetworkInfo].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
    required NetworkInfo networkInfo,
    required AuthService authService,
    required UserMapper userMapper,
  })  : _remote = remote,
        _local = local,
        _networkInfo = networkInfo,
        _authService = authService,
        _userMapper = userMapper;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final NetworkInfo _networkInfo;
  final AuthService _authService;
  final UserMapper _userMapper;

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() {
    return safeCall(() async {
      final model = await _local.getCachedUser();
      return model == null ? null : _userMapper.toEntity(model);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No connection'));
    }
    final dto = LoginRequestDto(email: email, password: password);
    return safeCall(() async {
      final user = await _remote.login(dto);
      await _local.cacheUser(user);
      await _authService.saveToken(
        accessToken: 'placeholder_access_token',
        refreshToken: 'placeholder_refresh_token',
      );
      return _userMapper.toEntity(user);
    });
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return safeCall(() async {
      if (await _networkInfo.isConnected) {
        await _remote.logout();
      }
      await _local.clearUser();
      await _authService.clearToken();
      return unit;
    });
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No connection'));
    }
    final dto = RegisterRequestDto(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    return safeCall(() async {
      final user = await _remote.register(dto);
      await _local.cacheUser(user);
      await _authService.saveToken(
        accessToken: 'placeholder_access_token',
        refreshToken: 'placeholder_refresh_token',
      );
      return _userMapper.toEntity(user);
    });
  }
}
