import 'package:college360/constant.dart';
import 'package:college360/utilityFunctions.dart';
import 'package:college360/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:college360/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream
  Stream<UserModel?> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFireBaseUser(user!));
    //change fireauth user to our custom user
  }

// transform firebase user to our custom user model
  UserModel? _userFromFireBaseUser(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String firstName,
      String lastName,
      String id,
      String gender,
      context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a document with user UID
      await DatabaseService(uid: user!.uid)
          .updateUserData(firstName, lastName, email, id, gender);
      return _userFromFireBaseUser(user);
    } on FirebaseException catch (e) {
      print("Your error is => ${e.toString()}");
      showSnackBar(e.message, context);
    }
  }

  Future resetPassword(String email, context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: KActionColor,
              ),
            ));
    try {
      await Firebase.initializeApp();
      await _auth.sendPasswordResetEmail(email: email).then((value) => {
            showSnackBar('Password Reset Email Sent', context),
            Navigator.of(context).popUntil((route) => route.isFirst)
          });
    } on FirebaseException catch (e) {
      print("Your error is => ${e.toString()}");
      showSnackBar(e.message, context);
      Navigator.of(context).pop();
    }
  }
  //end of file
}
