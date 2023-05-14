import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/exercise_plan_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/video_player.dart';

class ExerciseScreen extends StatefulWidget {
  List<Burners> burners;
  int index;

  ExerciseScreen(this.burners, this.index);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<bool> days = [false, false, false, false, false, false, false];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[300];
  Color unSelectedTextColor = Colors.black;

  // ignore: unused_field
  CountDownController _controller = CountDownController();

  // int index = 0;
  int _duration = 0;
  String status = 'running';

  bool playVideo = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double heightOfBottomBar = MediaQuery.of(context).size.height * 0.07;
    return Scaffold(
      body: Container(
        height: height - (AppBar().preferredSize.height + heightOfBottomBar),
        //margin: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: ListView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                //height: height * 0.30,
                child: Container(
                  height: playVideo
                      ? MediaQuery.of(context).size.height
                      : height * 0.30,
                  child: playVideo
                      ? VideoWidget(
                          url:
                              "$videosBaseUrl${widget.burners[widget.index].videoFile}",
                          play: true)
                      :
                      /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoWidget(
                                  url:
                                      "$videosBaseUrl${widget.burners[widget.index].videoFile}",
                                  play: true)))
                      */
                      Center(
                          child: Container(),
                        ),
                )
                /*child: FutureBuilder(
                        future: _initializedVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },*/

                /*_videoController.value.isInitialized?Center(
                          child: IconButton(
                            onPressed: (){
                              _incrementCounter();
                            },
                            color: Colors.white,
                            iconSize: 42,
                           icon:  Icon(_videoController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ):Container()*/
                ),
            if (!playVideo)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.burners[widget.index].title,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      Text(
                        widget.burners[widget.index].name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (status == "running") {
                          status = "paused";
                          _controller.pause();
                        } else {
                          status = "running";
                          _controller.resume();
                        }
                      });
                    },
                    child: Container(
                        height: 200,
                        child: playVideo
                            ? Center(
                                child: Text(
                                  "GO",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            : CircularCountDownTimer(
                                duration: 3,
                                initialDuration: 0,
                                controller: _controller,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                                ringColor: Colors.grey[300],
                                ringGradient: null,
                                fillColor: Colors.blue,
                                fillGradient: null,
                                backgroundGradient: null,
                                strokeWidth: 5.0,
                                strokeCap: StrokeCap.round,
                                textStyle: TextStyle(
                                    fontSize: 33.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                                textFormat: CountdownTextFormat.S,
                                isReverse: false,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: true,
                                onStart: () {
                                  print('Countdown Started');
                                },
                                onComplete: () {
                                  setState(() {
                                    playVideo = true;
                                  });

                                  print('Countdown Ended');
                                },
                              )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Keep going almost done",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  widget.index <= widget.burners.length - 1
                      ? Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network(
                                '$imageBaseUrl${widget.burners[widget.index].fileName}',
                                height: 40,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Next ${widget.index + 1}/${widget.burners.length}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      widget.index + 1 == widget.burners.length
                                          ? "Last"
                                          : widget
                                              .burners[widget.index + 1].name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Container()
                ],
              )
          ],
        ),
      ),
    );
  }
}
