import 'package:flutter/cupertino.dart';

IconData likeButtonStatus(String currentUser, List likeList) {
  IconData iconColor = CupertinoIcons.heart;
  if (likeList.contains(currentUser)) {
    iconColor = CupertinoIcons.heart_fill;
  }
  return iconColor;
}
