import 'package:college360/screen/home_screen.dart';
import 'package:college360/screen/registration_screen.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:college360/components/C_login_registration.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login_screen';
  final AuthService _auth = AuthService();

  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPassVisible = true;
  bool isfinished = false;
  Color forgotColor = Color(0xffAFD4E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: KBackGroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 130, left: 30, right: 30),
        child: Form(
          child: Column(
            children: <Widget>[
              //title (logo,text)
              Row(
                children: [
                  Image.asset(
                    'assets/images/Front logo.png',
                    height: 140,
                  ),
                  isfinished == false
                      ? AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            RotateAnimatedText(' Enjoy \n College',
                                textStyle: TextStyle(fontSize: 35)),
                            RotateAnimatedText(' Work \n Together',
                                textStyle: TextStyle(fontSize: 35)),
                            RotateAnimatedText(' Succeed \n Together ',
                                textStyle: TextStyle(fontSize: 35)),
                          ],
                          onFinished: () {
                            setState(() {
                              isfinished = true;
                            });
                          },
                        )
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 35, letterSpacing: 1.0),
                            children: [
                              TextSpan(
                                text: 'College',
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    color: Color(0xffD8D3D6),
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                  text: '360',
                                  style: TextStyle(color: KActionColor))
                            ],
                          ),
                        ),
                ],
              ),
              SizedBox(height: 50),
              InputField(
                hintText: 'E-mail',
              ),
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: KActionColor,
                decoration: (InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: KActionColor)),
                    hintText: ('Password'),
                    suffixIcon: IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        isPassVisible
                            ? isPassVisible = false
                            : isPassVisible = true;
                        setState(() {});
                      },
                      icon: isPassVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ))),
                onChanged: (val) {}, //password
                obscureText: isPassVisible,
              ),
              SizedBox(height: 40.0),
              SignButton(
                textColor: Colors.black,
                buttonColor: KActionColor,
                label: 'SIGN IN',
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, HomeScreen.id);
                  });
                },
              ),

              SizedBox(height: 20.0),
              //signup button

              SignButton(
                label: 'SIGN UP',
                buttonColor: Color(0xff1c1c1e),
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  });
                },
              ),

              TextButton(
                onPressed: () {}, //redirect to retrieve screen
                child: Text(
                  'Forgot username or password ?',
                  style: TextStyle(fontSize: 12, color: forgotColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
