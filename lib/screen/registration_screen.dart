import 'dart:io';
import 'package:college360/services/database.dart';
import 'package:path/path.dart';
import 'package:college360/screen/home_screen.dart';
import 'package:college360/services/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_login_registration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:college360/services/authentication_Service.dart';

import '../miniFunctions.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String error = '';
  String firstName = '';
  String lastName = '';
  String eMail = '';
  String password = '';
  String studentId = '';
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  late String selectedGender;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  File? profilePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        backgroundColor: KBackGroundColor,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 1))),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 1.0,
              ),
              children: [
                TextSpan(
                  text: 'Sign',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Color(0xffD8D3D6),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                ),
                TextSpan(text: ' UP', style: TextStyle(color: KActionColor))
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          SignButton(
                              //todo add profile pic feature (optional)
                              label: ' Add Profile Picture',
                              buttonColor: Colors.white10,
                              textColor: Colors.white,
                              onPressed: () async {
                                profilePic = await pickImage(context);
                                setState(() {});
                              }),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            //show profile picture picture if picked or default icon
                            child: profilePic != null
                                ? ClipOval(
                                    child: Image.file(
                                      profilePic!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    CupertinoIcons.person_alt_circle,
                                    color: Colors.white70,
                                    size: 70,
                                  ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RegisterInputField(
                              validator: (val) => val.isEmpty
                                  ? 'please enter First name'
                                  : null,
                              label: 'First Name',
                              onChanged: (val) {
                                firstName = val;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: RegisterInputField(
                              validator: (val) =>
                                  val.isEmpty ? 'please enter last name' : null,
                              label: 'Last Name',
                              onChanged: (val) {
                                lastName = val;
                                //todo take last name
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RegisterInputField(
                        validator: (val) {
                          return isEmailValid(val);
                        },
                        label: 'E-Mail',
                        onChanged: (val) {
                          eMail = val;
                          eMail = eMail.trim();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RegisterInputField(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return isPasswordCompliant(val);
                        },
                        label: 'Password',
                        onChanged: (val) {
                          password = val;
                          password = password.trim();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RegisterInputField(
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val.length != 8) {
                                  return 'ID to short';
                                }
                              },
                              label: 'Student-ID',
                              onChanged: (val) {
                                studentId = val;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          //gender Drop down button
                          Expanded(
                            child: Material(
                              color: KBackGroundColor,
                              elevation: 2,
                              borderRadius: KBorderRadius,
                              child: DropdownButtonFormField2(
                                onChanged: (value) {
                                  selectedGender = value.toString();
                                },
                                validator: (val) => val.toString().isEmpty
                                    ? 'Please pick a gender'
                                    : null,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
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

                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Gender',
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
                                items: genderItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SignButton(
                        label: 'SIGN UP',
                        buttonColor: KActionColor,
                        textColor: Colors.black,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //todo send verification email then move user to login screen
                            //todo show alert if email already in use
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    eMail,
                                    password,
                                    firstName,
                                    lastName,
                                    studentId,
                                    selectedGender,
                                    context);
                            String currentUser =
                                FirebaseAuth.instance.currentUser!.uid;
                            //upload profile pic to server
                            String userPic = await FireStorage()
                                .uploadProfilePic(
                                    profilePic!,
                                    basename(profilePic!.path),
                                    FirebaseAuth.instance.currentUser!.uid);
                            DatabaseService()
                                .updateProfilePicLink(currentUser, userPic);

                            Navigator.pushNamed(context, HomeScreen.id);
                            //todo add account already exist warning
                            if (result == null) {
                              AlertDialog(
                                title: Text('Warning'),
                                content: Text('Please verify your information'),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
