import 'package:flutter/material.dart';

Widget asyncState({
  required bool isLoading,
  required String? error,
  required Widget child,
  required VoidCallback onRetry,
}) {
  if (isLoading) return const Center(child: CircularProgressIndicator());
  if (error != null) {
    return Center(
      child: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: Text('Coba lagi: $error'),
      ),
    );
  }
  return child;
}
