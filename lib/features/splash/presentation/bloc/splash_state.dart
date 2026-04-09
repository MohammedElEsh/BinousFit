import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

/// Splash routing intents.
@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.navigateToOnboarding() = _NavigateToOnboarding;
  const factory SplashState.navigateToHome() = _NavigateToHome;
  const factory SplashState.navigateToAuth() = _NavigateToAuth;
}
