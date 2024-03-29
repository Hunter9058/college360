import 'package:college360/wrapper.dart';
import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college360/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(College360());
}

class College360 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
