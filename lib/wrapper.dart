import 'package:college360/screen/admin_screen.dart';
import 'package:college360/screen/home_screen.dart';
import 'package:college360/screen/login_screen.dart';
import 'package:college360/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'Wrapper';

  @override
  Widget build(BuildContext context) {
    //todo add a stream depose after use to save memory
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<UserModel?>(
                initialData: null,
                future: DatabaseService()
                    .getUserData(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot2) {
                  final UserModel? userData = snapshot2.data;

                  if (snapshot2.hasData) {
                    if (userData!.admin == true) {
                      return AdminPage();
                    } else {
                      return HomeScreen();
                    }
                  } else
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
                });
          } else {
            return SignIn();
          }
        });
  }
}
