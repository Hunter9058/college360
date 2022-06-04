import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../miniFunctions.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../services/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.screenWidth, required this.screenHeight});
  final double screenWidth;
  final double screenHeight;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<UserModel?>(
          future: DatabaseService()
              .getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            //assign snapshot data to userModel object
            final UserModel? userData = snapshot.data;
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: KBackGroundColor,
                body: Container(
                  height: widget.screenHeight,
                  width: widget.screenWidth,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TopCover(
                          widget: widget,
                          userProfilePic: userData!.userPic,
                        ),
                      ),
                      Text(
                        //retrieve user full name
                        '${userData.firstName} ${userData.lastName}',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Friends'))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class TopCover extends StatefulWidget {
  const TopCover({required this.widget, required this.userProfilePic});
  final String userProfilePic;
  final ProfilePage widget;

  @override
  State<TopCover> createState() => _TopCoverState();
}

class _TopCoverState extends State<TopCover> {
  @override
  Widget build(BuildContext context) {
    var profilePic;
    final double profileHeight = widget.widget.screenHeight / 4;
    final topMargin = widget.widget.screenHeight / 4 - profileHeight / 2;
    return Container(
      margin: EdgeInsets.only(bottom: profileHeight / 2),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/profile-cover2.gif',
            width: widget.widget.screenWidth,
          ),
          Positioned(
            top: topMargin,
            child: CircleAvatar(
              backgroundColor: KBackGroundColor,
              radius: profileHeight / 2 + 6,
              child: CircleAvatar(
                radius: profileHeight / 2,
                //user profile pic

                backgroundImage: NetworkImage(widget.userProfilePic),
              ),
            ),
          ),
          Positioned(
            top: topMargin * 2.5,
            right: widget.widget.screenWidth / 4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.withOpacity(0.3),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(5)),
              onPressed: () async {
                //pic new profile pic
                profilePic = await pickImage(context);
                String currentUser = FirebaseAuth.instance.currentUser!.uid;
                //upload profile pic to server & get image link

                String userPic = await FireStorage().uploadProfilePic(
                    profilePic!, basename(profilePic!.path), currentUser);

                //update image link
                //todo update image with out reload
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser)
                    .update({'user_pic': userPic}).then(
                        (value) => setState(() {}));
              },
              child: Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
