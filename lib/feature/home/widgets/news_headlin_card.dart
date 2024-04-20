import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app/theme/custom_theme.dart';

class NewsHeadlineCard extends ConsumerWidget {
  final String imageUrl;
  final String sourceName;
  final String title;
  final String publishedAt;
  final String authorName;
  final String description;
  const NewsHeadlineCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.publishedAt,
      required this.authorName,
      required this.description,
      required this.sourceName});

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
        authorName: authorName,
        context: context,
        description: description,
        imageUrl: imageUrl,
        publishedAt: publishedAt,
        soruceName: sourceName,
        title: title,
      ),
      child: SizedBox(
        width: width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            imageUrl == 'null'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: height * 0.2,
                      child: Center(
                        child: Image.asset("assets/images/photo.png"),
                      ),
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: width,
                      height: height * 0.2,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sourceName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colors(context).color2),
                ),
                Text(
                  format.format(DateTime.parse(publishedAt)),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: colors(context).color2),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
