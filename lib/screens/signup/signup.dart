import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/widgets/auth_api.dart';
import 'continue_button.dart';
import 'package:letify/widgets/auth_row.dart';
import 'package:letify/widgets/build_field.dart';
import 'package:letify/widgets/auth_container.dart';

class SignUp extends StatefulWidget {
  //toggle between sign up and sigjn in functions
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //textediting controllers
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _emailController;

  @override
  void initState() {
    // initialize textEditing controllers
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //accessing the bloc
    final bloc = UserProvider.of(context);
    return Scaffold(
      body: _buildBody(context, bloc),
    );
  }

  //builbody function
  Widget _buildBody(BuildContext context, UserBloc bloc) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //letify text
          AuthContainer(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 100, bottom: 50),
            text: "LETIFY",
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 30),
          ),
          //sign up text
          AuthContainer(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 10, left: 40),
            text: "Sign up",
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
          ),
          //sign up form
          Form(
            key: _formKey,
            child: Column(children: [
              //fullname field
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
                child: buildfield(
                    validator: _nameValidator,
                    context: context,
                    controller: _nameController,
                    obscure: false,
                    labelText: 'full name',
                    textInputType: null,
                    icon: Icons.perm_identity),
              ),
              //phone number field
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                child: buildfield(
                    validator: _phoneValidator,
                    context: context,
                    controller: _phoneController,
                    obscure: false,
                    labelText: 'phone number',
                    textInputType: TextInputType.number,
                    icon: Icons.phone),
              ),
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
                  icon: Icons.email,
                ),
              ),
              //continue button
              buildContinueButton(
                formKey: _formKey,
                context: context,
                clearText: _clearText,
                nameController: _nameController,
                phoneController: _phoneController,
                emailController: _emailController,
              ),
              //or text
              AuthContainer(
                alignment: null,
                padding: null,
                text: 'or',
              ),
              //sign up with and sign up api's
              buildAuthApi(context: context, text: 'Sign up with'),
              SizedBox(height: 10),
              //register row
              buildAuthRow(
                  context: context,
                  toggleView: widget.toggleView,
                  text1: 'Already a member?',
                  text2: 'sign in'),
            ]),
          ),
        ],
      ),
    );
  }

  //name validator
 String _nameValidator(String value) {
    if (value.length > 0) {
      return null;
    } else
      return 'name can not be empty';
  }

  //phone validator
  String _phoneValidator(String value) {
    if (value.startsWith('0') && value.length == 10) {
      return null;
    } else
      return 'enter a valid phone number';
  }

  //email validator
  String _emailValidator(String value) {
    if (value.contains('@')) {
      return null;
    } else
      return 'enter a valid email address';
  }

  //clear fields function
  void _clearText() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
  }
}
