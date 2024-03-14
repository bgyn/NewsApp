import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/common/custom_snackbar.dart';
import 'package:news_app/feature/auth/repository/auth_repository.dart';
import 'package:news_app/model/user_model.dart';

final authControllerProvider = StateNotifierProvider(
  (ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.read(authControllerProvider.notifier);
  return authController.authStateChanges;
});

final getCurrentUserInfoProvider = FutureProvider((ref) {
  final authController = ref.read(authControllerProvider.notifier);
  return authController.getCurrentUserInfo();
});

final getUserInfoProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.read(authControllerProvider.notifier);
  return authController.getUserInfo(uid);
});


final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChanges => _authRepository.authStatechanges;

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await _authRepository.getCurrentUserInfo();
    return user;
  }

  void signInWithGoogle() async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => CustomSnackBar(message: l.message),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void signInWithEmailPassword(
      {required String email, required String password}) async {
    state = true;
    final user = await _authRepository.signInWithEmailPassword(
        email: email, password: password);
    state = false;
    user.fold(
      (l) => CustomSnackBar(message: l.message),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void signUpWithEmailPassword(
      {required String email, required String password}) async {
    state = true;
    final user = await _authRepository.signUpWithEmailPassword(
        email: email, password: password);
    state = false;
    user.fold(
      (l) => CustomSnackBar(message: l.message),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void logOut() {
    _authRepository.logOut();
  }

  Stream<UserModel?> getUserInfo(String uid) {
    return _authRepository.getUserData(uid);
  }
}
