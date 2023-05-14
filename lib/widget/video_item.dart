import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;


  VideoItem({
    @required this.videoPlayerController,
    this.looping, this.autoplay,
  });


  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {

  CustomVideoPlayerController customVideoPlayerController = CustomVideoPlayerController();

  Future<void> _initializeVideoPlayerFuture;

  @override
  void dispose() {
    super.dispose();
    customVideoPlayerController.dispose();
    widget.videoPlayerController.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    print("Videoo ${widget.videoPlayerController}");
    _initializeVideoPlayerFuture = widget.videoPlayerController.initialize().then((_) {
      widget.videoPlayerController.play();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return new Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: CustomVideoPlayer(
                    customVideoPlayerController: customVideoPlayerController,
                    videoPlayerController: widget.videoPlayerController,
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
