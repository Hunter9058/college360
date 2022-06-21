//used to  save the data coming from the stream

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  int commentNumber;
  Timestamp date;
  String posterName;
  String posterPicture;
  String posterUid;
  String subject;
  List likes;
  List keywords;
  List bookmark;
  List<String> content;
  var docRef;
  bool isAdv;

  PostModel(
      {required this.bookmark,
      this.commentNumber = 0,
      required this.date,
      required this.posterName,
      this.posterPicture = '',
      this.posterUid = '',
      this.subject = '',
      required this.likes,
      this.docRef,
      this.keywords = const [],
      required this.content,
      this.isAdv = false});
}
