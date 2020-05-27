import 'package:flutter/material.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:letify/models/user.dart';
import 'package:letify/widgets/email_field.dart';
import 'package:letify/widgets/password_field.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/auth_api.dart';
import 'login_button.dart';
import 'package:letify/widgets/auth_row.dart';

class Login extends StatefulWidget {
  //switch up between login and register
  final Function toggleView;
  Login({Key key, this.toggleView}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //error
  String error = '';
  //progress indicator
  bool showIndicator = false;
  //textediting controllers
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    // initialize textEditing controllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      body: _buildBody(context, bloc),
    );
  }

  //builbody function
  Widget _buildBody(BuildContext context, UserBloc bloc) {
    return showIndicator
        ? buildIndicator()
        : SingleChildScrollView(
            child: Column(
            children: [
              //letify text
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 100, bottom: 10),
                child: Text(
                  'LETIFY',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  'Welcome Back',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              //log in text
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 40),
                child: Text(
                  'Log in',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  //email field
                  buildEmailField(
                    bloc: bloc,
                    controller: emailController,
                    context: context,
                  ),
                  //password field
                  buildPasswordField(
                    bloc: bloc,
                    controller: passwordController,
                    context: context,
                  ),
                  //log in button
                  buildLoginButton(
                    bloc: bloc,
                    context: context,
                    login: login,
                  ),
                  //error text
                  Container(
                      padding: EdgeInsets.all(1),
                      child: Text(
                        error,
                        style: TextStyle(color: letifyPink),
                      )),
                  //or text
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Text('or'),
                  ),
                  //log in with and log in api's
                  buildAuthApi(context: context, text: "Sign up with"),
                  SizedBox(height: 20),
                  //register row
                  buildAuthRow(
                    context: context,
                    toggleView: widget.toggleView,
                    text1: 'Not yet a member?',
                    text2: 'sign up',
                  ),
                ]),
              ),
            ],
          ));
  }

  //login function
  login(UserBloc bloc, BuildContext context) async {
    //show progress indicator
    setState(() => showIndicator = true);
    //login user
    User user = await bloc.signInWithEmailAndPassword();
    //clear fields
    emailController.clear();
    passwordController.clear();
    //if login fails
    if (user == null) {
      setState(() {
        //remove progress indicator
        showIndicator = false;
        //show error message
        error = 'signing in failed, try again';
      });
    }
  }
}
