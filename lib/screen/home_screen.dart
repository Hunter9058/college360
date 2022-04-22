import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_home_page_card.dart';

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
                onPressed: null,
                icon: Icon(
                  Icons.menu_rounded,
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
            //Main  middle container
            Container(
                //card padding
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                height: MediaQuery.of(context).size.height - 280,
                child: Material(
                  elevation: 6,
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
                                      width: 15,
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
                                      width: 39,
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
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: KBorderRadius,
                                              border: Border.all(
                                                  color: KActionColor)),
                                          child: IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                CupertinoIcons.bookmark_fill,
                                                color: Colors.white,
                                                size: 25,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: KBorderRadius,
                                              border: Border.all(
                                                  color: KActionColor)),
                                          child: IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                CupertinoIcons.book_fill,
                                                color: KActionColor,
                                                size: 25,
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                        //2nd row (likes , level ,dr.name)
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '🤍 140K',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: (BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                      gradient: KCardTopColor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: KBorderRadius,
                                              border: Border.all(
                                                color: Colors.white30,
                                              )),
                                          child: Text(
                                            'DR.Abdelsalam',
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: KBorderRadius,
                                              border: Border.all(
                                                color: Colors.white30,
                                              )),
                                          child: Text(
                                            'Level 4',
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        // 3section (title text 'keywords')
                        Keyword(),
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
    );
  }
}

//card color 0xff2A3139
