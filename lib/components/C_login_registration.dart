import 'package:flutter/material.dart';
import 'package:college360/constant.dart';

class InputField extends StatelessWidget {
  const InputField({required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: KActionColor,
      decoration: InputDecoration(
        hintText: ('$hintText'),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: KActionColor)),
      ),
      onChanged: (val) {},
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

class RegisterField extends StatelessWidget {
  RegisterField(
      {required this.label,
      required this.onChanged,
      required this.validator,
      this.autoValidateMode = AutovalidateMode.disabled});
  final String label;
  final dynamic onChanged;
  final dynamic validator;
  AutovalidateMode autoValidateMode;

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
            floatingLabelStyle: TextStyle(
              color: Colors.white,
            ),
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
