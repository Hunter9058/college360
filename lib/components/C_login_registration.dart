import 'package:college360/screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';

class LoginInputField extends StatelessWidget {
  const LoginInputField(
      {required this.hintText,
      required this.onChanged,
      this.suffixIcon,
      this.validator,
      this.obscureText = true});
  final dynamic obscureText;
  final String hintText;
  final dynamic onChanged;
  final dynamic suffixIcon;
  final dynamic validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (validator),
      cursorColor: KActionColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: ('$hintText'),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: KActionColor)),
      ),
      obscureText: obscureText,
    );
  }
}

class SignButton extends StatelessWidget {
  const SignButton(
      {required this.label,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed});
  final String label;
  final Color textColor;
  final Color buttonColor;
  final dynamic onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: KActionColor),
            primary: buttonColor,
            minimumSize: Size(240, 45),
            shape: RoundedRectangleBorder(borderRadius: KBorderRadius)),
        onPressed: onPressed,
        child: Text(
          '$label',
          style: TextStyle(color: textColor, fontSize: 18),
        ));
  }
}

class RegisterInputField extends StatelessWidget {
  RegisterInputField(
      {required this.label,
      required this.onChanged,
      required this.validator,
      this.autoValidateMode = AutovalidateMode.disabled});
  final String label;
  final dynamic onChanged;
  final dynamic validator;
  final AutovalidateMode autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KBackGroundColor,
      elevation: 0,
      borderRadius: KBorderRadius,
      child: TextFormField(
        autovalidateMode: autoValidateMode,
        validator: (validator),
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            labelText: '$label',
            floatingLabelStyle: TextStyle(color: Colors.white),
            errorBorder: OutlineInputBorder(
                borderRadius: KBorderRadius,
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KActionColor),
                borderRadius: KBorderRadius),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: KBorderRadius),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: KBorderRadius,
              borderSide: BorderSide(color: KActionColor),
            )),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    title: Text("Login error"),
    content: Text("This account doesn't exist would you like to create one."),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: KActionColor),
            primary: KActionColor,
            shape: RoundedRectangleBorder(borderRadius: KBorderRadius)),
        child: Text(
          "Register",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RegistrationScreen.id);
        },
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: KActionColor),
            primary: Color(0xff1c1c1e),
            shape: RoundedRectangleBorder(borderRadius: KBorderRadius)),
        child: Text("Return"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//password verification
String? isPasswordCompliant(String password, [int minLength = 6]) {
  if (password.isEmpty) {
    return 'please enter password';
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  if (hasDigits == false) {
    return 'Password must contain a number';
  }
  if (hasUppercase == false) {
    return 'Password must contain uppercase';
  }
  if (hasLowercase == false) {
    return 'Password must contain lowercase';
  }
  if (hasSpecialCharacters == false) {
    return 'Password must contain special characters';
  }
  if (hasMinLength == false) {
    return 'Password must be longer than 8 characters';
  } else {
    return null;
  }
}

String? isEmailValid(String val) {
  if (val.isEmpty) {
    return 'This field is required';
  }

  // using regular expression
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
    return "Please enter a valid email address";
  } else {
    return null;
  }
}
