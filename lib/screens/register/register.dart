import 'package:flutter/material.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/widgets/auth_api.dart';
import 'continue_button.dart';
import 'package:letify/widgets/auth_row.dart';
import 'package:letify/widgets/build_field.dart';
import 'package:letify/widgets/auth_container.dart';

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
          AuthContainer(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 100, bottom: 50),
            text: "LETIFY",
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 30),
          ),
          //register in text
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
                    stream: bloc.name,
                    sink: bloc.nameSink,
                    context: context,
                    controller: nameController,
                    obscure: false,
                    labelText: 'full name',
                    textInputType: null,
                    icon: Icons.perm_identity),
              ),
              //phone number field
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                child: buildfield(
                    stream: bloc.phone,
                    sink: bloc.phoneSink,
                    context: context,
                    controller: phoneController,
                    obscure: false,
                    labelText: 'phone number',
                    textInputType: TextInputType.number,
                    icon: Icons.phone),
              ),
              //email field
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 40, left: 40),
                child: buildfield(
                    stream: bloc.email,
                    sink: bloc.emailSink,
                    context: context,
                    controller: emailController,
                    obscure: false,
                    labelText: 'email',
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.email),
              ),
              //continue button
              buildContinueButton(
                bloc: bloc,
                context: context,
                clearText: clearText,
              ),
              //or text
              AuthContainer(
                alignment: null,
                padding: EdgeInsets.all(10),
                text: 'or',
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
