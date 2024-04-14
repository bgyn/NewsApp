import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/home/widgets/custom_search_delegate.dart';
import 'package:news_app/theme/custom_theme.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await showSearch(
          context: context,
          delegate: CustomSearchDelegate(ref: ref),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: colors(context).color4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: colors(context).color3,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Search",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Icon(
              Icons.manage_search,
              color: colors(context).color3,
            )
          ],
        ),
      ),
    );
  }
}
