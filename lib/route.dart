import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';
import 'package:news_app/feature/onboarding/screen/onboarding_screen.dart';
import 'package:news_app/feature/splash/screen/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: "/",
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
        })
  ],
);
