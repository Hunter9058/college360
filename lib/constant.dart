import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// 0xffF7DE3A
//Colors
const KBackGroundColor = Color(0xff1c1c1e);
const KMainCardBackGroundColor = Color(0xffF7DE3A); //primary color
const KActionColor = Color(0xffeae648);
const KSecondaryColor = Color(0xff283238);
const KCardGradiantColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xff252525),
      Color(0xff232323),
      Color(0xff212021),
      Color(0xff1e1e20),
      Color(0xff1c1c1e),
    ]);

//dark yellow 0xffFFBF28
//sizes
const BorderRadius KBorderRadius = BorderRadius.all(Radius.circular(15.0));

//to remove list overflow glow
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Widget appTitle() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 25, letterSpacing: 1.0),
      children: [
        TextSpan(
          text: 'College',
          style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              color: Color(0xffD8D3D6),
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        TextSpan(text: ' 360', style: TextStyle(color: KActionColor))
      ],
    ),
  );
}

//todo change color list
const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
//decorations
const InputDecoration KDropDownDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), borderRadius: KBorderRadius),
  focusedBorder: OutlineInputBorder(
    borderRadius: KBorderRadius,
    borderSide: BorderSide(color: KActionColor),
  ),
  isDense: true,
  contentPadding: EdgeInsets.zero,
  border: OutlineInputBorder(
    borderRadius: KBorderRadius,
  ),
);
