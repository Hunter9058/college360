import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:college360/services/database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/C_Appbar.dart';
import '../constant.dart';
import '../models/user.dart';
import '../services/firebase_storage.dart';

class AdminPage extends StatefulWidget {
  static const String id = 'AdminPage';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  File? file;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: FutureBuilder<UserModel?>(
          future: DatabaseService()
              .getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            final UserModel? userData = snapshot.data;
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: KBackGroundColor,
                appBar: customAppbar(
                    context,
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              userData!.userPic,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(userData.firstName)
                        ],
                      ),
                    ),
                    null),
                body: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                selectFile();
                              },
                              child: Text(
                                file != null
                                    ? 'File Selected'
                                    : '📎 Select APK',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: KActionColor),
                                  primary: Color(0xff1c1c1e),
                                  minimumSize: Size(screenWidth / 1.8, 45),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: KBorderRadius))),
                          ElevatedButton(
                              onPressed: () {
                                uploadApk();
                              },
                              child: Text(' Upload ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: KActionColor),
                                  primary: KActionColor,
                                  minimumSize: Size(screenWidth / 5, 45),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: KBorderRadius)))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else
              return CircularProgressIndicator();
          }),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['apk']);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future uploadApk() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'app_apk/$fileName';
    task = FireStorage.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    DatabaseService().uploadApkDownloadLink(urlDownload);
    //todo upload apk download url to database
  }
}

buildUploadStatus(UploadTask task) {
  StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final String percentage = (progress * 100).toStringAsFixed(2);
          print(percentage);
          return Text(
            '$percentage %',
            style: TextStyle(color: Colors.white, fontSize: 20),
          );
        } else
          return Container(
            child: Text('no upload'),
          );
      });
}
