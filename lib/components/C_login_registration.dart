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
  const RegisterField({required this.label, this.validator});
  final String label;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KBackGroundColor,
      elevation: 2,
      borderRadius: KBorderRadius,
      child: TextFormField(
        onChanged: (val) {},
        cursorColor: Colors.white,
        decoration: InputDecoration(
            labelText: '$label',
            floatingLabelStyle: TextStyle(
              color: Colors.white,
            ),
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
