import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const ErrorDialog({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}