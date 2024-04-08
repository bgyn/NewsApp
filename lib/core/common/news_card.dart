import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/theme/custom_theme.dart';

class NewsCard extends ConsumerWidget {
  final String authorName;
  final String title;
  final String imageUrl;
  final String sourceName;
  final String publishedAt;
  const NewsCard({
    super.key,
    required this.authorName,
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedAt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final format = DateFormat("MMMM dd,yyyy");
    return Container(
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
                    Text(
                      sourceName,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colors(context).color2,
                          ),
                    ),
                    Text(
                      format.format(DateTime.parse(publishedAt)),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
    );
  }
}
