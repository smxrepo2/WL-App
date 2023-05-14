import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final bool play;

  final String url;

  const Video({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;
  CustomVideoPlayerController customVideoPlayerController =
      CustomVideoPlayerController();
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? CustomVideoPlayer(
                videoPlayerController: _controller,
                customVideoPlayerController: customVideoPlayerController,
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[400],
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
