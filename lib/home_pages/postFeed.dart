import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../components/C_PostFeedAppBar.dart';
import '../components/C_keyword_container.dart';
import '../constant.dart';
import '../models/post.dart';

import '../screen/search_screen.dart';
import '../services/database.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({
    Key? key,
    required this.post,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final List<PostModel> post;
  final double screenWidth;
  final double screenHeight;

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  double progress = 0;
  bool isAdv = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: KBackGroundColor,
        body: CustomScrollView(
          slivers: [
            PostFeedAppbar(screenWidth: screenWidth),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  width: widget.screenWidth,
                  child: Column(
                    children: [
                      //Main  middle container

                      Container(
                          //card padding
                          padding: EdgeInsets.symmetric(
                              vertical: 35, horizontal: 20),
                          height: widget.screenHeight * 0.75,
                          width: double.infinity,
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
                                          left: 12,
                                          right: 10,
                                          top: 10,
                                          bottom: 5),
                                      //first row (profile pic , name ,post age,bookmark ,read button)
                                      child: Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),

                                            SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: widget.post[index]
                                                      .posterPicture,
                                                  errorWidget:
                                                      (context, _, error) =>
                                                          Icon(
                                                    CupertinoIcons
                                                        .person_alt_circle,
                                                    color: Colors.white70,
                                                    size: 55,
                                                  ),
                                                  placeholder: (context, _) =>
                                                      Icon(
                                                    CupertinoIcons
                                                        .person_alt_circle,
                                                    color: Colors.white70,
                                                    size: 61,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Flexible(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget
                                                        .post[index].posterName,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    timeago.format(widget
                                                        .post[index].date
                                                        .toDate()),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white38),
                                                  )
                                                ],
                                              ),
                                            ),

                                            //Icon Row
                                            Flexible(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Row(
                                                  children: [
                                                    widget.post[index].isAdv
                                                        ? Container(
                                                            width: 30,
                                                          )
                                                        : IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .book_fill,
                                                              color: Colors
                                                                  .white70,
                                                              size: 30,
                                                            )),
                                                    IconButton(
                                                        onPressed: () {
                                                          widget.post[index]
                                                                  .bookmark
                                                                  .contains(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              ? DatabaseService()
                                                                  .removeBookmark(widget
                                                                      .post[
                                                                          index]
                                                                      .docRef)
                                                              : DatabaseService()
                                                                  .addBookmark(widget
                                                                      .post[
                                                                          index]
                                                                      .docRef);
                                                        },
                                                        icon: Icon(
                                                          widget.post[index]
                                                                  .bookmark
                                                                  .contains(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid)
                                                              ? CupertinoIcons
                                                                  .bookmark_fill
                                                              : CupertinoIcons
                                                                  .bookmark,
                                                          color: KActionColor,
                                                          size: 25,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  //2nd row (likes , level ,dr.name)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // post[index].docRef
                                            children: [
                                              AnimatedFlipCounter(
                                                value: widget
                                                    .post[index].likes.length
                                                    .toInt(),
                                                textStyle:
                                                    TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(CupertinoIcons.heart_solid),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              //comment counter
                                              AnimatedFlipCounter(
                                                value: widget
                                                    .post[index].commentNumber,
                                                textStyle:
                                                    TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(CupertinoIcons
                                                  .text_bubble_fill)
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 15),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              KBorderRadius,
                                                          border: Border.all(
                                                            color: Colors.white,
                                                          )),
                                                      child: FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: Text(
                                                          widget.post[index]
                                                              .subject,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.yellow,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    CupertinoIcons
                                                        .ellipsis_vertical,
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
                                  //4th section (like, dislike,comment)
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: (BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            topLeft: Radius.circular(30))),
                                        gradient: KCardGradiantColor,
                                      ),
                                      child: KeywordContainer(
                                        isAdv: widget.post[index].isAdv,
                                        posterName:
                                            widget.post[index].posterName,
                                        keywords: widget.post[index].keywords,
                                        likeList: widget.post[index].likes,
                                        content: widget.post[index].content,
                                        currentUser: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        postDocumentName:
                                            widget.post[index].docRef,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      //adds ads section every 3 post
                      // (index % 2) == 0 && index != 0
                      //     ? advCreator(context)
                      //     : Container(),
                    ],
                  ),
                );
              }, childCount: widget.post.length),
            ),
          ],
        ));
  }

//   void myScroll() async {
//     _scrollAppBarController.addListener(() {
//       if (_scrollAppBarController.position.userScrollDirection ==
//           ScrollDirection.reverse) {
//         if (!isScrollingDown) {
//           isScrollingDown = true;
//
//           setState(() {
//             _showAppbar = false;
//           });
//           print(_showAppbar);
//         }
//       }
//
//       if (_scrollAppBarController.position.userScrollDirection ==
//           ScrollDirection.forward) {
//         if (isScrollingDown) {
//           isScrollingDown = false;
//
//           setState(() {
//             _showAppbar = true;
//           });
//           print(_showAppbar);
//         }
//       }
//     });
//   }
}
