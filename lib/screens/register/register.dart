import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/widgets/auth_api.dart';
import 'package:letify/widgets/name_field.dart';
import 'package:letify/widgets/email_field.dart';
import 'package:letify/widgets/phone_field.dart';
import 'continue_button.dart';
import 'package:letify/widgets/auth_row.dart';

class Register extends StatefulWidget {
  //switch up between login and register
  final Function toggleView;
  Register({Key key, this.toggleView}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //textediting controllers
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;

  @override
  void initState() {
    // initialize textEditing controllers
    emailController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // dispose textEditing controllers
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 100, bottom: 50),
            child: Text(
              'LETIFY',
              style:
                  Theme.of(context).textTheme.headline5.copyWith(fontSize: 30),
            ),
          ),
          //register in text
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 10, left: 40),
            child: Text(
              'Sign up',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
            ),
          ),
          //form
          Form(
            key: _formKey,
            child: Column(children: [
              //fullname field
              buildNameField(
                bloc: bloc,
                context: context,
                controller: nameController,
              ),
              //phone number field
              buildPhoneField(
                bloc: bloc,
                context: context,
                controller: phoneController,
              ),
              //email field
              buildEmailField(
                bloc: bloc,
                context: context,
                controller: emailController,
              ),
              //continue button
              buildContinueButton(
                bloc: bloc,
                context: context,
                clearText: clearText,
              ),
              //or text
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('or'),
              ),
              //sign up with and sign up api's
              buildAuthApi(context: context, text: 'Sign up with'),
              SizedBox(height: 20),
              //register row
              buildAuthRow(
                  context: context,
                  toggleView: widget.toggleView,
                  text1: 'Already a member?',
                  text2: 'log in'),
            ]),
          ),
        ],
      ),
    );
  }

  //clear fields function
  void clearText() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
  }
}
