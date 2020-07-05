import 'package:firebase_auth/firebase_auth.dart';
import 'package:letify/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //firebaseAuth instance
  FirebaseAuth _auth = FirebaseAuth.instance;
  //google sign in instance
  GoogleSignIn _googleSignIn = GoogleSignIn();
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

  //sign in with google account
  Future<User> signInWithGoogle() async {
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      final AuthResult _result = await _auth.signInWithCredential(credential);
      FirebaseUser _firebaseUser = _result.user;
      return User(
          uid: _firebaseUser.uid,
          name: _firebaseUser.displayName,
          email: _firebaseUser.email,
          phone: _firebaseUser.phoneNumber);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //password reset
  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
