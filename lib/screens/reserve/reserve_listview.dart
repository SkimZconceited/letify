import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/models/reserve.dart';
import 'package:letify/services/blocs/reserve_bloc.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/homeCard.dart';

class ReserveListView extends StatelessWidget {
  final List<DocumentSnapshot> reserveSnapshots;
  final ReserveBloc reserveBloc;

  ReserveListView(
      {@required this.reserveSnapshots, @required this.reserveBloc});
  @override
  Widget build(BuildContext context) {
    print(reserveSnapshots.length);
    return ListView.builder(
      itemCount: reserveSnapshots.length,
      itemBuilder: (BuildContext context, int index) {
        Apartment apartment;
        House house;
        Reserve reserve;
        bool flag = true;
        DocumentSnapshot reserveDocumentSnapshot;
        if (reserveSnapshots.isNotEmpty) {
          if (reserveSnapshots[index].data['category'] == 'apartment') {
            reserveDocumentSnapshot = reserveSnapshots[index];
            reserve = Reserve.fromMap(reserveSnapshots[index].data);
            reserve.id = reserveSnapshots[index].documentID;
            flag = true;
          } else if (reserveSnapshots[index].data['category'] == 'house') {
            reserveDocumentSnapshot = reserveSnapshots[index];
            reserve = Reserve.fromMap(reserveSnapshots[index].data);
            reserve.id = reserveSnapshots[index].documentID;
            flag = false;
          }
        } else {
          apartment = null;
          house = null;
        }
        print(flag);
        return FutureBuilder(
            future: flag
                ? reserveBloc.reservedApartments(homeId: reserve.homeId)
                : reserveBloc.reservedHouses(homeId: reserve.homeId),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final homeDocument = snapshot.data.data;
                if (flag) {
                  house = null;
                  apartment = Apartment.fromMap(homeDocument);
                  apartment.uid = snapshot.data.documentID;
                } else {
                  apartment = null;
                  house = House.fromMap(homeDocument);
                  house.uid = snapshot.data.documentID;
                }

                return Row(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(
                        left: 9,
                        top: 8,
                      ),
                      child: HomeCard(
                        apartment: apartment,
                        house: house,
                        doubleTap: false,
                        tap: true,
                      ),
                    ),
                    SizedBox(width: 25),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.payment,
                            color: letifyGreen,
                          ),
                          onPressed: null,
                        ),
                        Text('payment'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: letifyGreen,
                          ),
                          onPressed: null,
                        ),
                        Text('share'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: letifyGreen,
                            ),
                            onPressed: () =>
                                deleteReserve(reserveDocumentSnapshot)),
                        Text('delete')
                      ],
                    ),
                  ],
                );
              } else
                return Text(
                    flag ? 'loading apartment....' : 'loading house....');
            });
      },
    );
  }

  //delete reserve doc
  void deleteReserve(DocumentSnapshot reserveDocumentSnapshot) {
    reserveBloc.deleteReserve(reserveDocumentSnapshot);
  }
}
