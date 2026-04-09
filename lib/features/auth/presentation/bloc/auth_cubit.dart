import '../../../../core/cubit/base_cubit.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../../../core/usecase/no_params.dart';
import 'auth_state.dart';

/// Coordinates auth flows via use cases only.
class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCachedUserUseCase getCachedUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _getCachedUserUseCase = getCachedUserUseCase,
        super(const AuthState.initial());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  Future<void> restoreSession() async {
    safeEmit(const AuthState.loading());
    final result = await _getCachedUserUseCase(const NoParams());
    result.fold(
      (f) {
        handleError(f);
        safeEmit(AuthState.error(f.message ?? 'Error'));
      },
      (user) {
        if (user != null) {
          safeEmit(AuthState.authenticated(user));
        } else {
          safeEmit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    safeEmit(const AuthState.loading());
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (f) {
        handleError(f);
        safeEmit(AuthState.error(f.message ?? 'Login failed'));
      },
      (user) => safeEmit(AuthState.authenticated(user)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    safeEmit(const AuthState.loading());
    final result = await _registerUseCase(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
    result.fold(
      (f) {
        handleError(f);
        safeEmit(AuthState.error(f.message ?? 'Register failed'));
      },
      (user) => safeEmit(AuthState.authenticated(user)),
    );
  }

  Future<void> logout() async {
    safeEmit(const AuthState.loading());
    final result = await _logoutUseCase(const NoParams());
    result.fold(
      (f) {
        handleError(f);
        safeEmit(AuthState.error(f.message ?? 'Logout failed'));
      },
      (_) => safeEmit(const AuthState.unauthenticated()),
    );
  }
}
