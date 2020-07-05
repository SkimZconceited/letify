import 'package:flutter/material.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'signup_button.dart';
import 'package:letify/widgets/build_field.dart';
import 'package:letify/widgets/auth_container.dart';

class Continue extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  Continue({this.name, this.phone, this.email});
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
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    // initialize textEditing controllers
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = UserProvider.of(context);
    return Scaffold(
      body: _buildBody(userBloc),
    );
  }

  //builbody function
  Widget _buildBody(UserBloc userBloc) {
    return showIndicator
        ? LetifyCircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
            children: [
              //Almost done
              AuthContainer(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 140, bottom: 40),
                text: 'Almost done!!',
                style: Theme.of(context).textTheme.headline6,
              ),
              //continue form
              Form(
                key: _formKey,
                child: Column(children: [
                  //username field
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 40, left: 40),
                    child: buildfield(
                        validator: _usernameValidator,
                        context: context,
                        controller: _usernameController,
                        obscure: false,
                        labelText: 'username',
                        textInputType: null,
                        icon: Icons.perm_identity),
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
                  //confirm password field
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                    child: buildfield(
                        validator: _confirmPasswordValidator,
                        context: context,
                        controller: _confirmPasswordController,
                        obscure: true,
                        labelText: 'confirm password',
                        textInputType: null,
                        icon: Icons.enhanced_encryption),
                  ),
                  //Register button
                  buildSignUpButton(
                    formKey: _formKey,
                    userBloc: userBloc,
                    signUp: signUp,
                  ),
                  //error text
                  AuthContainer(
                    alignment: null,
                    padding: EdgeInsets.all(10),
                    text: error,
                    style: TextStyle(color: letifyPink),
                  ),
                ]),
              ),
            ],
          ));
  }

  //sign up function
  signUp(UserBloc userBloc) async {
    //show progress indicator
    setState(() => showIndicator = true);
    //create user
    User user = User(
      name: widget.name,
      phone: widget.phone,
      email: widget.email,
      username: _usernameController.text,
      password: _passwordController.text,
      account: {'customer': true, 'host': false},
    );
    print('${widget.email} and ${widget.name}');
    //sign up user
    final User authUser = await userBloc.registerWithEmailAndPassword(user);

    //if sign up fails
    if (authUser == null) {
      setState(() {
        //remove progress indicator
        showIndicator = false;
        //shoe error message
        error = 'Registration failed, try again';
      });
    } else
      Navigator.pop(context);
  }

  //username validator
  String _usernameValidator(String value) {
    if (value.length > 0) {
      return null;
    } else
      return "username can't be empty";
  }

  //password validator
  String _passwordValidator(String value) {
    if (value.length > 5) {
      return null;
    } else
      return "password must be atleast 6 characters long";
  }

  //confirm password validator
  String _confirmPasswordValidator(String value) {
    if (value == _passwordController.text) {
      return null;
    } else
      return "password does not match";
  }
}
