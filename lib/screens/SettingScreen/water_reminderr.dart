import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/constants/notificationsubscription.dart';
import 'package:weight_loser/notifications/notificationmodel.dart';
import 'package:weight_loser/notifications/notificationprovider.dart';
import 'package:weight_loser/notifications/notificationservice.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../notifications/functions.dart';
import '../../notifications/getit.dart';
import '../../notifications/notificationhelper.dart';
import 'components.dart';
import 'exercise-reminder.dart';

class WaterReminder extends StatefulWidget {
  const WaterReminder({Key key}) : super(key: key);

  @override
  State<WaterReminder> createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> {
  waterNotifications _notifications;
  String token;
  bool reminderValue = false;
  bool value = false;
  int id;
  var data;

  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "Remind me 1 Times a Day",
    ),
    NumberList(
      index: 2,
      number: "Remind me 2 Times a Day",
    ),
    NumberList(
      index: 3,
      number: "Remind me 3 Times a Day",
    ),
    NumberList(
      index: 4,
      number: "Remind me 4 Times a Day",
    ),
    NumberList(
      index: 5,
      number: "Remind me 5 Times a Day",
    ),
    NumberList(
      index: 6,
      number: "Remind me 6 Times a Day",
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
    data = await getNotidata("water_reminder");
    data = json.decode(data);
    print("data from shared preference: ${data}");
    _notifications = waterNotifications.fromJson(data);
    var provider = getit<waternotiprovider>();
    provider.setwaterNotifications(_notifications);
    setState(() {
      if (_notifications.water[0].subscribed == "true")
        reminderValue = true;
      else
        reminderValue = false;
    });

    print(
        "After provider set data ${_notifications.water[0].subscribed.toString()}");
    startTime = TimeOfDay(
        hour: int.parse(_notifications.water[0].starthours),
        minute: int.parse(_notifications.water[0].startmin));
    endTime = TimeOfDay(
        hour: int.parse(_notifications.water[0].endhour),
        minute: int.parse(_notifications.water[0].endmin));
    id = int.parse(_notifications.water[0].count);
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
                        'Water Reminders',
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
                        'assets/svg_icons/water_svg.svg',
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
                                  "Drink Water Reminder",
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
                                  if (_notifications.water[0].subscribed ==
                                      "true") {
                                    _notifications.water[0].subscribed =
                                        "false";
                                    //deleteNotidata("water_reminder");
                                    setNotidata(
                                        _notifications, "water_reminder");
                                    NotificationService()
                                        .deleteNotification("water_reminder");
                                  } else {
                                    _notifications.water[0].subscribed = "true";
                                    setNotidata(
                                        _notifications, "water_reminder");
                                  }
                                  setState(() {
                                    print(v);
                                    reminderValue = v;
                                    _notifications = _notifications;
                                    //provider.setwaterNotifications(
                                    //  _notifications);
                                  });

                                  print(_notifications.water[0].subscribed);

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
                                          .unsubscribeFromTopic("Water");
                                      await FirebaseFirestore.instance
                                          .collection('topics')
                                          .doc(token)
                                          .update(
                                              {"Water": FieldValue.delete()});
                                              */
                                })
                            /*
                                      : CupertinoSwitch(
                                          activeColor: Colors.blue,
                                          value: false,
                                          onChanged: (v) async {
                                            /*
                                            setNotidata();
                                            NotificationService().showNotification(
                                                int.parse(_notifications
                                                    .water[0].id
                                                    .toString()),
                                                "Water Reminder",
                                                "Drink glass of water",
                                                int.parse(_notifications
                                                    .water[0].starthours
                                                    .toString()),
                                                int.parse(_notifications
                                                    .water[0].startmin
                                                    .toString()),
                                                int.parse(_notifications
                                                    .water[0].endhour
                                                    .toString()),
                                                int.parse(_notifications
                                                    .water[0].endmin
                                                    .toString()),
                                                int.parse(_notifications.water[0].count.toString()),
                                                4);
                                                */
                                            /*
                                      token = await getDeviceToken();
                                      await FirebaseMessaging.instance
                                          .subscribeToTopic("Water");
                                      await FirebaseFirestore.instance
                                          .collection('topics')
                                          .doc(token)
                                          .set({'Water': 'subscribed'},
                                              SetOptions(merge: true));
                                              */
                                          })*/
                            ),
                      ),
                    ),
                  ],
                ),
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
              // Container(
              //   width: double.infinity,
              //   height: MediaQuery.of(context).size.height * 0.08,
              //   color: Colors.white,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 30),
              //         child: Image.asset(
              //           ImagePath.weightW,
              //           color: primaryColor,
              //         ),
              //       ),
              //       Expanded(
              //           child: Padding(
              //               padding: const EdgeInsets.only(left: 20),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "Drink Water Reminder",
              //                     style: GoogleFonts.openSans(
              //                         fontSize: 15,
              //                         fontWeight: FontWeight.w400,
              //                         color: const Color(0xFF23233C)),
              //                   ),
              //                 ],
              //               ))),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 30),
              //         child: Padding(
              //           padding: const EdgeInsets.only(right: 20),
              //           child: Transform.scale(
              //             scale: .8,
              //             child: CupertinoSwitch(
              //               activeColor: Colors.blue,
              //               value: reminderValue,
              //               onChanged: (v) => setState(() => reminderValue = v),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.01,
              // ),
              // Divider(
              //   color: Color(0xFFF8F8FA),
              //   thickness: 4.0,
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.01,
              // ),
              Visibility(
                visible: reminderValue == true,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height:orientation==Orientation.landscape?MediaQuery.of(context).size.height * 0.2:MediaQuery.of(context).size.height * 0.09,
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
                                                        .water[0].starthours =
                                                    x.hour.toString();
                                                _notifications
                                                        .water[0].startmin =
                                                    x.minute.toString();

                                                setState(() {
                                                  print(
                                                      "The picked time is: $x");
                                                  startTime = x;
                                                });
                                                setNotidata(_notifications,
                                                    "water_reminder");
                                              }),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("-"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _buildTimePick(
                                                  context, "", true, endTime,
                                                  (x) {
                                                _notifications
                                                        .water[0].endhour =
                                                    x.hour.toString();
                                                _notifications.water[0].endmin =
                                                    x.minute.toString();
                                                setState(() {
                                                  endTime = x;
                                                  print(
                                                      "The picked time is: $x");
                                                });
                                                setNotidata(_notifications,
                                                    "water_reminder");
                                              }),
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
                  children: [
                    Column(
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
                                            .deleteNotification(
                                                "Water Notification");

                                        _notifications.water[0].count =
                                            data.index.toString();
                                        setState(() {
                                          id = data.index;
                                        });
                                        setNotidata(
                                            _notifications, "water_reminder");
                                        int hdiff =
                                            endTime.hour - startTime.hour;
                                        int mdiff =
                                            endTime.minute - startTime.minute;
                                        print("hours difference $hdiff");
                                        if (hdiff > 0) hdiff = hdiff * 60;

                                        int difference =
                                            hdiff.abs() + mdiff.abs();
                                        double interval = difference / id;
                                        double addtime = 0.0;
                                        TimeOfDay ftime = startTime;
                                        print("count $id");
                                        for (int i = 0; i < id; i++) {
                                          await NotificationService()
                                              .showNotification(
                                                  i,
                                                  "Water Reminder",
                                                  "Please drink a glass of water",
                                                  ftime.hour,
                                                  ftime.minute,
                                                  endTime.hour,
                                                  endTime.minute,
                                                  id,
                                                  0);
                                          addtime = startTime.minute +
                                              addtime +
                                              interval;
                                          int newaddtime = addtime.toInt();
                                          print("add minute $newaddtime");
                                          ftime = TimeOfDay(
                                              hour: ftime.hour,
                                              minute: newaddtime);
                                          print("new time" + ftime.toString());
                                        }
                                        showflushbar(context);

                                        //SharedPreferences prefs =
                                        //  await SharedPreferences
                                        //    .getInstance();
                                        //prefs.setInt('id', id);
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
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList()),
                  ],
                ),
              )
            ],
          ),

      ),
    );
  }
  //return CircularProgressIndicator();

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
