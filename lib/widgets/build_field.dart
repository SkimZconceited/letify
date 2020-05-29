import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

Widget buildfield(
    {BuildContext context,
    Stream<String> stream,
    Function sink,
    TextEditingController controller,
    bool obscure,
    String labelText,
    IconData icon,
    TextInputType textInputType}) {
  return StreamBuilder<String>(
    stream: stream,
    builder: (context, AsyncSnapshot<String> snapshot) {
      return TextFormField(
        controller: controller,
        onChanged: sink,
        cursorColor: letifyGreen,
        obscureText: obscure == true ? true : false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
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
            icon,
            color: letifyGreen,
          ),
        ),
      );
    },
  );
}
