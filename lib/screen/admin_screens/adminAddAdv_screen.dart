import 'dart:io';
import 'package:path/path.dart';
import 'package:college360/constant.dart';
import 'package:college360/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../miniFunctions.dart';

class AdminAddAdv extends StatefulWidget {
  static const String id = 'AdminAddAdv';
  @override
  State<AdminAddAdv> createState() => _AdminAddAdvState();
}

class _AdminAddAdvState extends State<AdminAddAdv> {
  UploadTask? uploadTask;
  final _currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  List<XFile?> advBanner = [];
  File? profilePic;
  String companyName = '';
  String subject = '';
  String advLink = '';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
        backgroundColor: KBackGroundColor,
        title: Text('Add Advertisement'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.60,
                      child: TextField(
                        onChanged: (value) {
                          companyName = value;
                        },
                        controller: _controller,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => _controller.clear(),
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Company Name',
                            floatingLabelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: KBorderRadius),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: KBorderRadius,
                              borderSide: BorderSide(color: KActionColor),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          FloatingActionButton(
                              elevation: 0,
                              backgroundColor: Colors.grey,
                              onPressed: () async {
                                profilePic = await pickImage(context);
                                var result = await uploadAdvProfile();

                                setState(() {
                                  advLink = result;
                                });
                              },
                              child: profilePic != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage: FileImage(
                                        profilePic!,
                                      ),
                                    )
                                  : Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.black,
                                    )),
                          Text(
                            'Add\nCompany image',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  onChanged: (value) {
                    subject = value;
                  },
                  controller: _controller2,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => _controller2.clear(),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Subject',
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: KBorderRadius),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: KBorderRadius,
                        borderSide: BorderSide(color: KActionColor),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    'what is these advertisement about',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                    height: screenHeight * 0.36,
                    width: double.infinity,
                    child: advBanner.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: (BorderRadius.all(
                                  Radius.circular(30),
                                )),
                                // gradient: KCardTopColor,
                                color: Color(0xff151414)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 100,
                                  onPressed: () async {
                                    advBanner = await pickMultiNotes(context);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    CupertinoIcons.plus_circled,
                                  ),
                                ),
                                Text(
                                  'Add Images',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Image.file(
                                      File(advBanner[0]!.path),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  advBanner.clear();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      DatabaseService().addAdvertisement(
                          companyName, advLink, subject, ['sdsdsd']);
                    },
                    child: Text(
                      'Post Advertisement',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 6,
                        side: BorderSide(color: KActionColor),
                        primary: KActionColor,
                        minimumSize: Size(screenWidth, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: KBorderRadius)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadAdvProfile() async {
    final file = File(profilePic!.path);
    final path = 'advertisement/$_currentUserUid/${basename(file.path)}';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    return urlDownload;
  }
}
