import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String _message;
  const CustomSnackBar({super.key, required String message})
      : _message = message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(_message),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
          label: 'X',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
    );
  }
}
