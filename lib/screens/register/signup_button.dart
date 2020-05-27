import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

//build register button
Widget buildSignUpButton({UserBloc bloc, Function signUp}) {
  return Container(
    height: 83,
    width: 280,
    padding: const EdgeInsets.only(top: 20, bottom: 6),
    child: Theme(
      data: ThemeData(buttonTheme: redButtonData),
      child: StreamBuilder<bool>(
          stream: bloc.registerStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return RaisedButton(
              disabledColor: Colors.grey[300],
              elevation: 6.0,
              child: Text(
                'Sign up',
                style: TextStyle(color: letifyWhite),
              ),
              onPressed: snapshot.hasData
                  ? () {
                      signUp(bloc);
                    }
                  : null,
            );
          }),
    ),
  );
}