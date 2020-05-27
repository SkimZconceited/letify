import 'package:letify/services/blocs/user_validators.dart';
import 'package:letify/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:letify/services/auth.dart';
import 'package:letify/models/user.dart';
import 'dart:async';

class UserBloc extends Object with Validator {
  //declare instances
  final AuthService _authService = AuthService();
  final Repository _repository = Repository();
  String error;
  //user field streams
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();
  final _loginStream = StreamController<bool>.broadcast();
  final _registerStream = StreamController<bool>.broadcast();
  final _continueStream = StreamController<bool>.broadcast();

  //user field streams and validators
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get phone => _phone.stream.transform(phoneValidator);
  Stream<String> get username => _username.stream.transform(usernameValidator);
  Stream<String> get confirmPassword =>
      _confirmPassword.transform(confirmPasswordValidator());
  Stream<bool> get loginStream => _loginStream.stream;
  Stream<bool> get registerStream => _registerStream.stream;
  Stream<bool> get continueStream => _continueStream.stream;

  //initialize streams
  UserBloc() {
    Rx.combineLatest2(email, password, (a, b) => true).pipe(_loginStream);
    Rx.combineLatest3(name, phone, email, (a, b, c) => true)
        .pipe(_continueStream);
    Rx.combineLatest3(username, password, confirmPassword, (a, b, c) => true)
        .pipe(_registerStream);
  }

  //listen to auth changes
  Stream<User> get user {
    return _authService.user;
  }

  //user field sinks
  Function(String) get nameSink => _name.sink.add;
  Function(String) get emailSink => _email.sink.add;
  Function(String) get passwordSink => _password.sink.add;
  Function(String) get phoneSink => _phone.sink.add;
  Function(String) get usernameSink => _username.sink.add;
  Function(String) get confirmPasswordSink => _confirmPassword.sink.add;

  //user registration
  Future<User> registerWithEmailAndPassword() async {
    final User user = await _authService.registerWithEmailAndPassword(
        name: _name.value,
        phone: _phone.value,
        email: _email.value,
        password: _password.value,
        username: _username.value);
    //store user to database
    if (user != null) {
      await _repository.createUser(user);
      print("${_username.value} and ${_password.value}");
      return user;
    }
    return null;
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

  //user log in
  Future<User> signInWithEmailAndPassword() async {
    return await _authService.signInWithEmailAndPassword(
        _email.value, _password.value);
    //set fields to empty strings
  }

  //user log out
  Future signOut() async {
    return await _authService.signOut();
  }

  //confirm password validator(should not be here!!!)
  StreamTransformer<String, String> confirmPasswordValidator() =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (confirmPassword, sink) {
        if (confirmPassword == _password.value)
          sink.add(confirmPassword);
        else
          sink.addError('password does not match');
      });
  //close stream
  dispose() {
    _name.close();
    _email.close();
    _password.close();
    _phone.close();
    _username.close();
    _confirmPassword.close();
    _loginStream.close();
    _registerStream.close();
    _continueStream.close();
  }
}
