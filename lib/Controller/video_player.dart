import 'dart:convert';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../utils/AppConfig.dart';

class VideoWidget extends StatefulWidget {
  final bool play;
  final int videoId;
  final String url;

  const VideoWidget(
      {Key key,
      @required this.url,
      @required this.play,
      @required this.videoId})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  CustomVideoPlayerController customVideoPlayerController =
      CustomVideoPlayerController();

  CustomVideoPlayerSettings settings = CustomVideoPlayerSettings(
    exitFullscreenOnEnd: true,
  );

  Future saveVideoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    var response = await post(
      Uri.parse('$apiUrl/api/video/UserHistory'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "VideoId": widget.videoId,
        "UserId": userid,
        "Type": "mind"
      }),
    );
    print("video response:+${response.body}");
  }

  @override
  void initState() {
    print("Video Url:" + widget.url);
    videoPlayerController = new VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();

      setState(() {});
    });
    super.initState();
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } // This closing tag was missing

  @override
  void dispose() {
    print("Controller disposed");
    videoPlayerController.dispose();
    customVideoPlayerController.dispose();
    saveVideoData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: CustomVideoPlayer(
                    customVideoPlayerController: customVideoPlayerController,
                    videoPlayerController: videoPlayerController,
                    customVideoPlayerSettings: settings),
              ),
            );
          } else {
            return Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.blue,
                  )),
            );
          }
        },
      ),
    );
  }
}
