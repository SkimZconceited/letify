import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

Widget buildContinueButton(
    {GlobalKey<FormState> formKey,
    BuildContext context,
    Function clearText,
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController emailController}) {
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
          'Continue',
          style: TextStyle(color: letifyWhite),
        ),
        onPressed: () => _submit(context, formKey, clearText, nameController,
            phoneController, emailController),
      ),
    ),
  );
}

//submit
_submit(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Function clearText,
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController emailController) {
  if (formKey.currentState.validate()) {
    //navigate to continue route
    Navigator.pushNamed(context, 'continue', arguments: {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text
    });
  }
}
