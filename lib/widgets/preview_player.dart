import 'package:flutter/material.dart';
import 'package:letify/widgets/indicator.dart';
import 'package:video_player/video_player.dart';

class LetifyPreviewPlayer extends StatefulWidget {
  final VideoPlayerController videoController;
  LetifyPreviewPlayer({
    Key key,
    @required this.videoController,
  }) : super(key: key);
  @override
  _LetifyPreviewPlayerState createState() => _LetifyPreviewPlayerState();
}

class _LetifyPreviewPlayerState extends State<LetifyPreviewPlayer> {
  Future<void> _initializeVideoFuture;

  @override
  void initState() {
    //initialize controller

    _initializeVideoFuture = widget.videoController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    // dispose controller
    widget.videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            child: GestureDetector(
                onDoubleTap: () => widget.videoController.play(),
                child: VideoPlayer(widget.videoController)),
            aspectRatio: widget.videoController.value.aspectRatio,
          );
        } else
          return Center(
            child: LetifyCircularProgressIndicator(),
          );
      },
    );
  }
}
