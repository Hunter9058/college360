import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../miniFunctions.dart';

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
  Future openFile({required String url, String? fileName, context}) async {
    final file = await downloadFile(url, fileName!)
        .whenComplete(() => showSnackBar('download complete', context));
    if (file == null) return;
    //todo remove after testing
    print('path: ${file.path}');
    OpenFile.open(file.path);
  }

  //todo to be removed later
//download new apk update
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

//end of class
}
