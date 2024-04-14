import 'package:flutter/material.dart';
import 'package:news_app/core/common/skeleton_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({super.key});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Skeleton(
            width: width * 0.3,
            height: height * 0.12,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: double.infinity,
                  height: height * 0.03,
                ),
                const SizedBox(
                  height: 5,
                ),
                Skeleton(
                  width: double.infinity,
                  height: height * 0.03,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(
                      width: double.infinity,
                      height: height * 0.03,
                    ),
                    Skeleton(
                      width: double.infinity,
                      height: height * 0.03,
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
