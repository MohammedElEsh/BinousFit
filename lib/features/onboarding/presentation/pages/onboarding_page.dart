import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/localization/locale_keys.dart';
import '../../../../config/router/route_names.dart';
import '../../../../injection_container.dart';
import '../../../../shared/components/app_button.dart';
import '../bloc/onboarding_cubit.dart';
import '../bloc/onboarding_state.dart' show OnboardingState, kOnboardingPageCount;
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_item.dart';

/// Three-step onboarding with skip / next.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.go(RouteNames.login);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.read<OnboardingCubit>().skip(),
                      child: Text(tr(OnboardingKeys.skip)),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (i) =>
                          context.read<OnboardingCubit>().goToPage(i),
                      children: const [
                        OnboardingItem(
                          titleKey: OnboardingKeys.page1Title,
                          descriptionKey: OnboardingKeys.page1Desc,
                        ),
                        OnboardingItem(
                          titleKey: OnboardingKeys.page2Title,
                          descriptionKey: OnboardingKeys.page2Desc,
                        ),
                        OnboardingItem(
                          titleKey: OnboardingKeys.page3Title,
                          descriptionKey: OnboardingKeys.page3Desc,
                        ),
                      ],
                    ),
                  ),
                  OnboardingIndicator(length: 3, index: state.currentPage),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: AppButton(
                      label: state.isLastPage
                          ? tr(OnboardingKeys.getStarted)
                          : tr(OnboardingKeys.next),
                      onPressed: () async {
                        final cubit = context.read<OnboardingCubit>();
                        if (state.currentPage >= kOnboardingPageCount - 1) {
                          await cubit.complete();
                        } else {
                          await _controller.animateToPage(
                            state.currentPage + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
