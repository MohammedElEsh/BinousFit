import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void push(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushReplacement(Widget page) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop() {
    Navigator.pop(this);
  }
}
