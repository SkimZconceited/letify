import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/preview_player.dart';
import 'package:video_player/video_player.dart';

class BeachListView extends StatelessWidget {
  final List<DocumentSnapshot> homeSnapshots;

  BeachListView({@required this.homeSnapshots});

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

          //print(homeSnapshots[index].reference.path);
          return Container(
            child: Card(
              elevation: 6,
              margin: EdgeInsets.only(left: 9,right: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: 160,
                          height: 109,
                          //chewie video player
                          child: LetifyPreviewPlayer(
                            videoController:
                                VideoPlayerController.network(
                              apartment == null
                                  ? house.videos[0]
                                  : apartment.videos[0],
                            ),
                          )),
                      Positioned(
                        right: 0,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 7,
                              left: 8.7,
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: letifyWhite,
                                      shape: BoxShape.circle)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: letifyPink,
                              ),
                              onPressed: null,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 8,
                      right: 5,
                      bottom: 2,
                    ),
                    child: Row(
                      children: [
                        Text(
                          apartment == null ? 'House' : 'Apartment',
                          style: TextStyle(color: Colors.black45),
                        ),apartment == null ? SizedBox(width: 80) :
                        SizedBox(width: 59),
                        Icon(
                          Icons.star,
                          color: letifyPink,
                          size: 14,
                        ),
                        Text(
                          apartment == null
                              ? house.reviews['ratings'].toString()
                              : apartment.reviews['ratings'].toString(),
                          //style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2, left: 5),
                    child: Text(
                      apartment == null
                          ? house.location['street']
                          : apartment.location['street'],
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 0, left: 5),
                    child: Text(
                      apartment == null ? house.name : apartment.name,
                      // style: TextStyle(color: Colors.black87),
                    ),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(top: 3, bottom: 5),
          );
        });
  }
}
