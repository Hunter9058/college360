import 'package:college360/home_pages/testPage.dart';
import 'package:college360/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:provider/provider.dart';
import 'package:college360/home_pages/postFeed.dart';
import 'package:college360/home_pages/addPost.dart';

import '../home_pages/profile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  //widget list

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<List<PostModel>>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //check if keyboard is open
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final screens = [
      PostFeed(
          post: post, screenWidth: screenWidth, screenHeight: screenHeight),
      Test(),
      Text('screen 3'),
      ProfilePage(
        userUid: FirebaseAuth.instance.currentUser!.uid,
      ),
    ];
    return SafeArea(
      //to prevent going back to wrapper
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          floatingActionButton: keyboardIsOpened
              ? null
              : Container(
                  color: Colors.transparent,
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    elevation: 10,
                    splashColor: KActionColor,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, AddPost.id);
                    },
                    child: Icon(
                      CupertinoIcons.plus,
                      size: 40,
                      color: KBackGroundColor,
                    ),
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: KBackGroundColor,

          //switch between screens
          //todo change index-1 on back
          body: IndexedStack(index: _selectedIndex, children: screens),
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            child: BottomNavigationBar(
              backgroundColor: Color(0xff141515),
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              iconSize: 30,
              showSelectedLabels: false,
              unselectedItemColor: Colors.white,
              showUnselectedLabels: false,
              selectedItemColor: KActionColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house),
                    label: 'Home',
                    backgroundColor: KBackGroundColor),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Icon(
                        CupertinoIcons.chat_bubble_text,
                      ),
                    ),
                    label: 'Home',
                    backgroundColor: KBackGroundColor),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Icon(
                        CupertinoIcons.bell,
                      ),
                    ),
                    label: 'Notification',
                    backgroundColor: KBackGroundColor),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.profile_circled,
                    ),
                    label: 'Notification')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
