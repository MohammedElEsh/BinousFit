import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, text }

/// Primary actions with Material 3 variants.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final child = switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      AppButtonVariant.secondary => FilledButton.tonal(
          onPressed: onPressed,
          child: Text(label),
        ),
      AppButtonVariant.outline => OutlinedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      AppButtonVariant.text => TextButton(
          onPressed: onPressed,
          child: Text(label),
        ),
    };
    if (expanded) {
      return SizedBox(width: double.infinity, child: child);
    }
    return child;
  }
}
