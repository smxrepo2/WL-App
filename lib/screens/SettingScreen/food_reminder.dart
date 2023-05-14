import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/notifications/notificationmodel.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/select_time.dart';

import '../../notifications/getit.dart';
import '../../notifications/notificationhelper.dart';
import '../../notifications/notificationprovider.dart';
import '../../notifications/notificationservice.dart';
import 'components.dart';
import 'exercise-reminder.dart';

class FoodReminder extends StatefulWidget {
  const FoodReminder({Key key}) : super(key: key);

  @override
  State<FoodReminder> createState() => _FoodReminderState();
}

class _FoodReminderState extends State<FoodReminder> {
  bool reminderValue = false;
  bool reminderValue1 = false;
  bool reminderValue2 = false;
  bool reminderValue3 = false;
  bool reminderValue4 = false;
  bool reminderValue5 = false;
  bool reminderValue6 = false;
  earlysnacksNotifications _earlysnacksnotifications;
  breakfastNotifications _breakfastnotifications;
  morningsnacksNotifications _morningsnacksnotifications;
  lunchNotifications _lunchnotifications;
  afternoonNotifications _afternoonnotifications;
  dinnerNotifications _dinnernotifications;
  snacksNotifications _snacksnotifications;
  var earlysnacksdata;
  var breakfastdata;
  var morningsnacksdata;
  var lunchdata;
  var afternoondata;
  var dinnerdata;
  var snacksdata;
  bool fetched = false;
  String token;
  int value;

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  int id = 1;
  int id1 = 1;
  int id2 = 1;
  int id3 = 1;
  int id4 = 1;
  int id5 = 1;
  int id6 = 1;
  String selectTime;
  String selectTime1;
  String selectTime2;
  String selectTime3;
  String selectTime4;
  String selectTime5;
  String selectTime6;

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
  TimeOfDay startTime1 = TimeOfDay.now();
  TimeOfDay endTime1 = TimeOfDay.now();
  TimeOfDay startTime2 = TimeOfDay.now();
  TimeOfDay endTime2 = TimeOfDay.now();
  TimeOfDay startTime3 = TimeOfDay.now();
  TimeOfDay endTime3 = TimeOfDay.now();
  TimeOfDay startTime4 = TimeOfDay.now();
  TimeOfDay endTime4 = TimeOfDay.now();
  TimeOfDay startTime5 = TimeOfDay.now();
  TimeOfDay endTime5 = TimeOfDay.now();
  TimeOfDay startTime6 = TimeOfDay.now();
  TimeOfDay endTime6 = TimeOfDay.now();
  TimeOfDay startTime7 = TimeOfDay.now();
  TimeOfDay endTime7 = TimeOfDay.now();

