import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/utils/preference.dart';
import 'package:news_app/core/utils/shared_utility.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final onBoarding = SharedUtility().getOnBoarding();
    Timer(const Duration(seconds: 3), () {
      if (onBoarding) {
        ref.read(preferenceNotifierProvider.notifier).initializeRemeberMe();
        GoRouter.of(context).pushReplacement('/signin');
      } else {
        GoRouter.of(context).pushReplacement('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/kabar.png'),
      ),
    );
  }
}
