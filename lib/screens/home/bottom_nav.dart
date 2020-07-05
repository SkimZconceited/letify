import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

class LetifyBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final BuildContext newContext;
  LetifyBottomNavBar({this.currentIndex,this.newContext});

  @override
  _LetifyBottomNavBarState createState() => _LetifyBottomNavBarState();
}

class _LetifyBottomNavBarState extends State<LetifyBottomNavBar> {
  List _routes = <String>[
    '/',
    '/reserve',
    '/wallet',
    '/inbox',
    '/account'
  ];
  
  //change index
  void _changeIndex(int index) {
    //setState(() => widget.currentIndex = index);
    //navigate to selected route
    Navigator.pushNamed(widget.newContext, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: letifyGreen,
      //unselectedItemColor: Colors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore,
          ),
          title: Text('Explore'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shop,
          ),
          title: Text('Reserve'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          title: Text('Wallet'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          title: Text('Inbox'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity),
          title: Text('Profile'),
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: _changeIndex,
    );
  }
}
