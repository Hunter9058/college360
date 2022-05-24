import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/models/post.dart';
import 'package:college360/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid = ''});

  //shortcut for referencing user collection
  final CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference postInfo =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference bookmarksInfo =
      FirebaseFirestore.instance.collection('bookmarks');
  Future updateUserData(
    String firstName,
    String lastName,
    String email,
    String id,
    String gender,
  ) async {
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

  void updateProfilePicLink(String uid, picLink) {
    usersInfo.doc(uid).update({'user_pic': picLink});
  }

  //second convert firestore data to custom object
  List<PostModel> _postListFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
          bookmark: doc.get('bookmarks'),
          commentNumber: doc.get('comment_count'),
          date: doc.get('date'),
          posterName: doc.get('poster_name'),
          posterPicture: doc.get('poster_picture'),
          posterUid: doc.get('poster_uid'),
          subject: doc.get('subject'),
          likes: List.from(doc['likes']),
          docRef: doc.id,
          keywords: List.from(doc['keywords']),
          content: List.from(doc['content']));
    }).toList();
  }

  Stream<List<PostModel>> get posts {
    return postInfo.snapshots().map(_postListFromSnap);
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

  Stream<List<CommentModel>> comments(docName) {
    return postInfo
        .doc(docName)
        .collection('comments')
        .snapshots()
        .map(_commentListFromSnap);
  }

  Future<UserModel?> getUserData(userDocName) async {
    final ref = usersInfo.doc(userDocName).withConverter<UserModel>(
        fromFirestore: ((snapshot, _) => UserModel.fromFireStore(snapshot, _)),
        toFirestore: (UserModel userModel, _) => userModel.toFirestore());
    UserModel? fetchedResult = (await ref.get()).data();

    return fetchedResult;
  }

  void incrementComments(postDocumentName) {
    final DocumentReference docRef = postInfo.doc(postDocumentName);
    docRef.update({"comment_count": FieldValue.increment(1)});
  }

  void addComment(
      postDocumentName, comment, commenterName, commenterPic, commenterUid) {
    postInfo.doc(postDocumentName).collection('comments').add({
      'comment': comment,
      'commenter_name': commenterName,
      'commenter_pic': commenterPic,
      'commenter_uid': commenterUid
    });
  }

//first get data from database

  //get current user data

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

  //add post to bookmarks
  void addBookmark(String docName) {
    postInfo.doc(docName).update({
      'bookmarks':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  //remove post from bookmarks
  void removeBookmark(String docName) {
    postInfo.doc(docName).update({
      'bookmarks':
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  //end of file
}
