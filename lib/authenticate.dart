import 'package:flutter/material.dart';
import 'package:letify/screens/signin/signin.dart';
import 'package:letify/screens/signup/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(
            toggleView: toggleView,
          )
        : SignUp(
            toggleView: toggleView,
          );
  }
}
