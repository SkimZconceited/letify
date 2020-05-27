import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

Widget buildPhoneField(
    {UserBloc bloc, BuildContext context, TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
    child: StreamBuilder<String>(
        stream: bloc.phone,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextFormField(
            controller: controller,
            onChanged: bloc.phoneSink,
            cursorColor: letifyGreen,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: snapshot.error,
                labelText: 'Phone number',
                labelStyle: TextStyle(color: letifyGreen),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: letifyGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  color: letifyGreen,
                )),
          );
        }),
  );
}
