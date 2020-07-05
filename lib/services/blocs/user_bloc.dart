import 'package:letify/services/blocs/user_validators.dart';
import 'package:letify/services/repository.dart';
import 'package:letify/services/auth.dart';
import 'package:letify/models/user.dart';
import 'dart:async';

class UserBloc extends Object with Validator {
  //declare instances
  final AuthService _authService = AuthService();
  final Repository _repository = Repository();
  //check if signed with google
  bool _google = false;

  //listen to auth changes
  Stream<User> get user {
    return _authService.user;
  }

  //user registration with email and password
  Future<User> registerWithEmailAndPassword(User user) async {
    try {
      //register user
      User _authUser = await _authService.registerWithEmailAndPassword(user);
      //store user to database
      if (_authUser != null) {
        await _repository.createUser(_authUser);
        //print("${_authUser.password} and ${_authUser.password}");
      }
      return _authUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //user sign in with google account
  Future<User> signInWithGoogle() async {
    try {
      _google = true;
      User _authUser = await _authService.signInWithGoogle();
      //check if user is in database
      final Map<String, dynamic> userDocument =
          await _repository.getCurrentUser(_authUser.uid);
      //if not store user in database
      if (userDocument == null) {
        await _repository.createUser(_authUser);
      }
      return _authUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //get current user
  Future<User> getCurrentUser() async {
    try {
      dynamic firebaseUser = await _authService.getCurrentUser();
      if (firebaseUser != null) {
        Map<String, dynamic> userDocument =
            await _repository.getCurrentUser(firebaseUser.uid);
        return User.fromMap(userDocument);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  //get user
  Future<User> getUser(String uid) async {
    Map<String, dynamic> userDocument = await _repository.getUser(uid);
    return User.fromMap(userDocument);
  }

  //user sign in
  Future<User> signInWithEmailAndPassword(User user) async {
    //sign in user
    try {
      return await _authService.signInWithEmailAndPassword(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //user sign out
  Future signOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password
  Future<String> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
