import 'package:flutter/material.dart';

/// Durations and curves for motion.
class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve standardCurve = Curves.easeInOut;
}
