import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/common/news_card.dart';
import 'package:news_app/feature/fetch/controller/fetch_controller.dart';

class CustomSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  CustomSearchDelegate({required this.ref});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => GoRouter.of(context).pop(),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(searchNewsProvider(query)).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.articles!.length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                        authorName: data.articles![index].author.toString(),
                        title: data.articles![index].title.toString(),
                        imageUrl: data.articles![index].urlToImage.toString(),
                        publishedAt:
                            data.articles![index].publishedAt.toString(),
                        sourceName:
                            data.articles![index].source!.name.toString(),
                        description:
                            data.articles![index].description.toString(),
                      );
                    },
                  );
                },
                error: (error, _) {
                  return Text(error.toString());
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? const SizedBox()
        : Consumer(
            builder: (context, ref, child) {
              return ref.watch(searchNewsProvider(query)).when(
                    data: (data) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              authorName:
                                  data.articles![index].author.toString(),
                              title: data.articles![index].title.toString(),
                              imageUrl:
                                  data.articles![index].urlToImage.toString(),
                              publishedAt:
                                  data.articles![index].publishedAt.toString(),
                              sourceName:
                                  data.articles![index].source!.name.toString(),
                              description:
                                  data.articles![index].description.toString(),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, _) {
                      return Text(error.toString());
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
            },
          );
  }
}
