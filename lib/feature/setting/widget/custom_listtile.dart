import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  final dynamic trailing;
  final String title;
  final Icon leading;
  final Function()? trailingFunction;
  final Function()? onTap;
  const CustomListtile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.trailingFunction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      trailing: trailing != null
          ? GestureDetector(
              onTap: trailingFunction != null ? () => trailingFunction : null,
              child: trailing,
            )
          : null,
      onTap: onTap,
    );
  }
}
