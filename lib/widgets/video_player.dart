import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:letify/widgets/custom_material_controls.dart';
import 'package:video_player/video_player.dart';

class LetifyVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  LetifyVideoPlayer({@required this.videoPlayerController, key})
      : super(key: key);
  @override
  _LetifyVideoPlayerState createState() => _LetifyVideoPlayerState();
}

class _LetifyVideoPlayerState extends State<LetifyVideoPlayer> {
  ChewieController _chewieController;
  @override
  void initState() {
    // initialize chewie controller
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoInitialize: true,
        aspectRatio: widget.videoPlayerController.value.aspectRatio,
        looping: false,
        showControls: true,
        showControlsOnInitialize: false,
        customControls: CustomMaterialControls(),
        allowFullScreen: false,
        allowMuting: false,
        errorBuilder: (context, error) {
          print(error);
          return Container(
              padding: EdgeInsets.all(16),
              child: Text(
                error,
                style: TextStyle(color: Colors.white),
              ));
        });
    super.initState();
  }

  @override
  void dispose() {
    // dispose controllers
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  void play() {
    //check if playing
    if (widget.videoPlayerController.value.isPlaying) {
      //pause
      widget.videoPlayerController.pause();
    }
    //not playing
    else if (!widget.videoPlayerController.value.isPlaying) {
      //check if its finished
      if (widget.videoPlayerController.value.position ==
          widget.videoPlayerController.value.duration) {
        //restart video
        widget.videoPlayerController.seekTo(Duration(seconds: 0));
        //play
        widget.videoPlayerController.play();
      } else
        widget.videoPlayerController.play();
    }
  }
}
