import 'package:college360/home_pages/addPost.dart';
import 'package:college360/home_pages/profile.dart';
import 'package:college360/models/post.dart';
import 'package:college360/models/user.dart';
import 'package:college360/screen/about_screen.dart';
import 'package:college360/screen/admin_screens/adminAddAdv_screen.dart';
import 'package:college360/screen/admin_screens/admin_screen.dart';
import 'package:college360/screen/forgotPassword_screen.dart';

import 'package:college360/screen/search_screen.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:college360/services/database.dart';
import 'package:college360/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:college360/constant.dart';
import 'package:provider/provider.dart';
import 'package:college360/screen/comment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //prevent screen rotation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(College360());
}

class College360 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: AuthService().userStream,
          initialData: null,
          catchError: (_, err) => null,
        ),
        StreamProvider<List<PostModel>>.value(
            value: DatabaseService().posts, initialData: []),
        // StreamProvider.value(
        //     value: DatabaseService().comments,
        //     initialData: const <CommentModel>[])
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        //default design data
        theme: ThemeData.dark().copyWith(
            primaryColor: KMainCardBackGroundColor,
            textTheme: const TextTheme(
                bodyText2:
                    TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                bodyText1:
                    TextStyle(color: Colors.white, fontFamily: 'OpenSans'))),

        initialRoute: Wrapper.id,
        routes: {
          AddPost.id: (context) => AddPost(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          Wrapper.id: (context) => Wrapper(),
          SignIn.id: (context) => SignIn(),
          Comment.id: (context) => Comment(),
          AdminPage.id: (context) => AdminPage(),
          SearchScreen.id: (context) => SearchScreen(),
          ProfilePage.id: (context) => ProfilePage(),
          AdminAddAdv.id: (context) => AdminAddAdv(),
          AboutScreen.id: (context) => AboutScreen(),
        },
        // initialRoute: '/',
        // routes: {'/': (context) => HomeScreen()},
      ),
    );
  }
}
