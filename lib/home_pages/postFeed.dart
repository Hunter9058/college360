import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../components/C_keyword_container.dart';
import '../constant.dart';
import '../models/post.dart';
import '../services/database.dart';
import '../services/firebase_storage.dart';
import '../wrapper.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      appBar: AppBar(
        titleSpacing: 15,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        elevation: 0,

        title: appTitle(),
        backgroundColor: KBackGroundColor, //app bar color
        actions: [
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
          ),
          Row(
            children: [
              Text(
                'Update App\n For Testing',
                textAlign: TextAlign.center,
              ),
              Container(
                width: 50,
                height: 44,
                child: IconButton(
                    onPressed: () async {
                      String downloadLink =
                          await DatabaseService().getApkDownloadLink();
                      //todo remove after testing
                      print(downloadLink);
                      FireStorage().openFile(
                          url: downloadLink,
                          fileName: 'college360.apk',
                          context: context);
                    },
                    //todo for testing remove later to another section
                    icon: Icon(
                      Icons.download_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ],
          )
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: null,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  labelText: 'Search',
                  floatingLabelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: KActionColor),
                  )),
            ),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.post.length,
          itemBuilder: (context, index) {
            return Container(
              width: widget.screenWidth,
              child: Column(
                children: [
                  //Main  middle container
                  Container(
                      //card padding
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
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
                                      left: 12, right: 10, top: 10, bottom: 5),
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

                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 31,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(widget
                                                .post[index].posterPicture),
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
                                              widget.post[index].posterName,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              timeago.format(widget
                                                  .post[index].date
                                                  .toDate()),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white38),
                                            )
                                          ],
                                        ),

                                        //Icon Row
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
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
                                                    widget.post[index].bookmark
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                        ? DatabaseService()
                                                            .removeBookmark(
                                                                widget
                                                                    .post[index]
                                                                    .docRef)
                                                        : DatabaseService()
                                                            .addBookmark(widget
                                                                .post[index]
                                                                .docRef);
                                                  },
                                                  icon: Icon(
                                                    widget.post[index].bookmark
                                                            .contains(
                                                                FirebaseAuth
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
                                      padding: const EdgeInsets.only(left: 10),
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
                                            value: widget
                                                .post[index].commentNumber,
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
                                                      borderRadius:
                                                          KBorderRadius,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      )),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      widget
                                                          .post[index].subject,
                                                      style: TextStyle(
                                                          color: Colors.yellow,
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
                                    keywords: widget.post[index].keywords,
                                    likeList: widget.post[index].likes,
                                    content: widget.post[index].content,
                                    currentUser:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    postDocumentName: widget.post[index].docRef,
                                  ),
                                ),
                              ),

                              //4th section (like, dislike,comment)
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
