import 'package:flutter/material.dart';

class DotedIndicator extends StatelessWidget {
  final bool isActive;
  const DotedIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
