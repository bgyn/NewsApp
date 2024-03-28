import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/fake_model.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/theme/custom_theme.dart';

class NewsHeadlineCard extends ConsumerWidget {
  const NewsHeadlineCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final data = NewsModel.fromJson(fakeData);
    final format = DateFormat("MMMM dd,yyyy");
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: data.articles![2].urlToImage.toString(),
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
            "${data.articles![2].title}",
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
                "${data.articles![2].source!.name}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: colors(context).color2),
              ),
              Text(
                format.format(
                    DateTime.parse(data.articles![2].publishedAt.toString())),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: colors(context).color2),
              )
            ],
          )
        ],
      ),
    );
  }
}
