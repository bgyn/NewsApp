import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/home/widgets/search_widget.dart';
import 'package:news_app/feature/home/widgets/trending_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          SearchWidget(),
          const SizedBox(
            height: 10,
          ),
          TrendingWidget(),
        ],
      ),
    );
  }
}
