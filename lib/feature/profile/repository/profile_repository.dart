import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/constants/collection_constant.dart';
import 'package:news_app/core/provider/firebase_provider.dart';
import 'package:news_app/core/utils/faliure.dart';
import 'package:news_app/core/utils/typedef.dart';
import 'package:news_app/model/user_model.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(
    firebaseFirestore: ref.read(FirebaseProvider.firebaseFirestoreProvider),
  ),
);

class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  Futurevoid updateProfile(UserModel userModel) async {
    try {
      return right(_user.doc(userModel.uid).update(userModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Faliure(
          e.toString(),
        ),
      );
    }
  }

  CollectionReference get _user =>
      _firebaseFirestore.collection(CollectionConstant.userCollection);
}
