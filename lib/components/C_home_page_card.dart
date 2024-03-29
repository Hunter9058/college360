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
          border: Border.all(width: 0, color: KMainCardBackGroundColor),
          color: KMainCardBackGroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KEY WORDS',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
              Divider(
                color: Colors.black,
                indent: 10,
                endIndent: 250,
                thickness: 1.5,
                height: 20,
              ),
              SizedBox(
                height: 15,
              ),
              //keywords container
              //todo write a function that arrange text according to length to allow 3 words per line
              //todo change to stream  builder
              Center(
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
                    //todo remove after adding stream
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
