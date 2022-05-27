import 'package:college360/components/C_login_registration.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgoPassword_screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KBackGroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: KBackGroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Forgot your password ? ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'PlayfairDisplay',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No worry enter you registered email \n we will send you the password reset instruction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white30, fontSize: 12, height: 1.5),
                ),
                SizedBox(height: 60),
                Image.asset(
                  'assets/images/ForgotPassword.png',
                  scale: 2,
                ),
                SizedBox(height: 50),

                RegisterInputField(
                  label: 'E-mail',
                  onChanged: (val) {
                    email = val;
                    email = email.trim();
                  },
                  validator: (val) {
                    return isEmailValid(val);
                  },
                  bottomSpace: 100,
                ),
                SizedBox(height: 20.0),
                //todo add email validation conform before resiting
                SignButton(
                  label: 'Reset Password',
                  buttonColor: KActionColor,
                  textColor: Colors.black87,
                  onPressed: () async {
                    AuthService().resetPassword(email, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
