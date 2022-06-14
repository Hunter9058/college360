import 'package:college360/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../miniFunctions.dart';

showAdminAlertDialog(BuildContext context, bool adminStatus, String userUid) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    title: Text("Conformation"),
    content: Text(adminStatus
        ? 'these user is already and Admin'
        : 'upgrade user to Admin'),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: KActionColor),
            primary: KActionColor,
            shape: RoundedRectangleBorder(borderRadius: KBorderRadius)),
        child: Text(
          adminStatus ? 'Remove Admin' : 'Add admin',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          DatabaseService()
              .changeAdminStatus(userUid, adminStatus ? false : true);
          showSnackBar(
              adminStatus
                  ? 'the user is no longer an admin'
                  : 'the user is now an admin',
              context);
          Navigator.of(context).pop();
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

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        // final double percentage = (progress * 100);
        print(progress);
        return LinearProgressIndicator(
          backgroundColor: Colors.black38,
          color: KActionColor,
          value: progress,
        );
      } else
        return Container(
          child: Text('no upload'),
        );
    });
