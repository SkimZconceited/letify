import 'package:flutter/material.dart';
import 'package:letify/screens/register/continue.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/wrapper.dart';

class LetifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        title: 'Letify',
        onGenerateRoute: _route,
      ),
    );
  }

  Route _route(RouteSettings settings) {
    switch (settings.name) {
      //login
      case "/":
        {
          return MaterialPageRoute(
              builder: (BuildContext context) => Wrapper() );
        }
        break;
        //continue
      case "continue":
        {
          return MaterialPageRoute(
              builder: (BuildContext context) => Continue() );
        }
        break;          
      default:
        {
          return null;
        }
        break;
    }
  }
}
