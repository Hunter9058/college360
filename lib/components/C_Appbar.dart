import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../wrapper.dart';

AppBar customAppbar(context, customTitle, firstActionButton) {
  return AppBar(
    titleSpacing: 15,
    automaticallyImplyLeading: false,
    toolbarHeight: 70,
    elevation: 0,
    // appTitle(),
    title: customTitle,
    backgroundColor: KBackGroundColor, //app bar color
    actions: [
      firstActionButton,
      // SizedBox(
      //   width: 3,
      // ),
      Container(
        width: 50,
        height: 50,
        child: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, Wrapper.id);
              // _authService.signOut();
            },
            //todo for testing remove later to another section
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            )),
      )
    ],
    //todo quick widget bar (to be removed later)
  );
}
