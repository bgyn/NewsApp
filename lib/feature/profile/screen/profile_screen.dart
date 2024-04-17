import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              user!.profilePic == 'null'
                  ? SizedBox(
                      height: height * 0.12,
                      child: SizedBox(
                        width: width * 0.3,
                        child: Center(
                          child: Image.asset("assets/images/photo.png"),
                        ),
                      ))
                  : SizedBox(
                      height: height * 0.12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: user.profilePic!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
              Column(
                children: [
                  Text(
                    user.followers.length.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Followers",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    user.following.length.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Following",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            user.bio == null ? "" : user.bio.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => {GoRouter.of(context).pushNamed('edit-profile')},
                child: Container(
                  height: height * 0.05,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    "Edit Profile",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: height * 0.05,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    "Website",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
