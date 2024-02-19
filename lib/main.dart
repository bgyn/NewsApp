import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';
import 'package:news_app/theme/custom_theme.dart';
import 'package:news_app/theme/theme_provider.dart';
import 'package:news_app/core/utils/shared_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedUtility.ensureInitalize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Khabar',
      theme: getAppTheme(context, ref.watch(themeNotifierProvider)),
      home: const HomeScreen(),
    );
  }
}
