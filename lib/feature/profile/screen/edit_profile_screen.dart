import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/custom_textfield.dart';
import 'package:news_app/core/common/required_text.dart';
import 'package:news_app/core/utils/pick_image.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/profile/controller/profile_controller.dart';
import 'package:news_app/theme/custom_theme.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController fullnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;
  File? profileFile;

  void selecteProfile() async {
    final result = await pickImage();
    if (result != null) {
      setState(() {
        profileFile = File(result.files.first.path!);
      });
    }
  }

  void updateProfile() {
    ref.read(profileControllerProvider.notifier).updateProfile(
          profileFile: profileFile,
          userName: usernameController.text.trim(),
          fullName: fullnameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          bio: bioController.text.trim(),
        );
  }

  @override
  void initState() {
    super.initState();
    usernameController =
        TextEditingController(text: ref.read(userProvider)?.userName ?? '');
    fullnameController =
        TextEditingController(text: ref.read(userProvider)?.fullName ?? '');
    emailController =
        TextEditingController(text: ref.read(userProvider)?.email ?? '');
    phoneController = TextEditingController(
        text: ref.read(userProvider)?.phoneNumber == null
            ? ''
            : ref.read(userProvider)!.phoneNumber.toString());
    bioController =
        TextEditingController(text: ref.read(userProvider)?.bio ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    final user = ref.read(userProvider);
    final isLoading = ref.watch(profileControllerProvider);
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
              onPressed: () => updateProfile(),
              icon: Icon(
                Icons.check,
                color: colors(context).color3,
              ))
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ref.watch(getUserInfoProvider(user!.uid)).when(
                data: (user) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () => selecteProfile(),
                            child: Stack(
                              children: [
                                profileFile != null
                                    ? SizedBox(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox(
                                            child: Center(
                                              child: Image.file(
                                                profileFile!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ))
                                    : user!.profilePic == 'null'
                                        ? ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox(
                                                height: height * 0.15,
                                                child: SizedBox(
                                                  width: width * 0.3,
                                                  child: Center(
                                                    child: Image.asset(
                                                        "assets/images/photo.png"),
                                                  ),
                                                )),
                                          )
                                        : SizedBox(
                                            height: height * 0.15,
                                            child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: user.profilePic!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                  );
                },
                error: (error, _) {
                  return Text(error.toString());
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
    );
  }
}
