import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/provider/firebase_provider.dart';
import 'package:news_app/core/utils/faliure.dart';
import 'package:news_app/core/utils/typedef.dart';

final storageRepositoryProvider = Provider((ref) => StorageRepository(
    firebaseStorage: ref.read(FirebaseProvider.storeProvider)));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeField({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file!);
      final snapshot = await uploadTask;
      return Right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }
}
