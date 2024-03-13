import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseProvider {
  static final firebaseFirestoreProvider =
      Provider((ref) => FirebaseFirestore.instance);
  static final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
  static final storeProvider = Provider((ref) => FirebaseStorage.instance);
  static final googleSiginProvider = Provider((ref) => GoogleSignIn());
}
