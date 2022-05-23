import 'package:college360/models/post.dart';
import 'package:college360/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_keyword_container.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:animated_flip_counter/animated_flip_counter.dart';
import '../wrapper.dart';

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
    final post = Provider.of<List<PostModel>>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, Wrapper.id);
                  // _authService.signOut();
                },
                //todo for testing remove later to another section
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                )),
          )
        ],
        //todo quick widget bar (to be removed later)
        bottom: PreferredSize(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                color: Colors.white,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          preferredSize: Size(500, 100),
        ),
      ),
      //todo add white feature bar
      body: ListView.builder(
          itemCount: post.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
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
                                child: Container(
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),

                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 31,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              post[index].posterPicture),
                                          radius: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            post[index].posterName,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            timeago.format(
                                                post[index].date.toDate()),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white38),
                                          )
                                        ],
                                      ),

                                      //Icon Row
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: null,
                                                icon: Icon(
                                                  CupertinoIcons.book_fill,
                                                  color: Colors.white70,
                                                  size: 30,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  post[index].bookmark.contains(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid)
                                                      ? DatabaseService()
                                                          .removeBookmark(
                                                              post[index]
                                                                  .docRef)
                                                      : DatabaseService()
                                                          .addBookmark(
                                                              post[index]
                                                                  .docRef);
                                                },
                                                icon: Icon(
                                                  post[index].bookmark.contains(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid)
                                                      ? CupertinoIcons
                                                          .bookmark_fill
                                                      : CupertinoIcons.bookmark,
                                                  color: KActionColor,
                                                  size: 25,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            //2nd row (likes , level ,dr.name)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // post[index].docRef
                                      children: [
                                        AnimatedFlipCounter(
                                          value:
                                              post[index].likes.length.toInt(),
                                          textStyle: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(CupertinoIcons.heart_solid),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        AnimatedFlipCounter(
                                          value: post[index].commentNumber,
                                          textStyle: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(CupertinoIcons.text_bubble_fill)
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: (BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: [
                                              Color(0xff212021),
                                              Color(0xff222122),
                                              Color(0xff232323),
                                              Color(0xff232323)
                                            ]),
                                      ),
                                      // gradient: KCardTopColor),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius: KBorderRadius,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    )),
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    post[index].subject,
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
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: (BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      topLeft: Radius.circular(30))),
                                  gradient: KCardTopColor,
                                ),
                                child: KeywordContainer(
                                  keywords: post[index].keywords,
                                  likeList: post[index].likes,
                                  currentUser:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  postDocumentName: post[index].docRef,
                                ),
                              ),
                            ),

                            //4th section (like, dislike,comment)
                          ],
                        ),
                      ),
                    )),
              ],
            );
          }),
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
