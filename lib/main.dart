import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/route.dart';
import 'package:news_app/theme/custom_theme.dart';
import 'package:news_app/theme/theme_provider.dart';
import 'package:news_app/core/utils/shared_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MaterialApp.router(
      title: 'Khabar',
      theme: getAppTheme(context, ref.watch(themeNotifierProvider)),
      routerConfig: router,
    );
  }
}
