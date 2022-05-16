import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/models/post.dart';
import 'package:college360/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});
  //shortcut for referencing user collection
  final CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference postInfo =
      FirebaseFirestore.instance.collection('posts');

  Future updateUserData(String firstName, String lastName, String email,
      String id, String gender) async {
    return await usersInfo.doc(uid).set(
      {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'student-Id': id,
        'gender': gender,
      },
    );
  }

  //second convert firestore data to custom object
  List<PostModel> _postListFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        date: doc.get('date'),
        posterName: doc.get('poster_name'),
        posterPicture: doc.get('poster_picture'),
        posterUid: doc.get('poster_uid'),
        subject: doc.get('subject'),
        likes: List.from(doc['likes']),
        docRef: doc.id,
        keywords: List.from(doc['keywords']),
      );
    }).toList();
  }

  List<CommentModel> _commentListFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CommentModel(
        commenterUid: doc.get('commenter_uid'),
        comment: doc.get('comment'),
        commenterName: doc.get('commenter_name'),
        commenterPic: doc.get('commenter_pic'),
      );
    }).toList();
  }

//first get data from database
  Stream<List<PostModel>> get posts {
    return postInfo.snapshots().map(_postListFromSnap);
  }

  Stream<List<CommentModel>> comments(docName) {
    return postInfo
        .doc(docName)
        .collection('comments')
        .snapshots()
        .map(_commentListFromSnap);
  }

  //like a post
  void likeAction(String docName) {
    postInfo.doc(docName).update({
      'likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  //dislike a post
  void removeLike(String docName) {
    postInfo.doc(docName).update({
      'likes': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
    });
  }
}
