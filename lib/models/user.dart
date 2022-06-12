import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.uid = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.studentId = '',
    this.userPic =
        'https://firebasestorage.googleapis.com/v0/b/college360-e87b7.appspot.com/o/default_profile_pic%2FdefultAvater.jpg?alt=media&token=2f9febb9-c8f9-4fb9-8ae7-3c7dad89801b',
    this.admin = false,
  });

  String uid;
  String email;
  String firstName;
  String gender;
  String lastName;
  String studentId;
  String userPic;
  bool admin;
  UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : firstName = snapshot.data()?['firstName'],
        email = snapshot.data()?['email'],
        gender = snapshot.data()?['gender'],
        lastName = snapshot.data()?['lastName'],
        studentId = snapshot.data()?['student-Id'],
        userPic = snapshot.data()?['user_pic'],
        admin = snapshot.data()?['admin'],
        uid = snapshot.id;

  Map<String, dynamic> toFirestore() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "student-Id": studentId,
      "gender": gender,
      "user_pic": userPic,
    };
  }
}
