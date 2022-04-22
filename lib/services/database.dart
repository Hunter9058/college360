import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //shortcut for referencing user collection
  final CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String email,
      String id, String gender) async {
    return await usersInfo.doc(uid).set(
      {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'student-Id': id,
        'gender': gender,
      },
    );
  }
}

// Future addUserInfo() async {
//   return users
//       .add({
//
//       })
//       .then((value) => print("user Added"))
//       .catchError((error) => print("Failed to add user: $error"));
// }
