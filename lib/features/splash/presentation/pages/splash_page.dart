import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/localization/locale_keys.dart';
import '../../../../config/router/route_names.dart';
import '../../../../injection_container.dart';
import '../bloc/splash_cubit.dart';
import '../bloc/splash_state.dart';

/// Logo / splash then navigates via [SplashCubit].
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..checkAuth(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          state.whenOrNull(
            navigateToOnboarding: () =>
                context.go(RouteNames.onboarding),
            navigateToHome: () => context.go(RouteNames.home),
            navigateToAuth: () => context.go(RouteNames.login),
          );
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fitness_center, size: 80.sp),
                SizedBox(height: 24.h),
                Text(
                  tr(CommonKeys.loading),
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
