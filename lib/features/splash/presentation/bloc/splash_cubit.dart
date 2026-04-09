import '../../../../core/constants/app_constants.dart';
import '../../../../core/cubit/base_cubit.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/local_storage_service.dart';
import 'splash_state.dart';

/// Decides first screen after splash delay.
class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required AuthService authService,
    required LocalStorageService localStorage,
  })  : _authService = authService,
        _localStorage = localStorage,
        super(const SplashState.initial());

  final AuthService _authService;
  final LocalStorageService _localStorage;

  Future<void> checkAuth() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final onboarded =
        await _localStorage.getBool(AppConstants.keyOnboardingSeen) ?? false;
    final logged = await _authService.isLoggedIn();
    if (!onboarded) {
      safeEmit(const SplashState.navigateToOnboarding());
    } else if (logged) {
      safeEmit(const SplashState.navigateToHome());
    } else {
      safeEmit(const SplashState.navigateToAuth());
    }
  }
}
