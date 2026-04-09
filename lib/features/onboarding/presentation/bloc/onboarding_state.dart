import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

/// Number of onboarding slides (shared by UI and cubit).
const int kOnboardingPageCount = 3;

/// Onboarding pager state.
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool isLastPage,
    @Default(false) bool isCompleted,
  }) = _OnboardingState;
}
