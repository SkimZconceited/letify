import 'package:flutter/material.dart';
import 'package:letify/authenticate.dart';
import 'package:letify/models/user.dart';
import 'package:letify/screens/home/home.dart';
import 'package:letify/services/blocs/user_provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userBloc = UserProvider.of(context);
    return StreamBuilder(
        stream: _userBloc.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return snapshot.data == null ? Authenticate() : Home();
        });
  }
}
