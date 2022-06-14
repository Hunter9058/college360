import 'package:college360/models/user.dart';

class MyService {
  static final MyService _instance = MyService._internal();

  // passes the instantiation to the _instance object
  factory MyService() => _instance;

  //initialize variables in here
  MyService._internal();

  UserModel? currentUser;
}
