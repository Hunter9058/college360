import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college360/miniFunctions.dart';
import 'package:college360/models/post.dart';
import 'package:college360/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid = ''});

  //shortcut for referencing user collection
  final _currentUserUid = FirebaseAuth.instance.currentUser!.uid;
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
        'admin': false,
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
          content: List.from(doc['content']),
          isAdv: doc.get('isAdv'));
    }).toList();
  }

  Stream<List<PostModel>> get posts {
    //order post new to old
    return postInfo
        .orderBy('date', descending: true)
        .snapshots()
        .map(_postListFromSnap);
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

  Future<UserModel?> getUserData(String? userDocName) async {
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

  void addAdvertisement(String companyName, String companyProfilePic,
      String subject, List<String> advUrl) {
    postInfo.add({
      'bookmarks': [''],
      'comment_count': 0,
      'content': advUrl,
      'date': Timestamp.now(),
      'isAdv': true,
      'keywords': [''],
      'likes': [''],
      'poster_name': companyName,
      'poster_picture': companyProfilePic,
      'poster_uid': _currentUserUid,
      'subject': subject,
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

  void uploadApkDownloadLink(
      String downloadLink, dynamic context, String linkUploadLocation) {
    FirebaseFirestore.instance
        .collection(linkUploadLocation)
        .doc('D2smp4WuBfTnOPdgklz6')
        .set(
      {'download_link': downloadLink},
    ).then((value) => showSnackBar('upload complete', context));
  }

//todo optimize nullability
  Future<String> getApkDownloadLink() async {
    var result;
    try {
      await FirebaseFirestore.instance
          .collection('app_apk')
          .doc('D2smp4WuBfTnOPdgklz6')
          .get()
          .then((value) {
        result = value.data()!['download_link'];
      });
      return result;
    } on FirebaseException catch (e) {
      print('error message ${e.message}');
      return 'unavailable';
    }
  }

  Future<List<QueryDocumentSnapshot<UserModel>>> userSearch(
      String query) async {
    final documentList = (await FirebaseFirestore.instance
            .collection('users')
            .orderBy('firstName')
            .where('firstName', isGreaterThanOrEqualTo: query)
            .where('firstName', isLessThanOrEqualTo: query + '\uf8ff')
            //convert data from json to USER class
            .withConverter<UserModel>(
                fromFirestore: ((snapshot, _) =>
                    UserModel.fromFireStore(snapshot, _)),
                toFirestore: (UserModel userModel, _) =>
                    userModel.toFirestore())
            .get())
        .docs;

    return documentList;
  }

  void changeAdminStatus(String userUid, bool status) {
    usersInfo.doc(userUid).update({'admin': status});
  }

//end of file
}
