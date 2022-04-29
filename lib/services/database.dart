import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:college360/models/post.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});
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

  //convert firestore data to custom object
  List<PostModel> _postListFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
          date: doc.get('date'),
          posterName: doc.get('poster_name'),
          posterPicture: doc.get('poster_picture'),
          posterUid: doc.get('poster_uid'),
          subject: doc.get('subject'));
    }).toList();
  }

//get posts from database
  Stream<List<PostModel>> get posts {
    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .map(_postListFromSnap);
  }
}
