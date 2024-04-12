import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/fetch/controller/fetch_controller.dart';
import 'package:news_app/feature/home/widgets/news_headlin_card.dart';

class TrendingWidget extends ConsumerWidget {
  const TrendingWidget({super.key});

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
            child: ref.watch(trendingNewsProvider).when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NewsHeadlineCard(
                        imageUrl: data.articles![index].urlToImage.toString(),
                        title: data.articles![index].title.toString(),
                        publishedAt: 
                            data.articles![index].publishedAt.toString(),
                        sourceName:
                            data.articles![index].source!.name.toString(),
                        authorName: data.articles![index].author.toString(),
                        description:
                            data.articles![index].description.toString(),
                      );
                    },
                  );
                },
                error: (error, errorstack) {
                  return Text(error.toString());
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator())))
      ],
    );
  }
}
