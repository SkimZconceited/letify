import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

//build register button
Widget buildSignUpButton(
    {UserBloc userBloc, GlobalKey<FormState> formKey, Function signUp}) {
  return Container(
    height: 83,
    width: 280,
    padding: const EdgeInsets.only(top: 20, bottom: 6),
    child: Theme(
      data: ThemeData(buttonTheme: redButtonData),
      child: RaisedButton(
          disabledColor: Colors.grey[300],
          elevation: 6.0,
          child: Text(
            'Sign up',
            style: TextStyle(color: letifyWhite),
          ),
          onPressed: () => _submit(formKey, signUp, userBloc)),
    ),
  );
}

//submit
_submit(GlobalKey<FormState> formKey, Function signUp, UserBloc userBloc) {
  if (formKey.currentState.validate()) {
    //sign up user
    signUp(userBloc);
  }
}
