import 'package:flutter/material.dart';
import 'package:letify/services/blocs/reserve_bloc.dart';

class ReserveProvider extends InheritedWidget {
  final bloc = ReserveBloc();
  ReserveProvider({Key key, Widget child}) : super(key: key, child: child);
  bool updateShouldNotify(_) => true;

  static ReserveBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ReserveProvider>()).bloc;
}
