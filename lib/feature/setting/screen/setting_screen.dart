import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/setting/widget/custom_listtile.dart';
import 'package:news_app/theme/custom_theme.dart';
import 'package:news_app/theme/theme_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Setting",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          CustomListtile(
            leading: Icon(
              Icons.notifications_outlined,
              color: colors(context).color3,
            ),
            title: 'Notification',
            trailing:
                Icon(Icons.keyboard_arrow_right, color: colors(context).color3),
            trailingFunction: () {},
          ),
          CustomListtile(
            leading: Icon(Icons.lock_outline, color: colors(context).color3),
            title: 'Security',
            trailing:
                Icon(Icons.keyboard_arrow_right, color: colors(context).color3),
            trailingFunction: () {},
          ),
          CustomListtile(
            leading: Icon(Icons.help_outline, color: colors(context).color3),
            title: 'Help',
            trailing:
                Icon(Icons.keyboard_arrow_right, color: colors(context).color3),
            trailingFunction: () {},
          ),
          CustomListtile(
            leading:
                Icon(Icons.dark_mode_outlined, color: colors(context).color3),
            title: 'Dark Mode',
            trailing: Switch(
                value: ref.watch(themeNotifierProvider),
                onChanged: (_) {
                  ref.read(themeNotifierProvider.notifier).toogleTheme();
                }),
          ),
          CustomListtile(
            leading: Icon(Icons.logout, color: colors(context).color3),
            title: 'Logout',
            onTap: () => logOut(ref),
          )
        ],
      ),
    );
  }
}
