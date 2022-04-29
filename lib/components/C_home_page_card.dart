import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college360/constant.dart';
import 'package:college360/components/C_keyword_creator.dart';

class Keyword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              //todo change to stream  builder
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    children: [
                      KeywordCreator(
                        word: 'Programming',
                      ),
                      KeywordCreator(
                        word: 'Math',
                      ),
                      KeywordCreator(
                        word: 'Algorithms',
                      ),
                      KeywordCreator(
                        word: 'Functions',
                      ),
                      KeywordCreator(
                        word: 'Arrays',
                      ),
                      KeywordCreator(
                        word: 'Data Types',
                      ),
                      KeywordCreator(
                        word: 'Object Oriented',
                      ),
                      KeywordCreator(
                        word: 'statistics',
                      ),
                      KeywordCreator(
                        word: 'Classes',
                      ),
                      KeywordCreator(
                        word: 'C++',
                      ),
                      KeywordCreator(
                        word: 'Python',
                      ),
                      //todo remove extra keywordCreators after adding stream
                    ],
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
                          onPressed: null,
                          icon: Icon(
                            CupertinoIcons.text_bubble,
                            color: KActionColor,
                            size: 25,
                          )),
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: KActionColor,
                            size: 25,
                          )),
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            CupertinoIcons.paperplane,
                            color: KActionColor,
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
