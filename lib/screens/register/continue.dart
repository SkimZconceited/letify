import 'package:flutter/material.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:letify/models/user.dart';
import 'package:letify/widgets/username_field.dart';
import 'package:letify/widgets/password_field.dart';
import 'package:letify/widgets/confirm_password_field.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'signup_button.dart';

class Continue extends StatefulWidget {
  @override
  _ContinueState createState() => _ContinueState();
}

class _ContinueState extends State<Continue> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //error
  String error = '';
  //progress indicator
  bool showIndicator = false;
  //textediting controllers
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  @override
  void initState() {
    // initialize textEditing controllers
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      body: _buildBody(bloc),
    );
  }

  //builbody function
  Widget _buildBody(UserBloc bloc) {
    return showIndicator
        ? buildIndicator()
        : SingleChildScrollView(
            child: Column(
            children: [
              //Almost done
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 140, bottom: 50),
                child: Text(
                  'Almost done!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              //continue form
              Form(
                key: _formKey,
                child: Column(children: [
                  //username field
                  buildUsernameField(
                    bloc: bloc,
                    context: context,
                    controller: usernameController,
                  ),
                  //password field
                  buildPasswordField(
                      bloc: bloc,
                      context: context,
                      controller: passwordController),
                  //confirm password field
                  buildConfirmPasswordField(
                    bloc: bloc,
                    context: context,
                    controller: confirmPasswordController,
                  ),
                  //Register button
                  buildSignUpButton(
                    bloc: bloc,
                    signUp: signUp,
                  ),
                  //error text
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        error,
                        style: TextStyle(color: letifyPink),
                      )),
                ]),
              ),
            ],
          ));
  }

  //sign up function
  signUp(UserBloc bloc) async {
    //clear fields
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    //show progress indicator
    setState(() => showIndicator = true);
    //sign up user
    final User user = await bloc.registerWithEmailAndPassword();
    Navigator.pop(context);
    //if sign up fails
    if (user == null) {
      setState(() {
        //remove progress indicator
        showIndicator = false;
        //shoe error message
        error = 'Registration failed, try again';
      });
    }
  }
}
