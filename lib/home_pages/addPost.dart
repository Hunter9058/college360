import 'package:college360/components/C_login_registration.dart';
import 'package:college360/constant.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Material(
                      color: KBackGroundColor,
                      elevation: 2,
                      borderRadius: KBorderRadius,
                      child: DropdownButtonFormField2<String>(
                          onChanged: (value) {},
                          validator: (val) {
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: KBorderRadius),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: KBorderRadius,
                              borderSide: BorderSide(color: KActionColor),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: KBorderRadius,
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Subject',
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
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          items: []),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: SignButton(
                        label: 'Post',
                        buttonColor: KActionColor,
                        textColor: Colors.black,
                        onPressed: () {}),
                  )
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keyword Preview',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  Divider(
                    endIndent: 220,
                    thickness: 1.2,
                    color: Colors.white,
                  )
                ],
              ),
              //chips
              Container(
                width: double.infinity,
                child: Wrap(
                    alignment: WrapAlignment.start,
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
              )
            ],
          ),
        ),
      ),
    );
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
      onDeleted: () {},
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
