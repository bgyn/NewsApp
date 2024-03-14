import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/auth/screen/sigin_screen.dart';
import 'package:news_app/feature/auth/screen/singnup_screen.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';
import 'package:news_app/feature/onboarding/screen/onboarding_screen.dart';
import 'package:news_app/feature/splash/screen/splash_screen.dart';
import 'package:routemaster/routemaster.dart';

final router = GoRouter(
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
          }),
      GoRoute(
        name: 'Signin',
        path: '/sigin',
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
      )
    ],
    redirect: (context, state) {
      final isAuthenticated =
          FirebaseAuth.instance.currentUser != null ? true : false;
      if (state.fullPath == '/splash') {
        return null;
      }
      if (isAuthenticated) {
        return '/';
      }
      return null;
    });

