import 'package:college360/screen/home_screen.dart';
import 'package:college360/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'Wrapper';

  @override
  Widget build(BuildContext context) {
    //todo add a stream depose after use to save memory
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SignIn();
          }
        });
  }
}
