import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const HomeScreen();
    },
  )
]);
