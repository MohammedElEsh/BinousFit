import 'package:binousfit/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,

    this.isLoading = false,
    this.isDisabled = false,

    this.width = double.infinity,
    this.height = 50,

    this.backgroundColor = AppColors.mainBlue,
    this.textColor = AppColors.mainWhite,
    this.borderRadius = 12,
    this.elevation = 0,

    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),

    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;

  // states
  final bool isLoading;
  final bool isDisabled;

  // size
  final double width;
  final double height;

  // style
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;

  // extras
  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: AppColors.mainGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    }

    final textWidget = Text(
      text,
      style: textStyle ?? AppTextStyles.button,
    );

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: 8.w),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
