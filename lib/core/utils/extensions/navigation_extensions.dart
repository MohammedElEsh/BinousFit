import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// go_router navigation helpers on [BuildContext].
extension NavigationExtensions on BuildContext {
  void appGo(String location) => GoRouter.of(this).go(location);

  void appPush(String location) => GoRouter.of(this).push(location);

  void appPop() => GoRouter.of(this).pop();
}
