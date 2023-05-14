import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/screens/groupExercise/methods/methods.dart';
import 'package:weight_loser/screens/groupExercise/models/exercise_group_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import 'exerciseGroupTimer.dart';

class ExerciseGroup extends StatefulWidget {
  ExerciseGroup({Key key}) : super(key: key);

  @override
  State<ExerciseGroup> createState() => _ExerciseGroupState();
}

class _ExerciseGroupState extends State<ExerciseGroup> {
  Future<ExerciseGroupsModel> _exerciseGroupsFuture;

  @override
  void initState() {
    super.initState();
    _exerciseGroupsFuture = GetGroupExerciseData();
  }

  List<Map<String, dynamic>> data = [
    {
      'title': 'Walk Group',
      'participant': 200,
      'freeSlots': 5,
      'schedule': DateTime(2022, 9, 3, 22),
      'caloriesBurnt': 200,
      'image':
          'https://images.wisegeek.com/slideshow-mobile-small/exercise.jpg',
    },
    {
      'title': '5k Runner ',
      'participant': 200,
      'freeSlots': 5,
      'schedule': DateTime(2022, 9, 3, 23),
      'caloriesBurnt': 200,
      'image':
          'https://images.wisegeek.com/slideshow-mobile-small/exercise.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<ExerciseGroupsModel>(
          future: _exerciseGroupsFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
              default:
                if (snapshot.hasError)
                  return Scaffold(
                      appBar: AppBar(
                        elevation: 0.2,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      body: Center(child: Text("No Data is Available")));
                else if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0.2,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    body: ListView.builder(
                      itemCount: snapshot.data.exerciseGroups.length,
                      itemBuilder: (context, index) {
                        return ExerciseGroupContainer(
                          listItem: snapshot.data.exerciseGroups[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("No Data"),
                  );
                }
            }
          }),
    );
  }
}

class ExerciseGroupContainer extends StatefulWidget {
  ExerciseGroupContainer({Key key, @required this.listItem}) : super(key: key);

  ExerciseGroups listItem;
  //DateTime schedule;

  @override
  State<ExerciseGroupContainer> createState() => _ExerciseGroupContainerState();
}

class _ExerciseGroupContainerState extends State<ExerciseGroupContainer> {
  ExerciseGroups _listItem;
  List scheduleArray = [];
  var hours;
  var minutes;
  var seconds;
  String clock;
  Timer clockSec;
  DateTime now;
  @override
  void dispose() {
    // TODO: implement dispose
    clockSec.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._listItem = widget.listItem;
    print("StartAt:" + _listItem.startAt);
    scheduleArray = _listItem.startAt.replaceAll("\"", "").split(':');
    now = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(scheduleArray[0].toString()),
        int.parse(scheduleArray[1].toString()));
    //scheduleArray.add("00");
    //getRemainingTime(scheduleArray);
    clock = DateTime.now().second.toString();

    // defines a timer
    clockSec = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        clock = DateTime.now().second.toString();
      });
    });
  }

  String getRemainingTime(List schedule) {
    print("scheduleArray:" + scheduleArray[0]);
    //String scheduleDate = DateFormat("yyyy-mm-dd").format( );
    //DateTime now = DateTime.parse(scheduleDate);

    print("New Date:" + now.toString());
    hours = now.difference(DateTime.now()).inHours;
    minutes = now.difference(DateTime.now()).inMinutes % 60;
    seconds = now.difference(DateTime.now()).inSeconds % 60;
    String remaining = '$hours:$minutes:$seconds';
    print("remaining exercise time:$remaining");
    if (remaining.contains('-')) {
      if (hours.abs() <= 3) {
        //clockSec.cancel();

        return '00:00';
        //}
      }
    }

    return remaining;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            _listItem.name ?? "Not Available",
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 15,
              color: Color(0xff23233c),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0a000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopDetailsBox(
                  title: 'Time left',
                  value: getRemainingTime(scheduleArray) == "00.00"
                      ? "In Progress"
                      : getRemainingTime(scheduleArray),
                ),
                TopDetailsBox(
                  title: 'Participant',
                  value: _listItem.participants.toString(),
                ),
                TopDetailsBox(
                  title: 'Free slots',
                  value: (_listItem.targetParticipants - _listItem.participants)
                      .toString(),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    MiddleDetailsBox(
                      title: 'Schedule',
                      value: '${scheduleArray[0]}:${scheduleArray[1]}',
                    ),
                    const SizedBox(height: 10),
                    MiddleDetailsBox(
                      title: 'Target Calories',
                      value: '${_listItem.calories}kcal',
                    ),
                  ],
                ),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_listItem.fileName == null
                          ? 'https://images.wisegeek.com/slideshow-mobile-small/exercise.jpg'
                          : '$imageBaseUrl${_listItem.fileName}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(7.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              /*
              setState(() {
                widget.freeSlots--;
                if (widget.freeSlots < 0) {
                  widget.freeSlots = 0;
                } else {
                  widget.participant++;
                }
              });
              */

              if (getRemainingTime(scheduleArray) == "00:00") {
                if (_listItem.participants != 0) {
                  UIBlock.block(context);
                  JoinGroup(_listItem.groupId, _listItem.slotId).then((value) {
                    UIBlock.unblock(context);
                    if (value.statusCode == 200) {
                      //clockSec.cancel();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ExerciseGroupTimer(
                                    listItem: _listItem,
                                    groupId: _listItem.groupId,
                                    schedule: now,
                                    participant: _listItem.targetParticipants,
                                  )));
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Empty Slot"),
                    backgroundColor: Colors.red,
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Group Exercise is not Started Yet"),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: const Text(
              'Join  >',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: Color(0xff4885ed),
              ),
              softWrap: false,
            ),
          ),
          const Divider(
            height: 25,
            indent: 100,
            endIndent: 100,
            color: Color(0xff707070),
          )
        ],
      ),
    );
  }
}

class MiddleDetailsBox extends StatelessWidget {
  MiddleDetailsBox({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 13,
              color: Color(0xff23233c),
            ),
            children: [
              TextSpan(
                text: '$title\n',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: value,
              ),
            ],
          ),
          textHeightBehavior:
              const TextHeightBehavior(applyHeightToFirstAscent: false),
          softWrap: false,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TopDetailsBox extends StatelessWidget {
  TopDetailsBox({Key key, @required this.title, @required this.value})
      : super(key: key);

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
          const SizedBox(height: 5),
          Text(
            value.toString(),
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 13,
              color: Color(0xff23233c),
            ),
          )
        ],
      ),
    );
  }
}
