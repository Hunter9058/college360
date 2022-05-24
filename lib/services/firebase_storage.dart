import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;

class FireStorage {
  //initialize storage
  final firebase_Storage.FirebaseStorage storage =
      firebase_Storage.FirebaseStorage.instance;
//provide user uid as filename
  Future uploadProfilePic(
      File profilePicFile, String fileName, String userUid) async {
    try {
      await storage
          .ref('users/$userUid/profile_pic/$fileName')
          .putFile(profilePicFile)
          .whenComplete(() => print('upload complete'));
      String downloadLink = await storage
          .ref('users/$userUid/profile_pic/$fileName')
          .getDownloadURL();
      return downloadLink;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
  //end of class
}
//upload profile pic to database