import 'package:college360/models/user.dart';
import 'package:college360/screen/home_screen.dart';
import 'package:college360/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'Wrapper';

  @override
  Widget build(BuildContext context) {
    //todo add a stream depose after use to save memory
    final loggedUser = Provider.of<UserModel?>(context);
    if (loggedUser == null) {
      return SignIn();
    } else {
      return HomeScreen();
    }
  }
}
