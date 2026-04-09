import 'package:flutter/material.dart';

/// Simple alert-style dialog.
Future<void> showAppDialog({
  required BuildContext context,
  required String title,
  required String message,
  List<Widget>? actions,
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions ??
          [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
    ),
  );
}
