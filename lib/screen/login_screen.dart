import 'package:college360/screen/forgotPassword_screen.dart';
import 'package:college360/screen/registration_screen.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:college360/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:college360/components/C_login_registration.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login_screen';

  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isPassVisible = true;
  bool isfinished = false;
  Color forgotColor = Color(0xffAFD4E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 130, left: 30, right: 30),
          child: Form(
            key: _formKey,
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
                              style:
                                  TextStyle(fontSize: 35, letterSpacing: 1.0),
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

                LoginInputField(
                  obscureText: false,
                  hintText: 'E-mail',
                  validator: (val) {
                    return isEmailValid(val);
                  },
                  onChanged: (val) {
                    email = val;
                    email = email.trim();
                  },
                ),
                SizedBox(height: 20.0),
                LoginInputField(
                  bottomSpace: 110,
                  obscureText: isPassVisible,
                  hintText: 'Password',
                  validator: null,
                  onChanged: (val) {
                    password = val;
                    password = password.trim();
                  },
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
                  ),
                ),

                SizedBox(height: 40.0),
                SignButton(
                  textColor: Colors.black,
                  buttonColor: KActionColor,
                  label: 'SIGN IN',
                  onPressed: () async {
                    //todo add check email verification states
                    try {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                  color: KActionColor,
                                  strokeWidth: 6,
                                )));
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          showAlertDialog(context);
                        } else {
                          Navigator.pushNamed(context, Wrapper.id);
                        }
                      }
                    } on Exception catch (e) {
                      print(e);
                      // TODO add error handling
                    }
                  },
                ),

                SizedBox(height: 20.0),

                //signup button
                SignButton(
                  label: 'SIGN UP',
                  buttonColor: Color(0xff1c1c1e),
                  textColor: Colors.white,
                  onPressed: () async {
                    setState(() {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    });
                  },
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      Navigator.pushNamed(context, ForgotPasswordScreen.id);
                    });
                  }, //redirect to retrieve screen
                  child: Text(
                    'Forgot password ?',
                    style: TextStyle(fontSize: 12, color: forgotColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
