import'package:flutter/material.dart';
import 'package:letify/services/blocs/user_bloc.dart';
export 'user_bloc.dart';

class UserProvider extends InheritedWidget {
  final bloc = UserBloc();

  UserProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static UserBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<UserProvider>()).bloc;
}
