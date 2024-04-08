import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/news_card.dart';
import 'package:news_app/feature/fetch/controller/fetch_controller.dart';
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
          const SearchWidget(),
          const SizedBox(
            height: 10,
          ),
          TrendingWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest",
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
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Text("All News ");
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ...ref.watch(categoryNewsProvider).when(
              data: (data) {
                return data.articles!.asMap().entries.map((article) {
                  int index = article.key;
                  return NewsCard(
                    authorName: data.articles![index].author.toString(),
                    title: data.articles![index].title.toString(),
                    imageUrl: data.articles![index].urlToImage.toString(),
                    sourceName: data.articles![index].source!.name.toString(),
                    publishedAt: data.articles![index].publishedAt.toString(),
                  );
                });
              },
              error: (error, _) {
                return [Text(error.toString())];
              },
              loading: () => [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ])
        ],
      ),
    );
  }
}
