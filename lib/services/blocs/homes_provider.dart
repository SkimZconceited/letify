import 'package:flutter/material.dart';
import 'package:letify/services/blocs/homes_bloc.dart';

class HomesProvider extends InheritedWidget {
  final bloc = HomesBloc();
  HomesProvider({Key key, Widget child}) : super(key: key, child: child);
  bool updateShouldNotify(_) => true;

  static HomesBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<HomesProvider>()).bloc;
}
