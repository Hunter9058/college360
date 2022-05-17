import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.uid = '',
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.gender = '',
      this.studentId = '',
      this.userPic = ''});

  String uid;
  String email;
  String firstName;
  String gender;
  String lastName;
  String studentId;
  String userPic;

  UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : firstName = snapshot.data()?['firstName'],
        email = snapshot.data()?['email'],
        gender = snapshot.data()?['gender'],
        lastName = snapshot.data()?['lastName'],
        studentId = snapshot.data()?['student-Id'],
        userPic = snapshot.data()?['user_pic'],
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
