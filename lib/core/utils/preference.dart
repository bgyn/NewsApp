
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/utils/shared_utility.dart';

final preferenceNotifierProvider =
    StateNotifierProvider<PreferenceNotifier, bool>(
        (ref) => PreferenceNotifier());

class PreferenceNotifier extends StateNotifier<bool> {
  PreferenceNotifier() : super(false);

  void initializeRemeberMe(){
    state = SharedUtility().rememberMe();
  }

  void setPreferenceRemeberMe(bool value) {
    SharedUtility().setRemeberMe(value);
    state = value;
  }

  void setEmail(String email) {
    log(email);
    SharedUtility().setEmail(email);
  }

  String? getEmail() {
    return SharedUtility().getEmail();
  }
}
