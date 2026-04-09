import '../../../../core/constants/app_constants.dart';
import '../../../../core/cubit/base_cubit.dart';
import '../../../../core/services/local_storage_service.dart';
import 'onboarding_state.dart';

/// PageView controller logic for onboarding.
class OnboardingCubit extends BaseCubit<OnboardingState> {
  OnboardingCubit(this._localStorage)
      : super(const OnboardingState());

  final LocalStorageService _localStorage;

  void goToPage(int index) {
    final lastIndex = kOnboardingPageCount - 1;
    safeEmit(
      state.copyWith(
        currentPage: index.clamp(0, lastIndex),
        isLastPage: index >= lastIndex,
      ),
    );
  }

  Future<void> skip() => complete();

  Future<void> complete() async {
    await _localStorage.setBool(AppConstants.keyOnboardingSeen, true);
    safeEmit(state.copyWith(isCompleted: true));
  }
}
