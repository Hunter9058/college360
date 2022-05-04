//used to  save the data coming from the stream

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  Timestamp date;
  String posterName;
  String posterPicture;
  String posterUid;
  String subject;
  List likes;
  List keywords;
  var docRef;

  PostModel({
    required this.date,
    required this.posterName,
    this.posterPicture = '',
    this.posterUid = '',
    this.subject = '',
    required this.likes,
    this.docRef,
    required this.keywords,
  });
}
