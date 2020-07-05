import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

//build log in button
Widget buildSignInButton({
  GlobalKey<FormState> formKey,
  UserBloc userBloc,
  BuildContext context,
  Function signIn,
}) {
  return Container(
    height: 83,
    width: 280,
    padding: const EdgeInsets.only(top: 20, bottom: 4),
    child: Theme(
      data: ThemeData(buttonTheme: redButtonData),
      child: RaisedButton(
        disabledColor: Colors.grey[300],
        elevation: 6,
        child: Text(
          'Sign in',
          style: TextStyle(color: letifyWhite),
        ),
        onPressed: () => _submit(formKey, context, signIn, userBloc),
      ),
    ),
  );
}

//submit
_submit(GlobalKey<FormState> formKey, BuildContext context, Function signIn,
    UserBloc userBloc) {
  if (formKey.currentState.validate()) {
    //sign in user
    signIn(userBloc, context);
  }
}
