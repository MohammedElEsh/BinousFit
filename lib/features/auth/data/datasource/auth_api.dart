import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/user_model.dart';

part 'auth_api.g.dart';

/// Retrofit client for auth endpoints (generated implementation).
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<UserModel> login(@Body() LoginRequestDto body);

  @POST('/auth/register')
  Future<UserModel> register(@Body() RegisterRequestDto body);

  @POST('/auth/logout')
  Future<void> logout();
}
