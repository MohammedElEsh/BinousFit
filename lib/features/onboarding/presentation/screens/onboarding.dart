import 'package:binousfit/shared/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigation_extension.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.h),
        child: Center(
          child: AppButton(
            text: 'Login',
            backgroundColor: AppColors.mainBlue,
            textColor: AppColors.mainWhite,
            onPressed: () {
              context.pushNamed(Routes.login);
            },
          ),
        ),
      ),
    );
  }
}
