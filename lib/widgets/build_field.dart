import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

Widget buildfield(
    {BuildContext context,
    Function(String) validator,
    TextEditingController controller,
    bool obscure,
    String labelText,
    IconData icon,
    TextInputType textInputType}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    cursorColor: letifyGreen,
    obscureText: obscure == true ? true : false,
    keyboardType: textInputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: letifyGreen),
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
}
