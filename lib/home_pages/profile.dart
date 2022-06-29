import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../components/C_profilePageNavMenu.dart';
import '../utilityFunctions.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../services/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile';
  const ProfilePage({this.userUid = ''});
  final userUid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<UserModel?>(
          future: DatabaseService().getUserData(widget.userUid),
          builder: (context, snapshot) {
            //assign snapshot data to userModel object
            final UserModel? userData = snapshot.data;
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: KBackGroundColor,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  titleSpacing: 15,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  elevation: 0,
                  // appTitle(),

                  backgroundColor: Colors.transparent, //app bar color
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                double screenWidth =
                                    MediaQuery.of(context).size.width;
                                double screenHeight =
                                    MediaQuery.of(context).size.height;
                                return Container(
                                  height: screenHeight * 0.50,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: KBackGroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: BottomNavMenu(),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ],
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          //retrieve user full name
                          'people helped: 200',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: KActionColor),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [],
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
    final double profileHeight = MediaQuery.of(context).size.height / 4;
    final topMargin =
        MediaQuery.of(context).size.height / 4 - profileHeight / 2;
    return Container(
      margin: EdgeInsets.only(bottom: profileHeight / 2.1),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/profile-cover2.gif',
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: topMargin,
            child: CircleAvatar(
              backgroundColor: KBackGroundColor,
              radius: profileHeight / 2 + 6,
              child: CircleAvatar(
                radius: profileHeight / 2,
                //user profile pic

                backgroundImage:
                    CachedNetworkImageProvider(widget.userProfilePic),
              ),
            ),
          ),
          Positioned(
            top: topMargin * 2.5,
            right: MediaQuery.of(context).size.width / 4,
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
                    .update({'user_pic': userPic}).then((value) => setState(() {
                          print('page rebuilt');
                        }));
                //todo fix insta refresh
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
