import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  //initialize storage
  final firebase_Storage.FirebaseStorage storage =
      firebase_Storage.FirebaseStorage.instance;

//provide user uid as filename
  //upload profile pic to database
  Future uploadProfilePic(
      File profilePicFile, String fileName, String userUid) async {
    try {
      await storage
          .ref('users/$userUid/profile_pic/$fileName')
          .putFile(profilePicFile)
          .then((p0) => print('upload complete'));
      String downloadLink = await storage
          .ref('users/$userUid/profile_pic/$fileName')
          .getDownloadURL();
      return downloadLink;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

//upload any file function
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print('error message ${e.message}');
      return null;
      // TODO
    }
  }

//open new downloaded apk

//end of class
}
