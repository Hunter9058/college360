import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'constant.dart';

IconData likeButtonStatus(String currentUser, List likeList) {
  IconData iconColor = CupertinoIcons.heart;
  if (likeList.contains(currentUser)) {
    iconColor = CupertinoIcons.heart_fill;
  }
  return iconColor;
}

//pick picture
Future pickImage(context) async {
  try {
    XFile? profilePic =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File result =
        await FlutterNativeImage.compressImage(profilePic!.path, quality: 50);

    final File imageTemp = File(profilePic.path);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Image Picked',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: KSecondaryColor,
    ));
    return imageTemp;
  } on PlatformException catch (e) {
    //alert in case of failed task
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error $e'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}

void showSnackBar(String? text, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: KSecondaryColor,
      content: Text(
        text!,
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ),
  );
}
