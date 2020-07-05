import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

class Media extends StatelessWidget {
  final Apartment apartment;
  final House house;
  Media({this.apartment, this.house});
  @override
  Widget build(BuildContext context) {
    //list of vids and pics
    List medias;
    medias = apartment == null
        ? house.videos + house.images
        : apartment.videos + apartment.images;
    return apartment != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //vids and pics headline
                Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 5.0),
                  child: Text(
                    'Videos and Photos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: medias.length,
                      itemBuilder: (context, index) {
                        if (index < apartment.videos.length)
                          return Container(
                            margin: EdgeInsets.only(left: 18, right: 8),
                            width: 180,
                            child: LetifyVideoPlayer(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                        apartment.videos[0])),
                          );
                        else
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            width: 180,
                            child: Image.network(
                              apartment.images[0],
                              fit: BoxFit.fill,
                            ),
                          );
                      }),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //vids and pics headline
                Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 5.0),
                  child: Text(
                    'Videos and Photos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: medias.length,
                    itemBuilder: (context, index) {
                      if (index < house.videos.length)
                        return Container(
                          margin: EdgeInsets.only(left: 18, right: 8),
                          width: 180,
                          child: LetifyVideoPlayer(
                              videoPlayerController:
                                  VideoPlayerController.network(
                                      house.videos[0])),
                        );
                      else
                        return Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 180,
                          child: Image.network(
                            house.images[0],
                            fit: BoxFit.fill,
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
