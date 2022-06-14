import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:college360/services/database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/C_Admin.dart';
import '../components/C_Appbar.dart';
import '../components/C_searchCard.dart';
import '../constant.dart';
import '../models/user.dart';
import '../services/firebase_storage.dart';

class AdminPage extends StatefulWidget {
  static const String id = 'AdminPage';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String progress = '';
  File? file;
  UploadTask? task;
  List<QueryDocumentSnapshot<UserModel>> searchResult = [];
  List<QueryDocumentSnapshot<UserModel>> result = [];
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
                          Text(
                            'Admin: ${userData.firstName}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    //todo edit later
                    Container()),
                body:
                    //main container
                    Container(
                  padding: EdgeInsets.all(20),
                  height: screenHeight,
                  width: screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                (BorderRadius.all(Radius.circular(30))),
                            color: Colors.black38,
                          ),
                          child: Row(
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
                                      elevation: 6,
                                      side: BorderSide(color: KActionColor),
                                      primary: Color(0xff1c1c1e),
                                      minimumSize: Size(screenWidth / 1.8, 45),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: KBorderRadius))),
                              ElevatedButton(
                                  onPressed: () {
                                    uploadApk(context);
                                    print(task);
                                    setState(() {});
                                  },
                                  child: Text(' Upload ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 6,
                                      side: BorderSide(color: KActionColor),
                                      primary: KActionColor,
                                      minimumSize: Size(screenWidth / 5, 45),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: KBorderRadius))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        task != null ? buildUploadStatus(task!) : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  (BorderRadius.all(Radius.circular(15))),
                              color: Colors.black38,
                            ),
                            child: TextField(
                              scrollPadding: EdgeInsets.all(10),
                              onChanged: (value) async {
                                if (value.isEmpty) {
                                  searchResult.clear();
                                }
                                //todo add search
                                if (value.isNotEmpty)
                                  result =
                                      await DatabaseService().userSearch(value);
                                setState(() {
                                  searchResult = result;
                                });
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  labelText: 'Upgrade user to admin',
                                  floatingLabelStyle:
                                      TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: KBorderRadius),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: KBorderRadius,
                                    borderSide: BorderSide(color: KActionColor),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius:
                                (BorderRadius.all(Radius.circular(30))),
                            color: Colors.black38,
                          ),
                          child: SingleChildScrollView(
                              child: SearchCard(
                            admin: true,
                            suggestions: searchResult,
                            listHeight: screenHeight * 0.30,
                          )),
                        )
                      ],
                    ),
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

  Future uploadApk(context) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'app_apk/$fileName';
    task = FireStorage.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    DatabaseService().uploadApkDownloadLink(urlDownload, context);
  }
}

// Text(
// '$percentage %',
// style: TextStyle(color: Colors.white, fontSize: 20),
// )
