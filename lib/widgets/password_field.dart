import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

Widget buildPasswordField(
    {UserBloc bloc, BuildContext context, TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
    child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextFormField(
            controller: controller,
            onChanged: bloc.passwordSink,
            cursorColor: letifyGreen,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              labelStyle: TextStyle(color: letifyGreen),
              errorText: snapshot.error,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: letifyGreen),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(
                Icons.enhanced_encryption,
                color: letifyGreen,
              ),
            ),
          );
        }),
  );
}
