import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
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
                onPressed: null,
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              height: 480,
              child: ListView(
                children: [
                  //replace with object made card from database
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Color(0xff252525),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color(0xffFAF6F6),
                        ),
                      ),
                      //main column
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(30.0),
                              //first row (profile pic , name ,post age,bookmark ,read button)
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('profile pic'),
                                  Column(
                                    children: [
                                      Text('user name'),
                                      Text('post age')
                                    ],
                                  ),
                                  Icon(
                                    CupertinoIcons.bookmark_fill,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Icon(
                                    CupertinoIcons.book_fill,
                                    color: KActionColor,
                                    size: 35,
                                  )
                                ],
                              )),
                          //2nd row (likes , level ,dr.name)
                          Row(
                            children: [Text('2nd row')],
                          ),
                          // 3section (title text 'keywords')
                          Container(
                            color: KMainCardBackGroundColor,
                            child: Text(
                              'key words',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          //4th section the keywords
                          Container(
                            height: 200,
                            child: ListView(
                              children: [
                                Container(
                                  height: 200,
                                  color: KMainCardBackGroundColor,
                                )
                              ],
                            ),
                          ),
                          //the 5th section (Like , comment ,dislike)
                          Expanded(
                            child: Material(
                              borderRadius: (BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                              color: KMainCardBackGroundColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          CupertinoIcons.hand_thumbsdown_fill,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                        (states) => Colors.black87,
                                      )),
                                      onPressed: null,
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.text_bubble_fill,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          Text(
                                            'NU Comments',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          CupertinoIcons.hand_thumbsup_fill,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Divider(
              color: Color(0xffF5F0F0),
              height: 1,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: KBackGroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 26,
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
                size: 50,
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
    );
  }
}
//card color 0xff2A3139
