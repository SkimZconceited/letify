import 'package:flutter/material.dart';
import 'package:letify/services/blocs/apartment_bloc.dart';
export 'apartment_bloc.dart';

class ApartmentProvider extends InheritedWidget {
  final bloc = ApartmentBloc();
  ApartmentProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static ApartmentBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ApartmentProvider>()).bloc;
}
