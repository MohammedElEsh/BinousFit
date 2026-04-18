import 'package:flutter/material.dart';

extension NavigationX on BuildContext {
  // =========================
  // 🔹 PUSH (Widget)
  // =========================
  Future<T?> push<T extends Object?>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => page,
      ),
    );
  }

  // =========================
  // 🔹 PUSH NAMED (String Route)
  // =========================
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  // =========================
  // 🔹 REPLACE (Widget)
  // =========================
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => page,
      ),
      result: result,
    );
  }

  // =========================
  // 🔹 REPLACE NAMED
  // =========================
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  // =========================
  // 🔹 CLEAR STACK + PUSH
  // =========================
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute<T>(
        builder: (_) => page,
      ),
      (route) => false,
    );
  }

  // =========================
  // 🔹 CLEAR STACK + NAMED
  // =========================
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // =========================
  // 🔹 POP
  // =========================
  void pop<T extends Object?>([T? result]) {
    Navigator.pop<T>(this, result);
  }

  // =========================
  // 🔹 POP UNTIL FIRST
  // =========================
  void popToFirst() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }

  // =========================
  // 🔹 CAN POP
  // =========================
  bool get canPop => Navigator.canPop(this);
}
