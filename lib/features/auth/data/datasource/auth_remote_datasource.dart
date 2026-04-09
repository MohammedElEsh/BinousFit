import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/user_model.dart';
import 'auth_api.dart';

/// Remote auth operations (network).
abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequestDto dto);
  Future<UserModel> register(RegisterRequestDto dto);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._api);

  final AuthApi _api;

  @override
  Future<UserModel> login(LoginRequestDto dto) => _api.login(dto);

  @override
  Future<void> logout() => _api.logout();

  @override
  Future<UserModel> register(RegisterRequestDto dto) =>
      _api.register(dto);
}
