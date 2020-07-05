import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/widgets/homeCard.dart';

class TrendyListView extends StatelessWidget {
  final List<DocumentSnapshot> homeSnapshots;

  TrendyListView({@required this.homeSnapshots});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeSnapshots.length,
        itemBuilder: (context, index) {
          Apartment apartment;
          House house;

          if (homeSnapshots.isNotEmpty) {
            if (homeSnapshots[index].reference.path.startsWith('apartments')) {
              apartment = Apartment.fromMap(homeSnapshots[index].data);
              apartment.uid = homeSnapshots[index].documentID;
            } else if (homeSnapshots[index]
                .reference
                .path
                .startsWith('houses')) {
              house = House.fromMap(homeSnapshots[index].data);
              house.uid = homeSnapshots[index].documentID;
            }
          } else {
            apartment = null;
            house = null;
          }
          return HomeCard(
              apartment: apartment, house: house, doubleTap: true, tap: true);
        });
  }
}
