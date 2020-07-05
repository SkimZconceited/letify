import 'package:flutter/material.dart';
import 'package:letify/screens/home/bottom_nav.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  //bottom navigation barindex
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Wallet'),
        ),
      ),
      bottomNavigationBar: LetifyBottomNavBar(
        newContext: context,
        currentIndex: _currentIndex,
      ),
    );
  }
}
