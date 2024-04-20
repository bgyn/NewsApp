import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/fetch/controller/fetch_controller.dart';
import 'package:news_app/feature/home/widgets/news_headlin_card.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          Text(
            "Popular Topic",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          ...ref.watch(popularNewsProvider).when(
              data: (news) {
                return news.articles!.asMap().entries.map((e) {
                  int index = e.key;
                  return NewsHeadlineCard(
                    authorName: news.articles![index].author.toString(),
                    title: news.articles![index].title.toString(),
                    imageUrl: news.articles![index].urlToImage.toString(),
                    sourceName: news.articles![index].source!.name.toString(),
                    publishedAt: news.articles![index].publishedAt.toString(),
                    description: news.articles![index].description.toString(),
                  );
                });
              },
              error: (error, _) {
                return [Text(error.toString())];
              },
              loading: () => [
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ]),
        ],
      ),
    );
  }
}