  int id7;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    get();
  }

  get() async {
    breakfastdata = await getNotidata("breakfast_reminder");
    breakfastdata = json.decode(breakfastdata);
    print("data from shared preference: ${breakfastdata}");
    _breakfastnotifications = breakfastNotifications.fromJson(breakfastdata);
    var provider = getit<breakfastnotiprovider>();
    provider.setbreakfastNotifications(_breakfastnotifications);
    earlysnacksdata = await getNotidata("earlysnacks_reminder");
    earlysnacksdata = json.decode(earlysnacksdata);
    print("data from shared preference: ${earlysnacksdata}");
    _earlysnacksnotifications =
        earlysnacksNotifications.fromJson(earlysnacksdata);
    var provider1 = getit<earlysnacksnotiprovider>();
    provider1.setearlysnacksNotifications(_earlysnacksnotifications);
    morningsnacksdata = await getNotidata("morningsnacks_reminder");
    morningsnacksdata = json.decode(morningsnacksdata);
    print("data from shared preference: ${morningsnacksdata}");
    _morningsnacksnotifications =
        morningsnacksNotifications.fromJson(morningsnacksdata);
    var provider3 = getit<morningsnacksnotiprovider>();
    provider3.setmorningsnacksNotifications(_morningsnacksnotifications);
    lunchdata = await getNotidata("lunch_reminder");
    lunchdata = json.decode(lunchdata);
    print("data from shared preference: ${lunchdata}");
    _lunchnotifications = lunchNotifications.fromJson(lunchdata);
    var provider4 = getit<lunchnotiprovider>();
    provider4.setlunchNotifications(_lunchnotifications);
    afternoondata = await getNotidata("afternoon_reminder");
    afternoondata = json.decode(afternoondata);
    print("data from shared preference: ${afternoondata}");
    _afternoonnotifications = afternoonNotifications.fromJson(afternoondata);
    var provider5 = getit<afternoonnotiprovider>();
    provider5.setafternoonNotifications(_afternoonnotifications);
    dinnerdata = await getNotidata("dinner_reminder");
    dinnerdata = json.decode(dinnerdata);
    print("data from shared preference: ${dinnerdata}");
    _dinnernotifications = dinnerNotifications.fromJson(dinnerdata);
    var provider6 = getit<dinnernotiprovider>();
    provider6.setdinnerNotifications(_dinnernotifications);
    snacksdata = await getNotidata("snacks_reminder");
    snacksdata = json.decode(snacksdata);
    print("data from shared preference: ${snacksdata}");
    _snacksnotifications = snacksNotifications.fromJson(snacksdata);
    var provider7 = getit<snacksnotiprovider>();
    provider7.setsnacksNotifications(_snacksnotifications);
    setState(() {
      if (_earlysnacksnotifications.earlySnacks[0].subscribed == "true")
        reminderValue = true;
      else
        reminderValue = false;
      if (_breakfastnotifications.breakfast[0].subscribed == "true")
        reminderValue1 = true;
      else
        reminderValue1 = false;
      if (_morningsnacksnotifications.morningSnacks[0].subscribed == "true")
        reminderValue2 = true;
      else
        reminderValue2 = false;
      if (_lunchnotifications.lunch[0].subscribed == "true")
        reminderValue3 = true;
      else
        reminderValue3 = false;
      if (_afternoonnotifications.afterNoon[0].subscribed == "true")
        reminderValue4 = true;
      else
        reminderValue4 = false;
      if (_dinnernotifications.dinner[0].subscribed == "true")
        reminderValue5 = true;
      else
        reminderValue5 = false;
      if (_snacksnotifications.snacks[0].subscribed == "true")
        reminderValue6 = true;
      else
        reminderValue6 = false;
    });

    startTime1 = TimeOfDay(
        hour: int.parse(_earlysnacksnotifications.earlySnacks[0].starthours),
        minute: int.parse(_earlysnacksnotifications.earlySnacks[0].startmin));
    endTime1 = TimeOfDay(
        hour: int.parse(_earlysnacksnotifications.earlySnacks[0].endhour),
        minute: int.parse(_earlysnacksnotifications.earlySnacks[0].endmin));
    id1 = int.parse(_earlysnacksnotifications.earlySnacks[0].count);
    startTime2 = TimeOfDay(
        hour: int.parse(_breakfastnotifications.breakfast[0].starthours),
        minute: int.parse(_breakfastnotifications.breakfast[0].startmin));
    endTime2 = TimeOfDay(
        hour: int.parse(_breakfastnotifications.breakfast[0].endhour),
        minute: int.parse(_breakfastnotifications.breakfast[0].endmin));
    id2 = int.parse(_breakfastnotifications.breakfast[0].count);
    startTime3 = TimeOfDay(
        hour:
            int.parse(_morningsnacksnotifications.morningSnacks[0].starthours),
        minute:
            int.parse(_morningsnacksnotifications.morningSnacks[0].startmin));
    endTime3 = TimeOfDay(
        hour: int.parse(_morningsnacksnotifications.morningSnacks[0].endhour),
        minute: int.parse(_morningsnacksnotifications.morningSnacks[0].endmin));
    id3 = int.parse(_morningsnacksnotifications.morningSnacks[0].count);
    startTime4 = TimeOfDay(
        hour: int.parse(_lunchnotifications.lunch[0].starthours),
        minute: int.parse(_lunchnotifications.lunch[0].startmin));
    endTime4 = TimeOfDay(
        hour: int.parse(_lunchnotifications.lunch[0].endhour),
        minute: int.parse(_lunchnotifications.lunch[0].endmin));
    id4 = int.parse(_lunchnotifications.lunch[0].count);
    startTime5 = TimeOfDay(
        hour: int.parse(_afternoonnotifications.afterNoon[0].starthours),
        minute: int.parse(_afternoonnotifications.afterNoon[0].startmin));
    endTime5 = TimeOfDay(
        hour: int.parse(_afternoonnotifications.afterNoon[0].endhour),
        minute: int.parse(_afternoonnotifications.afterNoon[0].endmin));
    id5 = int.parse(_afternoonnotifications.afterNoon[0].count);
    startTime6 = TimeOfDay(
        hour: int.parse(_dinnernotifications.dinner[0].starthours),
        minute: int.parse(_dinnernotifications.dinner[0].startmin));
    endTime6 = TimeOfDay(
        hour: int.parse(_dinnernotifications.dinner[0].endhour),
        minute: int.parse(_dinnernotifications.dinner[0].endmin));
    id6 = int.parse(_dinnernotifications.dinner[0].count);
    startTime7 = TimeOfDay(
        hour: int.parse(_snacksnotifications.snacks[0].starthours),
        minute: int.parse(_snacksnotifications.snacks[0].startmin));
    endTime7 = TimeOfDay(
        hour: int.parse(_snacksnotifications.snacks[0].endhour),
        minute: int.parse(_snacksnotifications.snacks[0].endmin));
    id7 = int.parse(_snacksnotifications.snacks[0].count);

    //print(_earlysnacksnotifications.earlySnacks[0].topic);
  }

  onChangedFunction1(bool newval) {
    setState(() {
      reminderValue = newval;
    });
  }

  onChangedFunction2(bool newval) {
    setState(() {
      reminderValue1 = newval;
    });
  }

  onChangedFunction3(bool newval) {
    setState(() {
      reminderValue2 = newval;
    });
  }

  onChangedFunction4(bool newval) {
    setState(() {
      reminderValue3 = newval;
    });
  }

  onChangedFunction5(bool newval) {
    setState(() {
      reminderValue4 = newval;
    });
  }

  onChangedFunction6(bool newval) {
    setState(() {
      reminderValue5 = newval;
    });
  }

  onChangedFunction7(bool newval) {
    setState(() {
      reminderValue6 = newval;
    });
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
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
                      ' Food Reminders',
                      style: GoogleFonts.montserrat(
                          fontWeight: regular,
                          fontSize: 15,
                          color: Colors.grey),
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
                ///Early Snack
                GestureDetector(
                  onTap: () {
                    if (reminderValue)
                      reminderValue = false;
                    else
                      reminderValue = true;
                    if (_earlysnacksnotifications.earlySnacks[0].subscribed ==
                        "true") {
                      _earlysnacksnotifications.earlySnacks[0].subscribed =
                          "false";
                      _earlysnacksnotifications.earlySnacks[0].count = "0";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(
                          _earlysnacksnotifications, "earlysnacks_reminder");
                      NotificationService().deletesingleNotification(16);
                    } else {
                      _earlysnacksnotifications.earlySnacks[0].subscribed =
                          "true";
                      setNotidata(
                          _earlysnacksnotifications, "earlysnacks_reminder");
                    }
                    setState(() {
                      reminderValue;
                      id1 = 0;
                      _earlysnacksnotifications = _earlysnacksnotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SvgPicture.asset(
                            'assets/svg_icons/mornig_svg.svg',
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
                                      "Early Snacks",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: SizedBox(
                                width: 10,
                                height: 10,
                                child: CupertinoSwitch(
                                  activeColor: Colors.blue,
                                  value: reminderValue,
                                  onChanged: (v) {
                                    //onChangedFunction1(v);
                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
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
                                )),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime1, (x) {
                                                  _earlysnacksnotifications
                                                          .earlySnacks[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _earlysnacksnotifications
                                                          .earlySnacks[0]
                                                          .startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime1 = x;
                                                  });

                                                  setNotidata(
                                                      _earlysnacksnotifications,
                                                      "earlysnacks_reminder");
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
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id1,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(16);

                                    _earlysnacksnotifications.earlySnacks[0]
                                        .count = data.index.toString();
                                    setState(() {
                                      id1 = data.index;
                                    });
                                    setNotidata(_earlysnacksnotifications,
                                        "earlysnacks_reminder");
                                    value = id1 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            16,
                                            "Early Snacks Reminder",
                                            "This is Early Snacks reminder",
                                            startTime1.hour,
                                            startTime1.minute,
                                            endTime1.hour,
                                            endTime1.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///BreakFast
                GestureDetector(
                  onTap: () {
                    if (reminderValue1)
                      reminderValue1 = false;
                    else
                      reminderValue1 = true;
                    if (_breakfastnotifications.breakfast[0].subscribed ==
                        "true") {
                      _breakfastnotifications.breakfast[0].subscribed = "false";
                      _breakfastnotifications.breakfast[0].count = "0";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(
                          _breakfastnotifications, "breakfast_reminder");
                      NotificationService().deletesingleNotification(17);
                    } else {
                      _breakfastnotifications.breakfast[0].subscribed = "true";
                      setNotidata(
                          _breakfastnotifications, "breakfast_reminder");
                    }
                    setState(() {
                      reminderValue1;
                      id2 = 0;
                      _breakfastnotifications = _breakfastnotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: SvgPicture.asset(
                              'assets/svg_icons/breakfast_svg.svg',
                              color: primaryColor,
                              height: 30,
                              width: 35,
                            )),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Breakfast",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue1,
                                onChanged: (v) {
                                  print(v);
                                  //onChangedFunction2(v);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue1 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                  height: 30,
                                  width: 35,
                            )),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime2, (x) {
                                                  _breakfastnotifications
                                                          .breakfast[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _breakfastnotifications
                                                          .breakfast[0]
                                                          .startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime2 = x;
                                                  });
                                                  setNotidata(
                                                      _breakfastnotifications,
                                                      "breakfast_reminder");
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
                  visible: reminderValue1 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id2,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(17);

                                    _breakfastnotifications.breakfast[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id2 = data.index;
                                    });
                                    setNotidata(_breakfastnotifications,
                                        "breakfast_reminder");
                                    value = id2 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            17,
                                            "BreakFast Reminder",
                                            "This is Break fast reminder",
                                            startTime2.hour,
                                            startTime2.minute,
                                            endTime2.hour,
                                            endTime2.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///Morning Snack

                GestureDetector(
                  onTap: () {
                    if (reminderValue2)
                      reminderValue2 = false;
                    else
                      reminderValue2 = true;
                    if (_morningsnacksnotifications
                            .morningSnacks[0].subscribed ==
                        "true") {
                      _morningsnacksnotifications.morningSnacks[0].subscribed =
                          "false";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(_morningsnacksnotifications,
                          "morningsnacks_reminder");
                      NotificationService().deletesingleNotification(18);
                    } else {
                      _morningsnacksnotifications.morningSnacks[0].subscribed =
                          "true";
                      setNotidata(_morningsnacksnotifications,
                          "morningsnacks_reminder");
                    }
                    setState(() {
                      //print(v);
                      id3 = 0;
                      reminderValue2;
                      _morningsnacksnotifications = _morningsnacksnotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: SvgPicture.asset(
                              'assets/svg_icons/mornig_svg.svg',
                              color: primaryColor,
                              height: 30,
                              width: 35,
                            )),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Morning Snacks",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue2,
                                onChanged: (v) {
                                  //onChangedFunction3(v);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue2 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                height: 30,
                                width: 35,),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime3, (x) {
                                                  _morningsnacksnotifications
                                                          .morningSnacks[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _morningsnacksnotifications
                                                          .morningSnacks[0]
                                                          .startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime3 = x;
                                                  });
                                                  setNotidata(
                                                      _morningsnacksnotifications,
                                                      "morningsnacks_reminder");
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
                  visible: reminderValue2 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id3,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(18);

                                    _morningsnacksnotifications.morningSnacks[0]
                                        .count = data.index.toString();
                                    setState(() {
                                      id3 = data.index;
                                    });
                                    setNotidata(_morningsnacksnotifications,
                                        "morningsnacks_reminder");
                                    value = id3 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            18,
                                            "Morning Snacks Reminder",
                                            "This is Morning Snacks reminder",
                                            startTime3.hour,
                                            startTime3.minute,
                                            endTime3.hour,
                                            endTime3.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///Lunch
                GestureDetector(
                  onTap: () {
                    if (reminderValue3)
                      reminderValue3 = false;
                    else
                      reminderValue3 = true;
                    if (_lunchnotifications.lunch[0].subscribed == "true") {
                      _lunchnotifications.lunch[0].subscribed = "false";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(_lunchnotifications, "lunch_reminder");
                      NotificationService().deletesingleNotification(19);
                    } else {
                      _lunchnotifications.lunch[0].subscribed = "true";
                      setNotidata(_lunchnotifications, "lunch_reminder");
                    }
                    setState(() {
                      //print(v);
                      id4 = 0;
                      reminderValue3;
                      _lunchnotifications = _lunchnotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child:
                          SvgPicture.asset('assets/svg_icons/lunch_svg.svg',color: primaryColor,
                            height: 30,
                            width: 35,),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lunch",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                  activeColor: Colors.blue,
                                  value: reminderValue3,
                                  onChanged: (v) {
                                    //onChangedFunction4(v);
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue3 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                height: 30,
                                width: 35,),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime4, (x) {
                                                  _lunchnotifications
                                                          .lunch[0].starthours =
                                                      x.hour.toString();
                                                  _lunchnotifications
                                                          .lunch[0].startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime4 = x;
                                                  });
                                                  setNotidata(
                                                      _lunchnotifications,
                                                      "lunch_reminder");
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
                  visible: reminderValue3 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id4,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(19);
                                    _lunchnotifications.lunch[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id4 = data.index;
                                    });
                                    setNotidata(
                                        _lunchnotifications, "lunch_reminder");
                                    value = id4 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            19,
                                            "Lunch Reminder",
                                            "This is Lunch reminder",
                                            startTime4.hour,
                                            startTime4.minute,
                                            endTime4.hour,
                                            endTime4.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///After noon snack
                GestureDetector(
                  onTap: () {
                    if (reminderValue4)
                      reminderValue4 = false;
                    else
                      reminderValue4 = true;
                    if (_afternoonnotifications.afterNoon[0].subscribed ==
                        "true") {
                      _afternoonnotifications.afterNoon[0].subscribed = "false";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(
                          _afternoonnotifications, "afternoon_reminder");
                      NotificationService().deletesingleNotification(20);
                    } else {
                      _afternoonnotifications.afterNoon[0].subscribed = "true";
                      setNotidata(
                          _afternoonnotifications, "afternoon_reminder");
                    }
                    setState(() {
                      //print(v);
                      id5 = 0;
                      reminderValue4;
                      _afternoonnotifications = _afternoonnotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SvgPicture.asset('assets/svg_icons/afternoon_svg.svg',color: primaryColor,
                            height: 30,
                            width: 35,),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Afternoon Snacks",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue4,
                                onChanged: (v) {
                                  //onChangedFunction5(v);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue4 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                height: 30,
                                width: 35,),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime5, (x) {
                                                  _afternoonnotifications
                                                          .afterNoon[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _afternoonnotifications
                                                          .afterNoon[0]
                                                          .startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime5 = x;
                                                  });
                                                  setNotidata(
                                                      _afternoonnotifications,
                                                      "afternoon_reminder");
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
                  visible: reminderValue4 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id5,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(20);

                                    _afternoonnotifications.afterNoon[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id5 = data.index;
                                    });
                                    setNotidata(_afternoonnotifications,
                                        "afternoon_reminder");
                                    value = id5 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            20,
                                            "AfterNoon Snacks Reminder",
                                            "This is AfterNoon Snacks reminder",
                                            startTime5.hour,
                                            startTime5.minute,
                                            endTime5.hour,
                                            endTime5.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///Dinner
                GestureDetector(
                  onTap: () {
                    if (reminderValue5)
                      reminderValue5 = false;
                    else
                      reminderValue5 = true;
                    if (_dinnernotifications.dinner[0].subscribed == "true") {
                      _dinnernotifications.dinner[0].subscribed = "false";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(_dinnernotifications, "dinner_reminder");
                      NotificationService().deletesingleNotification(21);
                    } else {
                      _dinnernotifications.dinner[0].subscribed = "true";
                      setNotidata(_dinnernotifications, "dinner_reminder");
                    }
                    setState(() {
                      id6 = 0;
                      reminderValue5;
                      _dinnernotifications = _dinnernotifications;
                      //provider.setmindNotifications(
                      //  _notifications);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SvgPicture.asset('assets/svg_icons/dinner_svg.svg',color: primaryColor,
                            height: 30,
                            width: 35,),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dinner",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue5,
                                onChanged: (v) {
                                  //onChangedFunction6(v);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Visibility(
                  visible: reminderValue5 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                height: 30,
                                width: 35,),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime6, (x) {
                                                  _dinnernotifications.dinner[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _dinnernotifications
                                                          .dinner[0].startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime6 = x;
                                                  });
                                                  setNotidata(
                                                      _dinnernotifications,
                                                      "dinner_reminder");
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
                  visible: reminderValue5 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id6,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(21);
                                    _dinnernotifications.dinner[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id6 = data.index;
                                    });
                                    setNotidata(_dinnernotifications,
                                        "dinner_reminder");
                                    value = id6 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            21,
                                            "Dinner Reminder",
                                            "This is Dinner reminder",
                                            startTime6.hour,
                                            startTime6.minute,
                                            endTime6.hour,
                                            endTime6.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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

                ///Snack
                GestureDetector(
                  onTap: () {
                    if (reminderValue6)
                      reminderValue6 = false;
                    else
                      reminderValue6 = true;

                    if (_snacksnotifications.snacks[0].subscribed == "true") {
                      _snacksnotifications.snacks[0].subscribed = "false";
                      //deleteNotidata("exercise_reexerciseer");
                      setNotidata(_snacksnotifications, "snacks_reminder");
                      NotificationService().deletesingleNotification(22);
                    } else {
                      _snacksnotifications.snacks[0].subscribed = "true";
                      setNotidata(_snacksnotifications, "snacks_reminder");
                    }
                    setState(() {
                      id7 = 0;
                      reminderValue6;
                      _snacksnotifications = _snacksnotifications;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child:
                          SvgPicture.asset('assets/svg_icons/snack_svg.svg',color: primaryColor,
                            height: 30,
                            width: 35,),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Snacks",
                                      style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF23233C)),
                                    ),
                                  ],
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: reminderValue6,
                                onChanged: (v) {
                                  //onChangedFunction7(v);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: reminderValue6 == true,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: orientation == Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.09,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset('assets/svg_icons/remider_svg.svg',color: primaryColor,
                                height: 30,
                                width: 35,),
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
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              children: [
                                                _buildTimePick(context, "",
                                                    true, startTime7, (x) {
                                                  _snacksnotifications.snacks[0]
                                                          .starthours =
                                                      x.hour.toString();
                                                  _snacksnotifications
                                                          .snacks[0].startmin =
                                                      x.minute.toString();

                                                  setState(() {
                                                    print(
                                                        "The picked time is: $x");
                                                    startTime7 = x;
                                                  });
                                                  setNotidata(
                                                      _snacksnotifications,
                                                      "snacks_reminder");
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
                  visible: reminderValue6 == true,
                  child: Column(
                      children: nList
                          .map(
                            (data) => Column(
                              children: [
                                RadioListTile(
                                  value: data.index,
                                  groupValue: id7,
                                  onChanged: (val) async {
                                    await NotificationService()
                                        .deletesingleNotification(22);
                                    _snacksnotifications.snacks[0].count =
                                        data.index.toString();
                                    setState(() {
                                      id7 = data.index;
                                    });
                                    setNotidata(_snacksnotifications,
                                        "snacks_reminder");
                                    value = id7 * 5;
                                    await NotificationService()
                                        .showNotification(
                                            22,
                                            "Snacks Reminder",
                                            "This is Snacks reminder",
                                            startTime7.hour,
                                            startTime7.minute,
                                            endTime7.hour,
                                            endTime7.minute,
                                            value,
                                            0);
                                    Flushbar(
                                      title: 'Success',
                                      message: 'Reminder is Set',
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    )..show(context);
                                  },
                                  title: Text(
                                    data.number,
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
