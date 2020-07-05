import 'package:flutter/material.dart';
import 'package:letify/widgets/auth_container.dart';
import 'package:letify/widgets/build_field.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //textediting controllers
  TextEditingController _emailController;

  //instantiate controller in initstate
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  //dispose the controller
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //message
    final String message =
        "Enter your email address below and press send button to get a password reset email";
    //user userBloc
    final userBloc = UserProvider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //forgot password
            AuthContainer(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 140, bottom: 5),
              text: 'Forgot Password',
              style: Theme.of(context).textTheme.headline6,
            ),
            AuthContainer(
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.only(left: 40, top: 30, bottom: 10, right: 30),
              text: message,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            //form
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                child: buildfield(
                    validator: _emailValidator,
                    context: context,
                    controller: _emailController,
                    obscure: false,
                    labelText: 'email',
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.email),
              ),
            ),
            //send button
            buildSendButton(userBloc: userBloc, context: context),
          ],
        ),
      ),
    );
  }

  //build send button
  Widget buildSendButton({UserBloc userBloc, BuildContext context}) {
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
            'send',
            style: TextStyle(color: letifyWhite),
          ),
          onPressed: () => _submit(context, userBloc),
        ),
      ),
    );
  }

  //submit
  _submit(
    BuildContext context,
    UserBloc userBloc,
  ) async {
    if (_formKey.currentState.validate()) {
      final message =
          "Email has been successfully sent to ${_emailController.text}. Please check your inbox to reset your password.";
      final result = await userBloc.resetPassword(_emailController.text);
      Navigator.pop(context, result == 'success' ? message : result);

     // _emailController.clear();
    }
  }

  //email validator
  String _emailValidator(String value) {
    if (value.contains('@')) {
      return null;
    } else
      return 'enter a valid email address';
  }
}
