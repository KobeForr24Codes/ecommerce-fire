import 'package:ecommerce_fire/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

    // create user object based on FirebaseUser
  User _userFromFirebaseUser(auth.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

      // auth change user stream
  Stream<User> get user {
    return _firebaseAuth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
}