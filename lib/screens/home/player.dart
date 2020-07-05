import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/utils/theme.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final Apartment apartment;
  final House house;

  Player({@required this.apartment, @required this.house, key})
      : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _videoPlayerController;
  Future _initializeVideoFuture;
  @override
  void initState() {
    // initialize chewie controller
    _videoPlayerController = VideoPlayerController.network(
        widget.apartment == null
            ? widget.house.videos[0]
            : widget.apartment.videos[0]);
    _initializeVideoFuture = _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // dispose controllers
    _videoPlayerController.dispose();

    super.dispose();
  }

  //play pause
  void playPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else if (!_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 24),
        child: FutureBuilder(
          future: _initializeVideoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  VideoPlayer(_videoPlayerController),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 34,
                            color: letifyWhite,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 16.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              size: 34,
                              color: letifyWhite,
                            ),
                            onPressed: null,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, bottom: 16.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              size: 34,
                              color: letifyWhite,
                            ),
                            onPressed: null,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ],
              );
            } else
              return Center(
                child: LetifyCircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}
