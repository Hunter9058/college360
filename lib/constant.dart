import 'package:flutter/material.dart';

// 0xffF7DE3A
//Colors
const KBackGroundColor = Color(0xff1c1c1e);
const KMainCardBackGroundColor = Color(0xffF7DE3A); //primary color
const KActionColor = Color(0xffeae648);
const KSecondaryColor = Color(0xff283238);
const KCardTopColor = LinearGradient(
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
