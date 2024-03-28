import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/home/widgets/news_headlin_card.dart';
import 'package:news_app/model/fake_model.dart';
import 'package:news_app/model/news_model.dart';

class TrendingWidget extends ConsumerWidget {
  TrendingWidget({super.key});
  final data = NewsModel.fromJson(fakeData);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trending",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "See all",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return const NewsHeadlineCard();
            },
          ),
        )
      ],
    );
  }
}
