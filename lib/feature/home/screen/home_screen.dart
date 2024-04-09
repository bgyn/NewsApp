import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/news_card.dart';
import 'package:news_app/core/constants/latest_news_list_constant.dart';
import 'package:news_app/feature/fetch/controller/fetch_controller.dart';
import 'package:news_app/feature/home/widgets/search_widget.dart';
import 'package:news_app/feature/home/widgets/trending_widget.dart';

final latestNewsIndexProvider = StateProvider<int>((ref) => 0);

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
          const TrendingWidget(),
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
          Consumer(
            builder: (buildcontext, ref, child) {
              final latestNewsIndex = ref.watch(latestNewsIndexProvider);
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: LatestNewsList.latesNewsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => ref
                              .read(latestNewsIndexProvider.notifier)
                              .update((state) => index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: ref.read(latestNewsIndexProvider) == index
                                  ? Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Text(
                              "${LatestNewsList.latesNewsList[index]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...ref
                      .watch(categoryNewsProvider(
                          LatestNewsList.latesNewsList[latestNewsIndex]))
                      .when(
                          data: (data) {
                            return data.articles!
                                .asMap()
                                .entries
                                .map((article) {
                              int index = article.key;
                              if (index < 15) {
                                return NewsCard(
                                  authorName:
                                      data.articles![index].author.toString(),
                                  title: data.articles![index].title.toString(),
                                  imageUrl: data.articles![index].urlToImage
                                      .toString(),
                                  sourceName: data.articles![index].source!.name
                                      .toString(),
                                  publishedAt: data.articles![index].publishedAt
                                      .toString(),
                                );
                              }
                              return const SizedBox();
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
              );
            },
          )
        ],
      ),
    );
  }
}
