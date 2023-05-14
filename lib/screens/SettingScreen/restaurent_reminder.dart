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
import 'Weight-reminder.dart';
import 'components.dart';
//import 'exercise-reminder.dart';

class RestReminder extends StatefulWidget {
  const RestReminder({Key key}) : super(key: key);

  @override
  State<RestReminder> createState() => _RestReminderState();
}

class _RestReminderState extends State<RestReminder> {
  restaurantNotifications _notifications;
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
    data = await getNotidata("restaurant_reminder");
    data = json.decode(data);
    print("data from shared preference: ${data}");
    _notifications = restaurantNotifications.fromJson(data);
    var provider = getit<restaurantnotiprovider>();
    provider.setrestaurantNotifications(_notifications);
    setState(() {
      if (_notifications.restaurant[0].subscribed == "true")
        reminderValue = true;
      else
        reminderValue = false;
    });

    print(
        "After provider set data ${_notifications.restaurant[0].subscribed.toString()}");
    startTime = TimeOfDay(
        hour: int.parse(_notifications.restaurant[0].starthours),
        minute: int.parse(_notifications.restaurant[0].startmin));
    endTime = TimeOfDay(
        hour: int.parse(_notifications.restaurant[0].endhour),
        minute: int.parse(_notifications.restaurant[0].endmin));
    id = int.parse(_notifications.restaurant[0].count);
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
                      'Restaurant Reminders',
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

          Column(
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
                            'assets/svg_icons/favouriterest_svg.svg',
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
                                      "Restaurant Reminder",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Transform.scale(
                              scale: .8,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue,
                                onChanged: (v) async {
                                  if (_notifications.restaurant[0].subscribed ==
                                      "true") {
                                    _notifications.restaurant[0].subscribed =
                                        "false";
                                    //deleteNotidata("restaurant_reminder");
                                    setNotidata(
                                        _notifications, "restaurant_reminder");
                                    NotificationService()
                                        .deletesingleNotification(13);
                                  } else {
                                    _notifications.restaurant[0].subscribed =
                                        "true";
                                    setNotidata(
                                        _notifications, "restaurant_reminder");
                                  }
                                  setState(() {
                                    print(v);
                                    reminderValue = v;
                                    _notifications = _notifications;
                                    //provider.setrestaurantNotifications(
                                    //  _notifications);
                                  });

                                  print(
                                      _notifications.restaurant[0].subscribed);

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
                                          .unsubscribeFromTopic("restaurant");
                                      await FirebaseFirestore.instance
                                          .collection('topics')
                                          .doc(token)
                                          .update(
                                              {"restaurant": FieldValue.delete()});
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
                          height:orientation==Orientation.landscape?MediaQuery.of(context).size.height * 0.2:MediaQuery.of(context).size.height * 0.09,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: SvgPicture.asset(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Row(
                                                children: [
                                                  _buildTimePick(context, "",
                                                      true, startTime, (x) {
                                                    _notifications.restaurant[0]
                                                            .starthours =
                                                        x.hour.toString();
                                                    _notifications.restaurant[0]
                                                            .startmin =
                                                        x.minute.toString();

                                                    setState(() {
                                                      print(
                                                          "The picked time is: $x");
                                                      startTime = x;
                                                    });
                                                    setNotidata(_notifications,
                                                        "restaurant_reminder");
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
                                            .deletesingleNotification(13);
                                        _notifications.restaurant[0].count =
                                            data.index.toString();
                                        setState(() {
                                          id = data.index;
                                        });
                                        setNotidata(_notifications,
                                            "restaurant_reminder");
                                        value = id * 5;
                                        await NotificationService()
                                            .showNotification(
                                                13,
                                                "Restaurant Reminder",
                                                "This is restaurant reminder",
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
                                      secondary:
                                      SvgPicture.asset(
                                        'assets/svg_icons/clock_svg.svg',
                                        color: primaryColor,
                                        height: 30,
                                        width: 35,
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
                  )
                ],
              ),

          ],
        ),
      ),
    );
  }
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
