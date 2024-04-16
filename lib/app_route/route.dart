import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/provider/firebase_provider.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/auth/screen/sigin_screen.dart';
import 'package:news_app/feature/auth/screen/singnup_screen.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';
import 'package:news_app/feature/news/screens/detail_news_screen.dart';
import 'package:news_app/feature/onboarding/screen/onboarding_screen.dart';
import 'package:news_app/feature/root/screen/root_screen.dart';
import 'package:news_app/feature/setting/screen/setting_screen.dart';
import 'package:news_app/feature/splash/screen/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref: ref);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: (context, state) => router._redirectLogic(state),
    routes: router._routes,
  );
});

final logoutRoute = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: 'signin',
      path: '/signin',
      builder: (context, state) {
        return SigninScreen();
      },
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) {
        return SignupScreen();
      },
    ),
    GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) {
          return const OnboardingScreen();
        }),
  ],
);

final loginRoute = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'root',
      builder: (context, state) {
        return const RootScreen();
      },
    ),
    GoRoute(
      name: 'home',
      path: "/home",
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) {
          return const OnboardingScreen();
        }),
    GoRoute(
      name: 'signin',
      path: '/signin',
      builder: (context, state) {
        return SigninScreen();
      },
    ),
    GoRoute(
        name: 'setting',
        path: '/profile/setting',
        builder: (context, state) {
          return const SettingScreen();
        }),
    GoRoute(
        name: 'detailScreen',
        path:
            '/detailScreen/:title/:imageUrl/:description/:publishedAt/:authorName/:sourceName',
        builder: (context, state) {
          final title = state.pathParameters['title'];
          final imageUrl = state.pathParameters['imageUrl'];
          final description = state.pathParameters['description'];
          final publishedAt = state.pathParameters['publishedAt'];
          final authorName = state.pathParameters['authorName'];
          final sourcename = state.pathParameters['sourceName'];
          return DetailNewsScreen(
            title: title.toString(),
            publishedAt: publishedAt.toString(),
            description: description.toString(),
            imageUrl: imageUrl.toString(),
            authorName: authorName.toString(),
            sourceName: sourcename.toString(),
          );
        })
  ],
);

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier({required Ref ref}) : _ref = ref {
    _ref.listen(authStateChangeProvider, (_, __) {
      notifyListeners();
    });
  }

  String? _redirectLogic(GoRouterState state) {
    final bool authState =
        _ref.watch(FirebaseProvider.firebaseAuthProvider).currentUser != null;
    final bool isLogginIn =
        state.fullPath == '/signin' || state.fullPath == '/signup';
    if (state.fullPath == '/splash') {
      return null;
    }
    if (authState && isLogginIn) {
      return '/';
    }
    if (!authState && isLogginIn) {
      return '/signin';
    }
    if (authState && !isLogginIn) {
      return null;
    }
    if (!authState && !isLogginIn) {
      return '/signin';
    }
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          name: 'root',
          builder: (context, state) {
            return const RootScreen();
          },
        ),
        GoRoute(
          name: 'home',
          path: "/home",
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
            name: 'onboarding',
            path: '/onboarding',
            builder: (context, state) {
              return const OnboardingScreen();
            }),
        GoRoute(
          name: 'signin',
          path: '/signin',
          builder: (context, state) {
            return SigninScreen();
          },
        ),
        GoRoute(
          name: 'signup',
          path: '/signup',
          builder: (context, state) {
            return SignupScreen();
          },
        ),
        GoRoute(
            name: 'setting',
            path: '/profile/setting',
            builder: (context, state) {
              return const SettingScreen();
            }),
        GoRoute(
            name: 'detailScreen',
            path:
                '/detailScreen/:title/:imageUrl/:description/:publishedAt/:authorName/:sourceName',
            builder: (context, state) {
              final title = state.pathParameters['title'];
              final imageUrl = state.pathParameters['imageUrl'];
              final description = state.pathParameters['description'];
              final publishedAt = state.pathParameters['publishedAt'];
              final authorName = state.pathParameters['authorName'];
              final sourcename = state.pathParameters['sourceName'];
              return DetailNewsScreen(
                title: title.toString(),
                publishedAt: publishedAt.toString(),
                description: description.toString(),
                imageUrl: imageUrl.toString(),
                authorName: authorName.toString(),
                sourceName: sourcename.toString(),
              );
            })
      ];
}
