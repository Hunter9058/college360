import 'package:college360/models/post.dart';
import 'package:college360/services/authentication_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_home_page_card.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      value: DatabaseService().posts,
      initialData: [],
      child: Scaffold(
        backgroundColor: KBackGroundColor,
        appBar: AppBar(
          titleSpacing: 20,
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          elevation: 0,
          title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 25, letterSpacing: 1.0),
              children: [
                TextSpan(
                  text: 'College',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Color(0xffD8D3D6),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                ),
                TextSpan(text: ' 360', style: TextStyle(color: KActionColor))
              ],
            ),
          ),
          backgroundColor: KBackGroundColor, //app bar color
          actions: [
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            // SizedBox(
            //   width: 3,
            // ),
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                  onPressed: () async {
                    await _authService.signOut();
                  },
                  //todo for testing remove later
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              //Main  middle container
              Container(
                  //card padding
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  height: MediaQuery.of(context).size.height - 280,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    //card container
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1c1c1e),
                        // gradient: KCardTopColor,

                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: KMainCardBackGroundColor,
                        ),
                      ),
                      //Main container
                      child: Column(
                        children: [
                          //first Row Padding
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 10, top: 10, bottom: 5),
                              //first row (profile pic , name ,post age,bookmark ,read button)
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      //todo update with user pic

                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 31,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/profilePic.jpg'),
                                          radius: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Salah Eldien',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            '19 Mar ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white38),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),

                                      //Icon Row
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: null,
                                              //todo fill icon if the user have it bookmarked
                                              icon: Icon(
                                                CupertinoIcons.bookmark,
                                                color: Colors.white,
                                                size: 25,
                                              )),
                                          IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                CupertinoIcons.book_fill,
                                                color: KActionColor,
                                                size: 30,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          //2nd row (likes , level ,dr.name)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '🤍 140K',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Flexible(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: (BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                      color: Color(0xff232323),
                                    ),
                                    // gradient: KCardTopColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius: KBorderRadius,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  )),
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text(
                                                  'Programming 1',
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            CupertinoIcons.ellipsis_vertical,
                                            color: KActionColor,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          // 3section (title text 'keywords')
                          Keyword(),
                          //4th section (like, dislike,comment)
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1))),
          child: BottomNavigationBar(
            backgroundColor: KBackGroundColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 30,
            showSelectedLabels: false,
            unselectedItemColor: Colors.white,
            showUnselectedLabels: false,
            selectedItemColor: KActionColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house),
                  label: 'Home',
                  backgroundColor: KBackGroundColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.text_bubble,
                  ),
                  label: 'Home',
                  backgroundColor: KBackGroundColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.plus_circle_fill,
                    size: 40,
                  ),
                  label: 'Home',
                  backgroundColor: KBackGroundColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.bell,
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
    );
  }
}

//card color 0xff2A3139
