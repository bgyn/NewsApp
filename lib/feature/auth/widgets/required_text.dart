import 'package:flutter/material.dart';

class RequireText extends StatelessWidget {
  final String text;
  const RequireText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontSize: 16, color: Colors.grey),
        children: <TextSpan>[
          TextSpan(
            text: '*',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
