import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_route/route.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/model/user_model.dart';
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
  await SharedUtility.ensureInitalize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  Future<UserModel?> getData(WidgetRef ref, String uid) async {
    if (kDebugMode) {
      print("User id : $uid");
    }
    userModel =
        await ref.watch(authControllerProvider.notifier).getUserInfo(uid).first;
    if (kDebugMode) {
      print("AFter that line ");
    }
    ref.read(userProvider.notifier).update((state) => userModel);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              return FutureBuilder(
                future: getData(ref, data.uid),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'Khabar',
                    theme:
                        getAppTheme(context, ref.watch(themeNotifierProvider)),
                    routeInformationParser: snapshot.hasData
                        ? loginRoute.routeInformationParser
                        : logoutRoute.routeInformationParser,
                    routeInformationProvider: snapshot.hasData
                        ? loginRoute.routeInformationProvider
                        : logoutRoute.routeInformationProvider,
                    routerDelegate: snapshot.hasData
                        ? loginRoute.routerDelegate
                        : logoutRoute.routerDelegate,
                  );
                }),
              );
            } else {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Khabar',
                theme: getAppTheme(context, ref.watch(themeNotifierProvider)),
                routeInformationParser: logoutRoute.routeInformationParser,
                routeInformationProvider: logoutRoute.routeInformationProvider,
                routerDelegate: logoutRoute.routerDelegate,
              );
            }
          },
          error: (error, _) {
            return Text("$error");
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
