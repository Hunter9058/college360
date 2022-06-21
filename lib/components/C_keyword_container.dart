import 'dart:io';

import 'package:college360/screen/comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_keyword_creator.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../services/database.dart';
import 'C_ImageGridView.dart';

class KeywordContainer extends StatefulWidget {
  KeywordContainer(
      {required this.likeList,
      required this.currentUser,
      required this.postDocumentName,
      required this.keywords,
      required this.content,
      required this.posterName,
      required this.isAdv});

  final String postDocumentName;
  final List likeList;
  final String currentUser;
  final List keywords;
  final List<String> content;
  final String posterName;
  final bool isAdv;

  @override
  State<KeywordContainer> createState() => _KeywordContainerState();
}

class _KeywordContainerState extends State<KeywordContainer> {
  final List<String> shareImages = [];
  late int selectedPage;
  late final PageController _pageController;
  @override
  void initState() {
    selectedPage = widget.isAdv ? 1 : 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = 2;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //todo improve sorting algorithm to arrange where N numbers of var length sum = x
    widget.keywords.sort((b, a) => a.length.compareTo(b.length));
    return Container(
      decoration: BoxDecoration(
        borderRadius: (BorderRadius.only(
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30))),
        gradient: KCardTopColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
        ),
        //Main column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              //swipe to change photo / keyword
              child: Container(
                //todo edit for responsiveness
                width: screenWidth,
                height: screenHeight * 0.36,
                child: PageView(
                    physics:
                        widget.isAdv ? NeverScrollableScrollPhysics() : null,
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        selectedPage = page;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        //first slide
                        child: Column(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'KEY WORDS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  Divider(
                                    endIndent: 230,
                                    thickness: 1.5,
                                    color: Colors.yellowAccent,
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              flex: 12,
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  runSpacing: 10,
                                  children: List.generate(
                                      widget.keywords.length, (index) {
                                    return KeywordCreator(
                                      word: widget.keywords[index],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //second slide

                      PhotoGrid(
                        imageUrls: widget.content,
                        onExpandClicked: () =>
                            print('Expand Image was clicked'),
                      ),
                    ]),
              ),
            ),
            //scroll indicator

            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: widget.isAdv
                    ? Container()
                    : PageViewDotIndicator(
                        currentItem: selectedPage,
                        count: pageCount,
                        unselectedColor: Colors.white12,
                        selectedColor: Colors.white,
                        duration: Duration(milliseconds: 200),
                      ),
              ),
            ),
            //keywords container
            //todo write a function that arrange text according to length to allow 3 words per line

            //last row (comments likes and share button)
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Divider(
                    height: 0,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Comment(
                                      postDocumentName: widget.postDocumentName,
                                      currentUser: widget.currentUser,
                                      commentStream: DatabaseService()
                                          .comments(widget.postDocumentName),
                                    ),
                                  ),
                                );
                              });
                            },
                            icon: Icon(
                              CupertinoIcons.text_bubble,
                              color: Colors.white,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {
                              widget.likeList.contains(widget.currentUser)
                                  ? DatabaseService()
                                      .removeLike(widget.postDocumentName)
                                  : DatabaseService()
                                      .likeAction(widget.postDocumentName);
                            },
                            icon: Icon(
                              // CupertinoIcons.heart,
                              widget.likeList.contains(widget.currentUser)
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,

                              color:
                                  widget.likeList.contains(widget.currentUser)
                                      ? Colors.red
                                      : Colors.white,
                              size: 25,
                            )),
                        IconButton(
                            //todo allow file share
                            onPressed: () async {
                              widget.content
                                  .asMap()
                                  .forEach((index, element) async {
                                final url = Uri.parse(element);
                                final response = await http.get(url);
                                final bytes = response.bodyBytes;

                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/$index.jpg';
                                File(path).writeAsBytesSync(bytes);
                                setState(() {
                                  shareImages.add(path);
                                  //todo remove after testing
                                  print('file added');
                                  print(shareImages);
                                });
                                if (widget.content.length ==
                                    shareImages.length) {
                                  await Share.shareFiles(shareImages,
                                          text: widget.isAdv
                                              ? 'A friend would like to share ${widget.posterName} Advertisement with you'
                                              : null,
                                          subject:
                                              'A friend would like to share ${widget.posterName} notes with you from college 360')
                                      .then((value) => shareImages.clear());
                                  //add
                                }
                              });

                              // Share.share(linkSum, subject: 'link share test');
                            },
                            icon: Icon(
                              CupertinoIcons.paperplane,
                              color: Colors.white,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
