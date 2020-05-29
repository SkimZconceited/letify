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
  Future<User> registerWithEmailAndPassword(User user) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      FirebaseUser firebaseUser = result.user;
      //return user model
      return User(
          uid: firebaseUser.uid,
          name: user.name,
          phone: user.phone,
          email: user.email,
          password: user.password,
          username: user.username);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in user with email and password
  Future<User> signInWithEmailAndPassword(User user) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      FirebaseUser firebaseUser = result.user;
      return User(uid: firebaseUser.uid);
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
