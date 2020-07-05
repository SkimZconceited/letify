import 'package:flutter/material.dart';
import 'package:letify/screens/home/bottom_nav.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  //bottom navigation barindex
  int _currentIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text('Account'),
      )),
      bottomNavigationBar: LetifyBottomNavBar(
        newContext: context,
        currentIndex: _currentIndex,
      ),
    );
  }
}
