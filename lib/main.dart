import 'package:college360/models/post.dart';
import 'package:college360/models/user.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:college360/services/database.dart';
import 'package:college360/wrapper.dart';
import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college360/constant.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(College360());
}

class College360 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //todo use multi provider instead
    return StreamProvider<CustomUser?>.value(
        catchError: (_, __) {
          return null;
        },
        initialData: null,
        value: AuthService().userStream,
        child: StreamProvider<List<PostModel>>.value(
          value: DatabaseService().posts,
          initialData: [],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.dark().copyWith(
                primaryColor: KMainCardBackGroundColor,
                textTheme: const TextTheme(
                    bodyText2: TextStyle(color: Colors.white),
                    bodyText1: TextStyle(color: Colors.white))),

            initialRoute: Wrapper.id,
            routes: {
              HomeScreen.id: (context) => HomeScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              Wrapper.id: (context) => Wrapper(),
              SignIn.id: (context) => SignIn(),
            },
            // initialRoute: '/',
            // routes: {'/': (context) => HomeScreen()},
          ),
        ));
  }
}
