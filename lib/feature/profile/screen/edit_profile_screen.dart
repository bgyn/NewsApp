import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/custom_textfield.dart';
import 'package:news_app/core/common/required_text.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/theme/custom_theme.dart';

class EditProfileScreen extends ConsumerWidget {
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final user = ref.watch(userProvider);
    usernameController.text = user?.userName ?? '';
    fullnameController.text = user?.fullName ?? '';
    emailController.text = user!.email;
    phoneController.text =
        user.phoneNumber == null ? '' : user.phoneNumber.toString();
    bioController.text = user.bio ?? '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: colors(context).color3,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  user.profilePic == 'null'
                      ? SizedBox(
                          height: height * 0.15,
                          child: SizedBox(
                            width: width * 0.3,
                            child: Center(
                              child: Image.asset("assets/images/photo.png"),
                            ),
                          ))
                      : SizedBox(
                          height: height * 0.15,
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
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Username',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey),
            ),
            CustomTextField(
              controller: usernameController,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Full Name',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey),
            ),
            CustomTextField(
              controller: fullnameController,
            ),
            const SizedBox(
              height: 10,
            ),
            const RequireText(text: 'Email Address'),
            CustomTextField(
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            const RequireText(text: 'Phone Number'),
            CustomTextField(
              controller: phoneController,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Bio',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey),
            ),
            CustomTextField(
              controller: bioController,
            ),
          ],
        ),
      ),
    );
  }
}
