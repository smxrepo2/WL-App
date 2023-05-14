import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/notifications/functions.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/select_time.dart';

import '../../notifications/getit.dart';
import '../../notifications/notificationhelper.dart';
import '../../notifications/notificationmodel.dart';
import '../../notifications/notificationprovider.dart';
import '../../notifications/notificationservice.dart';
import 'components.dart';
import 'exercise-reminder.dart';

class ExerciseReminder extends StatefulWidget {
  const ExerciseReminder({Key key}) : super(key: key);

  @override
  State<ExerciseReminder> createState() => _ExerciseReminderState();
}

class _ExerciseReminderState extends State<ExerciseReminder> {
  exerciseNotifications _notifications;
  var data;
  String token;
  bool reminderValue = false;
  //bool value = false;
  int value;
  int id = 1;
  String selectTime = "5 min";
  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "5 min",
    ),
    NumberList(
      index: 2,
      number: "10 min",
    ),
    NumberList(
      index: 3,
      number: "15 min",
    ),
    NumberList(
      index: 4,
      number: "25 min",
    ),
    NumberList(
      index: 5,
      number: "45 min",
    ),
    NumberList(
      index: 6,
      number: "1 hr",
    ),
  ];

  TimeOfDay startTime;
  TimeOfDay endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();
  }

  get() async {
    data = await getNotidata("exercise_reminder");
    data = json.decode(data);
    print("data from shared preference: ${data}");
    _notifications = exerciseNotifications.fromJson(data);
    var provider = getit<exercisenotiprovider>();
    provider.setexerciseNotifications(_notifications);
    setState(() {
      if (_notifications.exercise[0].subscribed == "true")
        reminderValue = true;
      else
        reminderValue = false;
    });

    print(
        "After provider set data ${_notifications.exercise[0].subscribed.toString()}");
    startTime = TimeOfDay(
        hour: int.parse(_notifications.exercise[0].starthours),
        minute: int.parse(_notifications.exercise[0].startmin));
    endTime = TimeOfDay(
        hour: int.parse(_notifications.exercise[0].endhour),
        minute: int.parse(_notifications.exercise[0].endmin));
    id = int.parse(_notifications.exercise[0].count);
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    print("tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    ' Exercise Reminders',
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: Color(0xFFF8F8FA),
              thickness: 4.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SvgPicture.asset(
                          'assets/svg_icons/workout_svg.svg',
                          color: primaryColor,
                          height: 30,
                          width: 35,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WorkOut Reminder",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Transform.scale(
                            scale: .8,
                            child: CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: reminderValue,
                              onChanged: (v) async {
                                if (_notifications.exercise[0].subscribed ==
                                    "true") {
                                  _notifications.exercise[0].subscribed =
                                      "false";
                                  //deleteNotidata("exercise_reexerciseer");
                                  setNotidata(
                                      _notifications, "exercise_reminder");
                                  NotificationService()
                                      .deletesingleNotification(15);
                                } else {
                                  _notifications.exercise[0].subscribed =
                                      "true";
                                  setNotidata(
                                      _notifications, "exercise_reminder");
                                }
                                setState(() {
                                  print(v);
                                  reminderValue = v;
                                  _notifications = _notifications;
                                  //provider.setmindNotifications(
                                  //  _notifications);
                                });

                                print(_notifications.exercise[0].subscribed);

                                /*
                                          setState(() {
                                            reminderValue = v;

                                            //subscribed.remove("Water");
                                          });
                                          */
                                //deleteNotidata();
                                //NotificationService()
                                //  .deleteNotification(0);

                                /*
                                    token = await getDeviceToken();
                                    print("fcmtoken" + token);
                                    await FirebaseMessaging.instance
                                        .unsubscribeFromTopic("mind");
                                    await FirebaseFirestore.instance
                                        .collection('topics')
                                        .doc(token)
                                        .update(
                                            {"mind": FieldValue.delete()});
                                            */
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Divider(
                  color: Color(0xFFF8F8FA),
                  thickness: 4.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Visibility(
                  visible: reminderValue == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: _size > 500
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset(
                                'assets/svg_icons/remider_svg.svg',
                                color: primaryColor,
                                height: 30,
                                width: 35,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: GoogleFonts.openSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF797A7A)),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          children: [
                                            _buildTimePick(
                                                context, "", true, startTime,
                                                (x) {
                                              _notifications
                                                      .exercise[0].starthours =
                                                  x.hour.toString();
                                              _notifications
                                                      .exercise[0].startmin =
                                                  x.minute.toString();

                                              setState(() {
                                                print("The picked time is: $x");
                                                startTime = x;
                                              });
                                              setNotidata(_notifications,
                                                  "exercise_reminder");
                                            }),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: reminderValue == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(10);

                                    _notifications.exercise[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id = data.index;
                                    });
                                    setNotidata(
                                        _notifications, "exercise_reminder");
                                    value = id * 5;
                                    await NotificationService()
                                        .showNotification(
                                            15,
                                            "exercise Reminder",
                                            "This is exercise reminder",
                                            startTime.hour,
                                            startTime.minute,
                                            endTime.hour,
                                            endTime.minute,
                                            value,
                                            0);
                                    showflushbar(context);
                                  },
                                  title: Text(
                                    "Remind me ${data.number} prior",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFF23233C)),
                                  ),
                                  secondary: SvgPicture.asset(
                                    'assets/svg_icons/clock_svg.svg',
                                    color: primaryColor,
                                    height: 20,
                                    width: 25,
                                  ),
                                  toggleable: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                              ],
                            ),
                          )
                          .toList()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberList {
  String number;
  int index;
  NumberList({this.number, this.index});
}

Future selectedTime(BuildContext context, bool ifPickedTime,
    TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
  var _pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);
  if (_pickedTime != null) {
    onTimePicked(_pickedTime);
  }
}

Widget _buildTimePick(context, String title, bool ifPickedTime,
    TimeOfDay currentTime, Function(TimeOfDay) onTimePicked) {
  return Row(
    children: [
      SizedBox(
        width: 10,
        child: Text(
          title,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: GestureDetector(
          child: Text(
            currentTime.format(context),
          ),
          onTap: () {
            selectedTime(context, ifPickedTime, currentTime, onTimePicked);
          },
        ),
      ),
    ],
  );
}
