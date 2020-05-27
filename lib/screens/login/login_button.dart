import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

//build log in button
Widget buildLoginButton({
  UserBloc bloc,
  BuildContext context,
  Function login,
}) {
  return Container(
    height: 83,
    width: 280,
    padding: const EdgeInsets.only(top: 20, bottom: 4),
    child: Theme(
      data: ThemeData(buttonTheme: redButtonData),
      child: StreamBuilder<bool>(
          stream: bloc.loginStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return RaisedButton(
                disabledColor: Colors.grey[300],
                elevation: 6,
                child: Text(
                  'Login',
                  style: TextStyle(color: letifyWhite),
                ),
                onPressed: snapshot.hasData
                    ? () {
                        login(bloc, context);
                      }
                    : null);
          }),
    ),
  );
}
