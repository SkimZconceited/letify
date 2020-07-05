import 'package:flutter/material.dart';
import 'package:letify/services/blocs/house_bloc.dart';

class HouseProvider extends InheritedWidget {
  final bloc = HouseBloc();
  bool updateShouldNotify(_) => true;

  static HouseBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<HouseProvider>()).bloc;
}
