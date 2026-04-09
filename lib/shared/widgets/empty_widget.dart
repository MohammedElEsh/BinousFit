import 'package:flutter/material.dart';

/// Empty state with optional asset (Lottie path can be wired later).
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.message, this.assetPath});

  final String message;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (assetPath != null)
            const Icon(Icons.inbox_outlined, size: 64)
          else
            const Icon(Icons.inbox_outlined, size: 64),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
