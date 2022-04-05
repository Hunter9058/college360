import 'package:flutter/material.dart';

//Colors
const KBackGroundColor = Color(0xff1c1c1e);
const KMainCardBackGroundColor = Color(0xffe7d241); //primary color
const KActionColor = Color(0xffeae648);
const KSecondaryColor = Color(0xff283238);

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
