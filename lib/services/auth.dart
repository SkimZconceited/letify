import 'package:firebase_auth/firebase_auth.dart';
import 'package:letify/models/user.dart';

class AuthService {
  //firebaseAuth instance
  FirebaseAuth _auth = FirebaseAuth.instance;

  //user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => user != null ? User(uid: user.uid) : null);
  }

  //get current user
  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
    
  }

  //register user with email and password
  Future<User> registerWithEmailAndPassword(
      {String email,
      String password,
      String name,
      String phone,
      String username}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //return user model
      return User(
          uid: user.uid,
          name: name,
          phone: phone,
          email: email,
          password: password,
          username: username);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in user with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return User(uid: user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out user
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
