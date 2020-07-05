import 'package:flutter/material.dart';
import 'package:letify/models/user.dart';
import 'package:letify/screens/signin/forgot_password.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/auth_api.dart';
import 'signin_button.dart';
import 'package:letify/widgets/auth_row.dart';
import 'package:letify/widgets/build_field.dart';
import 'package:letify/widgets/auth_container.dart';

class SignIn extends StatefulWidget {
  //toogle between sign in and sign up
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //error
  String error = '';
  //progress indicator
  bool showIndicator = false;
  //textediting controllers
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    // initialize textEditing controllers
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = UserProvider.of(context);
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return _buildBody(context, userBloc);
      },
    ));
  }

  //builbody function
  Widget _buildBody(BuildContext context, UserBloc userBloc) {
    return showIndicator
        ? LetifyCircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
            children: [
              //letify text
              AuthContainer(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 100, bottom: 10),
                text: "LETIFY",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: 30),
              ),
              //welcome back text
              AuthContainer(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 30, bottom: 20),
                text: "Welcome Back",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              //log in text
              AuthContainer(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 40),
                text: "Sign in",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              //log in form
              Form(
                key: _formKey,
                child: Column(children: [
                  //email field
                  Padding(
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
                  //password field
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                    child: buildfield(
                        validator: _passwordValidator,
                        context: context,
                        controller: _passwordController,
                        obscure: true,
                        labelText: 'password',
                        textInputType: null,
                        icon: Icons.enhanced_encryption),
                  ),
                  //forgot password
                  Container(
                    height: 20,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 5, right: 26),
                    child: FlatButton(
                      child: Text(
                        'forgot password?',
                        style: TextStyle(color: letifyGreen),
                      ),
                      onPressed: () => _navigateToForgotPassword(context),
                    ),
                  ),
                  //log in button
                  buildSignInButton(
                    formKey: _formKey,
                    userBloc: userBloc,
                    context: context,
                    signIn: signIn,
                  ),

                  //error text
                  Visibility(
                    visible: error != '' ? true : false,
                    child: AuthContainer(
                      alignment: null,
                      padding: null,
                      text: error,
                      style: TextStyle(color: letifyPink),
                    ),
                  ),
                  //or text
                  AuthContainer(
                    alignment: null,
                    padding: EdgeInsets.only(top: 2),
                    text: 'or',
                  ),
                  //log in with and log in api's
                  buildAuthApi(
                      context: context,
                      text: "Sign up with",
                      userBloc: userBloc),
                  SizedBox(height: 10),
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

  //sign in function
  signIn(UserBloc userBloc, BuildContext context) async {
    //show progress indicator
    setState(() => showIndicator = true);
    //create user
    User user =
        User(email: _emailController.text, password: _passwordController.text);
    //signin authUser with email and password
    User authUser = await userBloc.signInWithEmailAndPassword(user);
    //if signin fails
    if (authUser == null) {
      setState(() {
        //remove progress indicator
        showIndicator = false;
        //show error message
        error = 'signing in failed, try again';
      });
    }
  }

  //build forgot password page
  _navigateToForgotPassword(BuildContext context) async {
    final message = await Navigator.push(context,
        MaterialPageRoute<String>(builder: (context) => ForgotPassword()));
    //delete any current snackbar
    Scaffold.of(context).removeCurrentSnackBar();
    //show snackbar with a message
    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 20),
        backgroundColor:
            message.contains('successfully') ? letifyGreen : Colors.red,
      ));
    }
  }

  //email validator
  String _emailValidator(String value) {
    if (value.contains('@')) {
      return null;
    } else
      return 'enter a valid email address';
  }

  //password validator
  String _passwordValidator(String value) {
    if (value.length > 5) {
      return null;
    } else
      return "password must be atleast 6 characters long";
  }
}
