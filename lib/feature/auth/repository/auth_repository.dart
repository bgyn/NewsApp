import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/core/constants/collection_constant.dart';
import 'package:news_app/core/provider/firebase_provider.dart';
import 'package:news_app/core/utils/faliure.dart';
import 'package:news_app/core/utils/typedef.dart';
import 'package:news_app/model/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseAuth: ref.read(FirebaseProvider.firebaseAuthProvider),
    firebaseFirestore: ref.read(FirebaseProvider.firebaseFirestoreProvider),
    googleSignIn: ref.read(FirebaseProvider.googleSiginProvider)));

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _user =>
      _firebaseFirestore.collection(CollectionConstant.userCollection);

  Stream<User?> get authStatechanges => _firebaseAuth.authStateChanges();

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo = await _firebaseFirestore
        .collection(CollectionConstant.userCollection)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (userInfo.data() == null) return null;
    user = UserModel.fromMap(userInfo.data() as Map<String, dynamic>);
    return user;
  }

  Stream<UserModel> getUserData(String? uid) {
    return _user
        .doc(uid)
        .snapshots()
        .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
        .handleError((error) {
      print(error.toString());
    });
  }

  //sigin with google
  FutureEither<UserModel> signInWithGoogle() async {
    UserCredential userCredential;
    UserModel userModel;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          uid: userCredential.user!.uid,
          userName: userCredential.user?.displayName ?? '',
          fullName: userCredential.user?.displayName ?? '',
          email: userCredential.user?.email ?? '',
          profilePic: userCredential.user?.photoURL ?? '',
          followers: [],
          following: [],
        );
        await _user.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureEither<UserModel> signUpWithEmailPassword(
      {required String email, required String password}) async {
    UserModel userModel;
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          uid: credential.user!.uid,
          userName: '',
          fullName: '',
          email: email,
          followers: [],
          following: [],
        );
        await _user.doc(credential.user!.uid).set(userModel.toMap());
        return right(userModel);
      } else {
        return left(Faliure('Email is associated with another account'));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(Faliure("Email already in use"));
      } else if (e.code == 'weak-password') {
        return left(Faliure("Weak password"));
      } else {
        return left(Faliure(e.message!));
      }
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureEither<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    UserModel userModel;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      userModel = await getUserData(_firebaseAuth.currentUser!.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Faliure('User not found'));
      } else if (e.code == 'wrong-password') {
        return left(Faliure("Wrong Password"));
      } else {
        return left(Faliure(e.message!));
      }
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
