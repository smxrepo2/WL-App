import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:weight_loser/screens/groupExercise/methods/methods.dart';
import 'package:weight_loser/screens/groupExercise/models/exercise_group_model.dart';
import 'package:weight_loser/screens/groupExercise/models/user_exercise_model.dart';
import 'package:weight_loser/screens/groupExercise/providers/user_exercise_provider.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../../notifications/getit.dart';

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:uiblock/uiblock.dart';
// import 'package:weight_loser/screens/groupExercise/methods/methods.dart';
// import 'package:weight_loser/screens/groupExercise/models/exercise_group_model.dart';
// import 'package:weight_loser/screens/groupExercise/models/user_exercise_model.dart';
// import 'package:weight_loser/screens/groupExercise/providers/user_exercise_provider.dart';
// import 'package:weight_loser/screens/groupExercise/screens/exerciseGroup.dart';
// import 'package:weight_loser/utils/AppConfig.dart';
//
// import '../../../notifications/getit.dart';

class ExerciseGroupTimer extends StatefulWidget {
  ExerciseGroupTimer(
      {Key key,
      @required this.listItem,
      @required this.participant,
      @required this.schedule,
      @required this.groupId})
      : super(key: key);

  ExerciseGroups listItem;
  int caloriesBurnt = 0;
  int participant;
  DateTime schedule;
  int groupId;

  @override
  State<ExerciseGroupTimer> createState() => _ExerciseGroupTimerState();
}

class _ExerciseGroupTimerState extends State<ExerciseGroupTimer> {
  final int _duration = 60;
  final CountDownController _controller = CountDownController();

  int calorieBurnPerSec = 2;
  double distanceCoveredPerSec = 3.5;

  double distance = 0;

  bool isComplete = false;

  bool paused = false;

  var hours;
  var minutes;
  var seconds;
  String _now;
  Timer _everySecond;

  String clock;
  Timer clockSec;
  Future<ExerciseUserModel> _exerciseUserFuture;
  @override
  void dispose() {
    // TODO: implement dispose
    //_controller.reset();
    //if (_controller.isStarted) {
    //_everySecond.cancel();
    //}

    //_controller.pause();

    clockSec.cancel();
    super.dispose();
  }

  void timerStart() {
    _now = DateTime.now().second.toString();
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        widget.caloriesBurnt += calorieBurnPerSec;
        distance += distanceCoveredPerSec;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //getRemainingTime();
    _exerciseUserFuture = GetUserExerciseData(widget.groupId);
    clock = DateTime.now().second.toString();
    clockSec = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        clock = DateTime.now().second.toString();
      });
    });
    // defines a timer
  }

  String getRemainingTime() {
    hours = widget.schedule.difference(DateTime.now()).inHours;
    minutes = widget.schedule.difference(DateTime.now()).inMinutes % 60;
    seconds = widget.schedule.difference(DateTime.now()).inSeconds % 60;
    String remaining = '$hours:$minutes:$seconds';
    if (remaining.contains('-')) {
      return '00:00';
    }
    return remaining;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        /*
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
      */
        body: FutureBuilder<ExerciseUserModel>(
            future: _exerciseUserFuture,
            builder: (context, snapshot) {
              print("Building Future builder");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.done:
                default:
                  if (snapshot.hasError)
                    return Text("No Internet Connectivity");
                  else if (snapshot.hasData) {
                    var _userProvider = getit<exerciseuserprovider>();
                    ExerciseUserModel _exerciseData =
                        _userProvider.getExerciseUser();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 60),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'My Progress',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Color(0xff23233c),
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoBox(title: 'Time', value: '1:00'),
                                InfoBox(
                                    title: 'Calories',
                                    value: '${widget.caloriesBurnt}kcal'),
                                InfoBox(
                                    title: 'Distance', value: '${distance}m'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                                indent: 50, endIndent: 50, thickness: 1.5),

                            /// For now we are just commenting the code to run the app
                            /*   Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isComplete) {
                                      isComplete = false;
                                    }
                                    if (!_controller) {
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
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
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
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height *
                                      0.215,
                                  left:
                                      MediaQuery.of(context).size.width * 0.175,
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
                                          _controller.isPaused
                                              ? 'Tap to start'
                                              : 'Tap to stop',
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 13,
                                            color: Color(0xff23233c),
                                          ),
                                          softWrap: false,
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                if (_controller.isStarted) {
                                  _everySecond.cancel();
                                }
                                _controller.pause();

                                UIBlock.block(context);
                                JoinGroup(widget.groupId,
                                        _exerciseData.userDetails.slotId)
                                    .then((value) {
                                  if (value.statusCode == 200) {
                                    AddUserExercise(
                                            widget.groupId,
                                            _exerciseData.userDetails.slotId,
                                            widget.caloriesBurnt,
                                            distance.toInt(),
                                            clockSec.tick.abs())
                                        .then((value) {
                                      if (value.statusCode == 200) {
                                        UIBlock.unblock(context);
                                        clockSec.cancel();
                                        //if (_everySecond.isActive) _everySecond.cancel();
                                        //if (clockSec.isActive) clockSec.cancel();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseGroup()));
                                      }
                                    });
                                  }
                                });
                                //_controller.pause();
                              },
                              child: const Text(
                                'Quit >',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Color(0xff4885ed),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              ),
                            ),*/
                            const SizedBox(height: 60),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Group Progress',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Color(0xff23233c),
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoBox(
                                    title: 'Time left',
                                    value: getRemainingTime()),
                                InfoBox(
                                    title: 'Participant',
                                    value: widget.participant.toString()),
                                InfoBox(
                                    title: 'My Ranking',
                                    value: _exerciseData.userDetails.sequemceNo
                                        .toString()),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Top Participant ',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Color(0xff23233c),
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.5),
                              height: 75,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      _exerciseData.exerciseGroupInfoVM.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: 69.0,
                                      height: 67.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '$imageBaseUrl${_exerciseData.exerciseGroupInfoVM[index].userFileName}'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
              }
            }));
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
