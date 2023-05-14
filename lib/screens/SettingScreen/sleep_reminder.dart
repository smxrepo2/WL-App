import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/notifications/functions.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../notifications/getit.dart';
import '../../notifications/notificationhelper.dart';
import '../../notifications/notificationmodel.dart';
import '../../notifications/notificationprovider.dart';
import '../../notifications/notificationservice.dart';
import 'Weight-reminder.dart';
import 'components.dart';
//import 'exercise-reminder.dart';

class SleepReminder extends StatefulWidget {
  const SleepReminder({Key key}) : super(key: key);

  @override
  State<SleepReminder> createState() => _SleepReminderState();
}

class _SleepReminderState extends State<SleepReminder> {
  sleepNotifications _notifications;
  bool reminderValue = false;
  int id = 1;
  int value;
  var data;
  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "Remind me 5 min prior",
    ),
    NumberList(
      index: 2,
      number: "Remind me 10 min prior",
    ),
    NumberList(
      index: 3,
      number: "Remind me 15 min prior",
    ),
    NumberList(
      index: 4,
      number: "Remind me 25 min prior",
    ),
    NumberList(
      index: 5,
      number: "Remind me 45 min prior",
    ),
    NumberList(
      index: 6,
      number: "Remind me 1 hr prior",
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
    data = await getNotidatasleep();
    data = json.decode(data);
    print("data from shared preference: ${data}");
    _notifications = sleepNotifications.fromJson(data);
    var provider = getit<sleepnotiprovider>();
    provider.setsleepNotifications(_notifications);
    setState(() {
      if (_notifications.sleep[0].subscribed == "true")
        reminderValue = true;
      else
        reminderValue = false;
    });

    print(
        "After provider set data ${_notifications.sleep[0].subscribed.toString()}");
    startTime = TimeOfDay(
        hour: int.parse(_notifications.sleep[0].starthours),
        minute: int.parse(_notifications.sleep[0].startmin));
    endTime = TimeOfDay(
        hour: int.parse(_notifications.sleep[0].endhour),
        minute: int.parse(_notifications.sleep[0].endmin));
    id = int.parse(_notifications.sleep[0].count);
  }

  @override
  Widget build(BuildContext context) {
    var orientation=MediaQuery.of(context).orientation;
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Sleep Reminders',
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF23233C)),
                      ),
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.08,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SvgPicture.asset(
                        'assets/svg_icons/sleeping_svg.svg',
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
                                  "Sleep Reminder",
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
                              onChanged: (v) {
                                if (_notifications.sleep[0].subscribed ==
                                    "true") {
                                  _notifications.sleep[0].subscribed = "false";
                                  //deleteNotidata("sleep_reminder");
                                  setNotidata(_notifications, "sleep_reminder");
                                  NotificationService()
                                      .deletesingleNotification(10);
                                } else {
                                  _notifications.sleep[0].subscribed = "true";
                                  setNotidata(_notifications, "sleep_reminder");
                                }
                                setState(() {
                                  print(v);
                                  reminderValue = v;
                                  _notifications = _notifications;
                                  //provider.setwaterNotifications(
                                  //  _notifications);
                                });

                                print(_notifications.sleep[0].subscribed);
                              }),
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
                      height: orientation==Orientation.landscape?MediaQuery.of(context).size.height * 0.2:MediaQuery.of(context).size.height * 0.09,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            SvgPicture.asset(
                              'assets/svg_icons/reminder_svg.svg',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        .sleep[0].starthours =
                                                    x.hour.toString();
                                                _notifications
                                                        .sleep[0].startmin =
                                                    x.minute.toString();

                                                setState(() {
                                                  print(
                                                      "The picked time is: $x");
                                                  startTime = x;
                                                });
                                                setNotidata(_notifications,
                                                    "sleep_reminder");
                                              }),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
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
                          (data) => Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(10);

                                    _notifications.sleep[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id = data.index;
                                    });
                                    setNotidata(
                                        _notifications, "sleep_reminder");
                                    value = id * 5;
                                    await NotificationService()
                                        .showNotification(
                                            10,
                                            "Sleep Reminder",
                                            "Go to Sleep",
                                            startTime.hour,
                                            startTime.minute,
                                            endTime.hour,
                                            endTime.minute,
                                            value,
                                            0);
                                    showflushbar(context);
                                  },
                                  title: Text(
                                    data.number,
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFF23233C)),
                                  ),
                                  secondary:
                                  SvgPicture.asset(
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
                          ),
                        )
                        .toList()),
              )
            ],
          ),

      ),
    );
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
}
