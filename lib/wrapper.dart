import 'package:flutter/material.dart';
import 'package:letify/authenticate.dart';
import 'package:letify/screens/home/home.dart';
import 'package:letify/services/blocs/user_provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return StreamBuilder(
        stream: bloc.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null ? Authenticate() : Home();
        });
  }
}
