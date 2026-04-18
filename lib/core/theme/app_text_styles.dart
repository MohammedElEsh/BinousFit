import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headingLarge = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.mainBlue,
  );

  static TextStyle headingMedium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    color: AppColors.mainGray,
  );

  static TextStyle button = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
}
