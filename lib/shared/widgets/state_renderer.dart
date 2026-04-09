import 'package:flutter/material.dart';

import 'error_widget.dart';
import 'loading_widget.dart';

/// Maps simple state flags to common UI (placeholder pattern).
class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.loading,
    required this.errorMessage,
    required this.child,
    this.onRetry,
  });

  final bool loading;
  final String? errorMessage;
  final Widget child;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LoadingWidget();
    }
    if (errorMessage != null) {
      return AppErrorWidget(message: errorMessage!, onRetry: onRetry);
    }
    return child;
  }
}
