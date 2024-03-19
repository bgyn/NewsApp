import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/utils/shared_utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final onBoarding = SharedUtility().getOnBoarding();
    Timer(const Duration(seconds: 3), () {
      if (onBoarding) {
        GoRouter.of(context).pushReplacement('/sigin');
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
