import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Single onboarding slide: icon placeholder, title, description.
class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String titleKey;
  final String descriptionKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 120.sp, color: Theme.of(context).colorScheme.primary),
          SizedBox(height: 32.h),
          Text(
            tr(titleKey),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          Text(
            tr(descriptionKey),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
