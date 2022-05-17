import 'package:college360/screen/comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_keyword_creator.dart';

import '../services/database.dart';

class KeywordContainer extends StatefulWidget {
  KeywordContainer({
    required this.likeList,
    required this.currentUser,
    required this.postDocumentName,
    required this.keywords,
  });

  final String postDocumentName;
  final List likeList;
  final String currentUser;
  final List keywords;

  @override
  State<KeywordContainer> createState() => _KeywordContainerState();
}

class _KeywordContainerState extends State<KeywordContainer> {
  @override
  Widget build(BuildContext context) {
    //todo improve sorting algorithm to arrange where N numbers of var length sum = x
    widget.keywords.sort((b, a) => a.length.compareTo(b.length));
    return Expanded(
      child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
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

              //keywords container
              //todo write a function that arrange text according to length to allow 3 words per line

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    children: List.generate(widget.keywords.length, (index) {
                      return KeywordCreator(
                        word: widget.keywords[index],
                      );
                    }),
                  ),
                ),
              ),

              Column(
                children: [
                  Divider(
                    height: 0,
                  ),
                  Row(
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

                            color: widget.likeList.contains(widget.currentUser)
                                ? Colors.red
                                : Colors.white,
                            size: 25,
                          )),
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            CupertinoIcons.paperplane,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
