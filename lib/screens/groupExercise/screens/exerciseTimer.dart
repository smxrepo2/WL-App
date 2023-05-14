import 'dart:async';
import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/AppConfig.dart';

class ExerciseTimer extends StatefulWidget {
  ExerciseTimer({Key key, this.day, this.distance, this.run}) : super(key: key);
  final int day;
  final double distance;
  final bool run;

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  final int _duration = 60;
  final CountDownController _controller = CountDownController();

  int calorieBurnPerSec = 2;
  double distanceCoveredPerSec = 3.5;
  final audioPlayerRun = AudioPlayer();
  final audioPlayerWalk = AudioPlayer();
  final audioPlayerKeep = AudioPlayer();
  final audioPlayerFinishRun = AudioPlayer();
  int calories = 0;
  double distance = 0;

  bool isComplete = false;

  bool paused = false;
  int day;

  String _now;
  Timer _everySecond;
  bool showMessage = false;

  void timerStart() {
    _now = DateTime.now().second.toString();
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        calories += calorieBurnPerSec;
        distance += distanceCoveredPerSec;
        if (_everySecond.tick == 40) {
          showMessage = true;
          audioPlayerKeep.play();
        }
        if (_everySecond.tick == 60) {
          //showMessage = true;
          audioPlayerFinishRun.play();
        }
      });
    });
  }

  Future setPlayerUrls() async {
    await audioPlayerKeep.setAsset('assets/audio/keepGoing.mp3');
    await audioPlayerRun.setAsset('assets/audio/run.mp3');
    await audioPlayerWalk.setAsset('assets/audio/walk.mp3');
    await audioPlayerFinishRun.setAsset('assets/audio/finish.mp3');
    //await audioPlayerRun.setUrl('https://foo.com/bar.mp3');
    //await audioPlayerRun.setAsset('assets/audio/notification2.mp3');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_controller.reset();
    //if (_controller.isStarted) {
    //_everySecond.cancel();
    //}

    //_controller.pause();
    addExercise(9, calories, context);
    audioPlayerKeep.pause();
    audioPlayerRun.pause();
    audioPlayerWalk.pause();
    audioPlayerFinishRun.pause();
    _everySecond.cancel();
    super.dispose();
  }

  addExercise(int typeId, int calories, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    //print("calories ${burner.calories}");
    if (calories > 0) {
      post(
        Uri.parse('$apiUrl/api/diary'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": userid,
          "F_type_id": 9,
          "Burn_Cal": calories
        }),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    day = widget.day;
    distance = widget.distance;
    setPlayerUrls();
    widget.run ? audioPlayerRun.play() : audioPlayerWalk.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '< Day $day >',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 13,
                  color: Color(0xff4885ed),
                ),
                softWrap: false,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoBox(title: 'Time', value: '1:00'),
                InfoBox(title: 'Calories', value: '${calories}kcal'),
                InfoBox(title: 'Distance', value: '${distance}m'),
              ],
            ),
            const Divider(
                indent: 50, endIndent: 50, thickness: 1.5, height: 100),
            Text(
              widget.run ? 'Slow Run' : 'Slow Walk',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 21,
                color: Color(0xff2b2b2b),
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),

            /// For now we are just commenting the code to run the app
            /*Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isComplete) {
                      isComplete = false;
                    }
                    if (!_controller.isStarted) {
                      widget.run
                          ? audioPlayerRun.pause()
                          : audioPlayerWalk.pause();
                      _controller.start();
                      timerStart();
                      setState(() {});
                      return;
                    }
                    if (paused) {
                      _controller.resume();
                      timerStart();
                    } else {
                      _controller.pause();
                      _everySecond.cancel();
                    }
                    paused = !paused;
                    setState(() {});
                  },
                  child: CircularCountDownTimer(
                    duration: _duration,
                    initialDuration: 0,
                    controller: _controller,
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.4,
                    ringColor: const Color(0xffDFDFDF),
                    ringGradient: null,
                    fillColor: const Color(0xff4885ED),
                    fillGradient: null,
                    backgroundColor: Colors.white,
                    backgroundGradient: null,
                    strokeWidth: 5,
                    strokeCap: StrokeCap.round,
                    textStyle: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 50,
                      color: Color(0xff4885ed),
                      fontWeight: FontWeight.w600,
                    ),
                    textFormat: CountdownTextFormat.MM_SS,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: false,
                    onComplete: () {
                      setState(() {
                        isComplete = true;
                        _controller.reset();
                        _everySecond.cancel();
                      });
                    },
                    onChange: (String timeStamp) {},
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.26,
                  left: MediaQuery.of(context).size.width * 0.175,
                  child: isComplete
                      ? const Text(
                          'Tap to repeat',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 13,
                            color: Color(0xff23233c),
                          ),
                        )
                      : Text(
                          _controller.isStarted
                              ? paused
                                  ? 'Tap to start'
                                  : 'Tap to stop'
                              : 'Tap to start',
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 13,
                            color: Color(0xff23233c),
                          ),
                          softWrap: false,
                        ),
                ),
              ],
            ),*/
            if (showMessage)
              Text(
                'Keep going! Almost done',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 15,
                  color: Color(0xffafafaf),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            const SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.nordic_walking),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next ',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 13,
                        color: Color(0xffafafaf),
                      ),
                      softWrap: false,
                    ),
                    Text(
                      widget.run ? 'Walk' : "Run",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: Color(0xff2b2b2b),
                      ),
                      softWrap: false,
                    ),
                    Text(
                      '1 mint',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 13,
                        color: Color(0xffafafaf),
                        fontWeight: FontWeight.w300,
                      ),
                      softWrap: false,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  InfoBox({Key key, @required this.title, @required this.value})
      : super(key: key);

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 51,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x15000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 13,
              color: Color(0xff6e9ef0),
            ),
            softWrap: false,
          ),
          const SizedBox(height: 2.5),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 13,
              color: Color(0xff23233c),
            ),
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
