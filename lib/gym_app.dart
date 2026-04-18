import 'package:binousfit/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

class GymApp extends StatelessWidget {
  const GymApp({required this.appRouter, super.key});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.onBoarding,
          theme: ThemeData(
            primaryColor: AppColors.mainBlue,
            scaffoldBackgroundColor: AppColors.mainWhite,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
