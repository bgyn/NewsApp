import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/onboarding_constant.dart';
import 'package:news_app/core/utils/shared_utility.dart';
import 'package:news_app/feature/onboarding/widget/doted_indicator.dart';
import 'package:news_app/theme/custom_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final Image image1;
  late final Image image2;
  late final Image image3;
  final _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    image1 = Image.asset(OnBoarding.onboardingPages[0]['image']!);
    image2 = Image.asset(OnBoarding.onboardingPages[1]['image']!);
    image3 = Image.asset(OnBoarding.onboardingPages[2]['image']!);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: OnBoarding.onboardingPages.length,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    height: height * 0.7,
                    width: width,
                    OnBoarding.onboardingPages[index]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          OnBoarding.onboardingPages[index]['title'].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 28),
                        ),
                        Text(
                          OnBoarding.onboardingPages[index]['description']
                              .toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ...List.generate(
                OnBoarding.onboardingPages.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DotedIndicator(isActive: index == currentIndex),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: !(currentIndex == 0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                          });
                        },
                        child: Text(
                          'Back',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: colors(context).color1),
                      onPressed: () {
                        if (currentIndex < 2) {
                          setState(() {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                          });
                        } else {
                          SharedUtility().setOnBoarding();
                          GoRouter.of(context).pushReplacement('/sigin');
                        }
                      },
                      child: Text(
                        currentIndex == 2 ? 'Get Started' : 'Next',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
