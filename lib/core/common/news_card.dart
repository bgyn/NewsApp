import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app/theme/custom_theme.dart';

class NewsCard extends ConsumerWidget {
  final String authorName;
  final String title;
  final String imageUrl;
  final String sourceName;
  final String publishedAt;
  final String description;
  const NewsCard({
    super.key,
    required this.authorName,
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedAt,
    required this.description,
  });

  void navigateToDetailScreen({
    required String title,
    required String imageUrl,
    required String publishedAt,
    required String description,
    required String authorName,
    required String soruceName,
    required BuildContext context,
  }) {
    GoRouter.of(context).pushNamed('detailScreen', pathParameters: {
      'title': title,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
      'description': description,
      'authorName': authorName,
      'sourceName': soruceName,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final format = DateFormat("MMMM dd,yyyy");
    return InkWell(
      onTap: () => navigateToDetailScreen(
        context: context,
        title: title,
        publishedAt: publishedAt,
        description: description,
        imageUrl: imageUrl,
        authorName: authorName,
        soruceName: sourceName,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: height * 0.12,
        width: width,
        child: Row(
          children: [
            SizedBox(
              height: height * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: width * 0.3,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          sourceName,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: colors(context).color2,
                                  ),
                        ),
                      ),
                      Text(
                        format.format(DateTime.parse(publishedAt)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: colors(context).color2,
                                ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
