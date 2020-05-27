import 'package:flutter/material.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Letify')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: bloc.getCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (!snapshot.hasData) {
                  return Text('still waiting....');
                }
                return Container(
                    padding: EdgeInsets.all(20),
                    child: Text(snapshot.data.name));
              }),
          Center(
            child: Theme(
              data: ThemeData(buttonTheme: redButtonData),
              child: RaisedButton(
                onPressed: () async {
                  await bloc.signOut();
                },
                child: Text('log out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
