import 'dart:io';

import 'package:college360/components/C_login_registration.dart';
import 'package:college360/constant.dart';
import 'package:college360/services/GlobalData.dart';
import 'package:college360/services/database.dart';
import 'package:college360/utilityFunctions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/C_NotesGridView.dart';

class AddPost extends StatefulWidget {
  static const String id = 'addPost';

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Color iconColor = Colors.white70;
  List<XFile> notesImages = [];
  List<String> notesUrl = [];
  String? selectedChapter;
  String? selectedSubject;
  List<String> keywords = [];
  final _formKey = GlobalKey<FormState>();
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
        backgroundColor: KBackGroundColor,
        title: Text(
          'Create Post',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(
              width: 70,
              height: 50,
              child: SignButton(
                  label: 'Post',
                  buttonColor: KActionColor,
                  textColor: Colors.black,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //upload post
                      DatabaseService().addPost(
                          notesUrl,
                          keywords,
                          MyService().getUserFullName(),
                          MyService().currentUser?.userPic,
                          selectedSubject);
                      Navigator.pop(context);
                    }
                  }),
            ),
          )
        ],
      ),
      //main container
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cDropDownMenuBuilder(
                        screenWidth,
                        'subjects',
                        DatabaseService().getSubjectNames('lvl4'),
                        selectedSubject,
                        false),
                    SizedBox(
                      width: 30,
                    ),
                    cDropDownMenuBuilder(
                        screenWidth,
                        'chapters',
                        DatabaseService().getChaptersNames(
                            'lvl4', selectedSubject ?? 'mangerial accounting'),
                        selectedChapter,
                        true),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: Container(
                    height: screenHeight * 0.36,
                    width: double.infinity,
                    child: notesImages.isEmpty
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
                                    notesImages = await pickFiles(context);
                                    upload(notesImages);

                                    setState(() {});

                                    print(notesImages);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.plus_circled,
                                    color: iconColor,
                                  ),
                                ),
                                Text(
                                  'Add Images',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        : NotesImageGridView(
                            imagePath: notesImages,
                            onImageClicked: (i) =>
                                print('Image $i was clicked!'),
                            onExpandClicked: () =>
                                print('Expand Image was clicked'),
                          ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Keyword Preview',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Divider(
                      endIndent: 80,
                      indent: 80,
                      thickness: 1.2,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: (BorderRadius.all(
                              Radius.circular(30),
                            )),
                            // gradient: KCardTopColor,
                            color: Color(0xff151414)),
                        height: screenHeight * 0.20,
                        width: screenWidth,
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 5,
                                spacing: 10,
                                children: keywords
                                    .map((keyword) => filterChip(keyword))
                                    .toList()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //chips
              ],
            ),
          ),
        ),
      ),
    );
  }

  Chip filterChip(label) {
    return Chip(
      onDeleted: () {
        setState(() {
          keywords.remove(label);
        });
        //remove chip
      },
      deleteIcon: Icon(
        CupertinoIcons.xmark_circle_fill,
      ),
      deleteIconColor: Colors.black87,
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style:
            TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Roboto'),
      ),
      backgroundColor: Colors.white70,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  FutureBuilder<List<String>> cDropDownMenuBuilder(double screenWidth,
      String label, var databaseStringList, selected, bool isCh) {
    return FutureBuilder<List<String>>(
        future: databaseStringList,
        builder: (context, snapshot) {
          List<String>? subject = snapshot.data;
          return SizedBox(
            height: 50,
            width: screenWidth * 0.40,
            child: Material(
              color: KBackGroundColor,
              borderRadius: KBorderRadius,
              child: DropdownButtonFormField2(
                value: selected,
                validator: (val) {
                  if (notesUrl.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                                title: const Text(
                                  "No images was picked",
                                  style: (TextStyle(color: Colors.red)),
                                ),
                                content: const Text(
                                    "You have raised a Alert Dialog Box"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('ok'),
                                    onPressed: () {
                                      int count = 0;
                                      Navigator.of(context)
                                          .popUntil((_) => count++ >= 2);
                                    },
                                  )
                                ]));
                    setState(() {
                      iconColor = Color(0xffff0033);
                    });

                    return '';
                  }
                  setState(() {
                    iconColor = Colors.white;
                  });
                  if (val == null) {
                    return 'please pick a value';
                  }
                  return null;
                },
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 120,
                dropdownWidth: screenWidth * 0.35,
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                isExpanded: true,
                offset: Offset(12, 0),
                hint: Text(
                  label,
                  style: TextStyle(fontSize: 16),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: iconColor,
                ),
                buttonDecoration: BoxDecoration(
                  borderRadius: KBorderRadius,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                decoration: KDropDownDecoration,
                onChanged: (value) async {
                  isCh
                      ? keywords = await DatabaseService()
                          .getChKeywords('lvl4', selectedSubject, value)
                      // ignore: unnecessary_statements
                      : null;
                  print('keywords: $keywords');
                  setState(() {
                    // ignore: unnecessary_statements
                    isCh ? selectedChapter : selectedSubject = value.toString();
                  });
                },
                items: subject!.map((subject) {
                  return DropdownMenuItem(value: subject, child: Text(subject));
                }).toList(),
              ),
            ),
          );
        });
  }

  Future upload(List<XFile> notes) async {
    notes.forEach((element) async {
      final path =
          'users/${FirebaseAuth.instance.currentUser?.uid}/posts/${element.name}';
      final file = File(element.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      notesUrl.add(urlDownload);
    });
  }
}
