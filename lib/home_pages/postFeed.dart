import 'dart:io';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../components/C_keyword_container.dart';
import '../constant.dart';
import '../miniFunctions.dart';
import '../models/post.dart';
import '../screen/search_screen.dart';
import '../services/database.dart';
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
  double progress = 0;
  bool isAdv = false;
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
                width: 60,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: Size(50, 50),
                        primary: Colors.transparent,
                        shape: CircleBorder()),
                    onPressed: () async {
                      String downloadLink =
                          await DatabaseService().getApkDownloadLink();

                      //todo remove after testing
                      print(downloadLink);
                      openFile(
                              url: downloadLink,
                              fileName: 'college360.apk',
                              context: context)
                          .then((value) => print('opening file'));
                    },
                    //todo for testing remove later to another section
                    child: CircularPercentIndicator(
                      radius: 25.0,
                      lineWidth: 5.0,
                      percent: progress,
                      center: AnimatedSwitcher(
                        transitionBuilder:
                            (Widget child, Animation<double> animation) =>
                                ScaleTransition(
                          child: child,
                          scale: animation,
                        ),
                        duration: Duration(seconds: 1),
                        child: progress == 0
                            ? new Icon(
                                Icons.download_sharp,
                                color: Colors.white,
                                size: 18,
                              )
                            : progress == 100
                                ? Lottie.asset(
                                    'assets/Icons/cloud-download.json',
                                    fit: BoxFit.fill,
                                  )
                                : new Icon(
                                    Icons.check,
                                    color: KActionColor,
                                    size: 18,
                                  ),
                      ),
                      progressColor: KActionColor,
                      backgroundColor: KBackGroundColor,
                    )),
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(widget.screenHeight * 0.10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchScreen.id);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: KBorderRadius,
                        side: BorderSide(color: Colors.grey),
                      )),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: KActionColor,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Looking for some notes, a friend ...',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                                              widget.post[index].isAdv
                                                  ? Container(
                                                      width: 30,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .book_fill,
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
                              //4th section (like, dislike,comment)
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
                                    isAdv: widget.post[index].isAdv,
                                    posterName: widget.post[index].posterName,
                                    keywords: widget.post[index].keywords,
                                    likeList: widget.post[index].likes,
                                    content: widget.post[index].content,
                                    currentUser:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    postDocumentName: widget.post[index].docRef,
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
          }),
    );
  }

  Future openFile({required String url, String? fileName, context}) async {
    final file = await downloadFile(url, fileName!)
        .whenComplete(() => showSnackBar('download complete', context));
    if (file == null) return;
    //todo remove after testing
    print('path: ${file.path}');
    OpenFile.open(file.path);
  }

//todo move these function from main file
  //todo to be removed later
//download new apk update
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url, onReceiveProgress: (rcv, total) {
        //todo remove after testing

        setState(() {
          progress = ((rcv / total));
        });
      },
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
