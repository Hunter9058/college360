import 'package:flutter/material.dart';
import 'package:college360/constant.dart';

class KeywordCreator extends StatelessWidget {
  KeywordCreator({this.word = ''});
  final String word;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 5,
        borderRadius: KBorderRadius,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            // gradient: KCardTopColor,
            color: Colors.black12,
            borderRadius: KBorderRadius,
          ),
          child: Text(
            word,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
