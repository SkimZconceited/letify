import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/format.dart';
import 'package:letify/widgets/indicator.dart';

class Host extends StatelessWidget {
  final Apartment apartment;
  final House house;
  final UserBloc userBloc;
  Host({this.apartment, this.house, this.userBloc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 15, right: 10),
      child: FutureBuilder<User>(
          future: userBloc
              .getUser(apartment == null ? house.hostId : apartment.hostId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Text(
                          apartment == null ? 'House' : 'Apartment',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        'hosted by ${snapshot.data.name}',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      Text(
                        'Joined since ${convertYear(snapshot.data.date.toDate().month)}, ${snapshot.data.date.toDate().year} ',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      snapshot.data.dp,
                    ),
                  ),
                ],
              );
            } else
              return Container(
                  width: 5,
                  height: 5,
                  child: LetifyCircularProgressIndicator());
          }),
    );
  }
}
