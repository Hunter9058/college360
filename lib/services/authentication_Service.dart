import 'package:college360/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:college360/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream
  Stream<UserModel?> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFireBaseUser(user!));
    //change fireauth user to our custom user
  }

// transform firebase user to our custom user model
  UserModel? _userFromFireBaseUser(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, String id, String gender) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create a document with user UID
      await DatabaseService(uid: user!.uid)
          .updateUserData(firstName, lastName, email, id, gender);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
