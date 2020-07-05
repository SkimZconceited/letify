import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/screens/account/account.dart';
import 'package:letify/screens/details/details.dart';
import 'package:letify/screens/home/player.dart';
import 'package:letify/screens/inbox/inbox.dart';
import 'package:letify/screens/reserve/reserve.dart';
import 'package:letify/screens/signin/signin.dart';
import 'package:letify/screens/signup/continue.dart';
import 'package:letify/screens/signup/signup.dart';
import 'package:letify/screens/wallet/wallet.dart';
import 'package:letify/services/blocs/homes_provider.dart';
import 'package:letify/services/blocs/reserve_provider.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/wrapper.dart';

class LetifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: HomesProvider(
        child: ReserveProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: buildTheme(),
            title: 'Letify',
            onGenerateRoute: _route,
          ),
        ),
      ),
    );
  }

  Route _route(RouteSettings settings) {
    switch (settings.name) {
      //home
      case "/":
        {
          return MaterialPageRoute(
              builder: (BuildContext context) => Wrapper());
        }
        break;
      //reserve
      case "/reserve":
        {
          return MaterialPageRoute(
              builder: (BuildContext context) => Reserve());
        }
        break;
      //wallet
      case "/wallet":
        {
          return MaterialPageRoute(builder: (BuildContext context) => Wallet());
        }
        break;
      //inbox
      case "/inbox":
        {
          return MaterialPageRoute(builder: (BuildContext context) => Inbox());
        }
        break;
      //account
      case "/account":
        {
          return MaterialPageRoute(
              builder: (BuildContext context) => Account());
        }
        break;
      //signin
      case "signin":
        {
          return MaterialPageRoute(builder: (BuildContext context) => SignIn());
        }
        break;
      //signup
      case "signup":
        {
          return MaterialPageRoute(builder: (BuildContext context) => SignUp());
        }
        break;
      //continue
      case "continue":
        {
          Map<String, String> arguments = settings.arguments;
          return MaterialPageRoute(
              builder: (BuildContext context) => Continue(
                    name: arguments['name'],
                    phone: arguments['phone'],
                    email: arguments['email'],
                  ));
        }
        break;
      // player
      case 'player':
        {
          Apartment apartment;
          House house;
          if (settings.arguments is Apartment) {
            apartment = settings.arguments;
            house = null;
          }
          if (settings.arguments is House) {
            house = settings.arguments;
            apartment = null;
          }
          return MaterialPageRoute(builder: (BuildContext context) {
            return Player(apartment: apartment, house: house);
          });
        }
        break;
      //details screen
      case 'detailsScreen':
        {
          Apartment apartment;
          House house;
          if (settings.arguments is Apartment) {
            apartment = settings.arguments;
            house = null;
          }
          if (settings.arguments is House) {
            house = settings.arguments;
            apartment = null;
          }
          return MaterialPageRoute(builder: (BuildContext context) {
            return DetailsScreen(apartment: apartment, house: house);
          });
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
