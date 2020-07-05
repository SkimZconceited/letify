import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letify/screens/home/bottom_nav.dart';
import 'package:letify/screens/reserve/reserve_listview.dart';
import 'package:letify/services/blocs/reserve_provider.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/indicator.dart';

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  //bottom navigation barindex
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final reserveBloc = ReserveProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: letifyGreen,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.only(top: 60),
            title: Column(
              children: [
                Text(
                  'Reservations',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                  future: reserveBloc.retrieveReserves(),
                  builder: (context,
                      AsyncSnapshot<Stream<QuerySnapshot>> futureSnapshot) {
                    if (futureSnapshot.hasData) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: futureSnapshot.data,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<DocumentSnapshot> documentSnapshots =
                                  snapshot.data.documents;
                              return Text(
                                '0${documentSnapshots.length}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              );
                            } else
                              return Text(
                                'loading....',
                                style: TextStyle(color: Colors.black),
                              );
                          });
                    } else
                      return Container(
                          width: 20,
                          height: 20,
                          child: LetifyCircularProgressIndicator());
                  },
                )
              ],
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: FutureBuilder(
            future: reserveBloc.retrieveReserves(),
            builder: (BuildContext context,
                AsyncSnapshot<Stream<QuerySnapshot>> futureSnapshot) {
              if (futureSnapshot.hasData) {
                return StreamBuilder(
                    stream: futureSnapshot.data,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ReserveListView(
                          reserveSnapshots: snapshot.data.documents,
                          reserveBloc: reserveBloc,
                        );
                      } else
                        return Container(
                            width: 20,
                            height: 20,
                            child: LetifyCircularProgressIndicator());
                    });
              } else
                return Text('');
            }),
      ),
      bottomNavigationBar: LetifyBottomNavBar(
        newContext: context,
        currentIndex: _currentIndex,
      ),
    );
  }
}
