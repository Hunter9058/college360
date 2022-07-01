import 'package:college360/components/C_login_registration.dart';
import 'package:college360/constant.dart';
import 'package:college360/services/database.dart';
import 'package:college360/utilityFunctions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<XFile?> notesImages = [];

  String? selectedChapter;
  String? selectedSubject;

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
                  onPressed: () {}),
            ),
          )
        ],
      ),
      //main container
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                      selectedSubject ?? 'mangerial accounting'),
                  SizedBox(
                    width: 30,
                  ),
                  cDropDownMenuBuilder(
                      screenWidth,
                      'Chapters',
                      DatabaseService().getChaptersNames(
                          'lvl4', selectedSubject ?? 'mangerial accounting'),
                      selectedChapter ?? 'ch1'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
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
                                  setState(() {});
                                  print(notesImages);
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
                      : NotesImageGridView(
                          imagePath: notesImages,
                          onImageClicked: (i) => print('Image $i was clicked!'),
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
                  Container(
                    width: double.infinity,
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 5,
                        spacing: 10,
                        children: [
                          TestChip(label: 'math '),
                          TestChip(label: 'OOP '),
                          TestChip(label: 'Function '),
                          TestChip(label: 'python '),
                          TestChip(label: 'algorithm '),
                          TestChip(label: 'C++ '),
                        ]),
                  ),
                ],
              ),
              //chips
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<String>> cDropDownMenuBuilder(double screenWidth,
      String label, var databaseStringList, String selected) {
    return FutureBuilder<List<String>>(
        future: databaseStringList,
        builder: (context, snapshot) {
          List<String>? subject = snapshot.data;
          return SizedBox(
            height: 50,
            width: screenWidth * 0.40,
            child: Material(
              color: KBackGroundColor,
              elevation: 2,
              borderRadius: KBorderRadius,
              child: DropdownButtonFormField2(
                isExpanded: true,
                hint: Text(
                  label,
                  style: TextStyle(fontSize: 16),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white70,
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
                value: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value.toString();
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
}

class TestChip extends StatelessWidget {
  TestChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(
      deleteIcon: Icon(
        CupertinoIcons.xmark_circle_fill,
      ),
      onDeleted: () {
        //remove chip
      },
      deleteIconColor: Colors.black87,
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style:
            TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Roboto'),
      ),
      backgroundColor: Colors.white70,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
}
