import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/custom_snackbar.dart';
import 'package:news_app/core/provider/storage_repository.dart';
import 'package:news_app/feature/auth/controller/auth_controller.dart';
import 'package:news_app/feature/profile/repository/profile_repository.dart';
import 'package:news_app/model/user_model.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  return ProfileController(
      profileRepository: ref.read(profileRepositoryProvider),
      ref: ref,
      storageRepository: ref.read(storageRepositoryProvider));
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  ProfileController(
      {required ProfileRepository profileRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _profileRepository = profileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);
  void updateProfile({
    File? profileFile,
    required String userName,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String bio,
  }) async {
    UserModel userModel = _ref.read(userProvider)!;
    state = true;
    if (profileFile != null) {
      final res = await _storageRepository.storeField(
        path: '/users/profile',
        id: userModel.uid,
        file: profileFile,
      );
      res.fold((l) => CustomSnackBar(message: l.toString()), (r) {
        userModel = userModel.copyWith(profilePic: r);
      });
    }
    if (userName != userModel.userName) {
      userModel = userModel.copyWith(userName: userName);
    }
    if (fullName != userModel.fullName) {
      userModel = userModel.copyWith(fullName: fullName);
    }
    if (email != userModel.email) {
      userModel = userModel.copyWith(email: email);
    }
    if (phoneNumber != userModel.phoneNumber.toString()) {
      userModel = userModel.copyWith(phoneNumber: int.parse(phoneNumber));
    }
    if (bio != userModel.bio) {
      userModel = userModel.copyWith(bio: bio);
    }
    state = false;
    final result = await _profileRepository.updateProfile(userModel);
    result.fold((l) => CustomSnackBar(message: l.toString()),
        (r) => _ref.read(userProvider.notifier).update((state) => userModel));
  }
}
