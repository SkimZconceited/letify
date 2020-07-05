import 'package:flutter/material.dart';
import 'package:letify/screens/home/bottom_nav.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  //bottom navigation barindex
  int _currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text('Inbox'),
      )),
      bottomNavigationBar: LetifyBottomNavBar(
        newContext: context,
        currentIndex: _currentIndex,
      ),
    );
  }
}
