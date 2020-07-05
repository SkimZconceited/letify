import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

class LetifyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Text(
              'Letify Services',
              style: TextStyle(
                color: letifyWhite,
                fontSize: 20,
              ),
            ),
          ),
          decoration: BoxDecoration(color: letifyGreen),
        ),
        ListTile(
          leading: Container(
            child: Icon(
              const IconData(0xe900, fontFamily: 'Cleaning'),
              color: letifyGreen,
            ),
          ),
          title: Text('Home cleaning'),
        ),
        ListTile(
          leading: Container(
            child: Icon(
              const IconData(0xe900, fontFamily: 'Laundry'),
              color: letifyGreen,
            ),
          ),
          title: Text('Dry cleaning & laundry'),
        ),
        ListTile(
          leading: Container(
            child: Icon(
              Icons.local_shipping,
              color: letifyGreen,
            ),
          ),
          title: Text('Cargo transportation'),
        ),
        ListTile(
          leading: Container(
            child: Icon(
              Icons.fastfood,
              color: letifyGreen,
            ),
          ),
          title: Text('Fast food'),
        ),
      ],
    );
  }
}
