import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';

import 'package:weight_loser/screens/SettingScreen/components.dart';
import 'package:weight_loser/screens/SettingScreen/restaurent_reminder.dart';
import 'package:weight_loser/screens/SettingScreen/selfie_reminder.dart';
import 'package:weight_loser/screens/SettingScreen/sleep_reminder.dart';
import 'package:weight_loser/screens/SettingScreen/water_reminderr.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/utils/TextConstant.dart';

import 'Weight-reminder.dart';
import 'bolg_reminder.dart';
import 'exercise-reminder.dart';
import 'food_reminder.dart';
import 'mind_reminder.dart';

class ReminderSetting extends StatefulWidget {
  const ReminderSetting({Key key}) : super(key: key);

  @override
  State<ReminderSetting> createState() => _ReminderSettingState();
}

class _ReminderSettingState extends State<ReminderSetting> {
  @override
  Widget build(BuildContext context) {
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
                      'Reminders',
                      style: GoogleFonts.montserrat(
                          fontWeight: regular,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
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
                reminderTileComponent(
                    image: 'assets/svg_icons/food_svg.svg',
                    title: "Food",
                    subtitle: "7 Meals",
                    oNTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodReminder()));
                    },
                    context: context),
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
                reminderTileComponent(
                    image: 'assets/svg_icons/workout_svg.svg',
                    title: "WorkOut",
                    subtitle: "Start at 6:00",
                    oNTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseReminder()));
                    },
                    context: context),
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
                reminderTileComponent(
                    image: 'assets/svg_icons/mind_svg.svg',
                    title: "Mind",
                    subtitle: "Starts at 6:00",
                    oNTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MindReminder()));
                    },
                    context: context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                /*
                Divider(
                  color: Color(0xFFF8F8FA),
                  thickness: 4.0,
                ),
                
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                reminderTileComponent(
                    image: 'assets/svg_icons/blogs_svg.svg',
                    title: "Blog",
                    subtitle: "tags",
                    oNTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogReminder()));
                    },
                    context: context),
                */
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
                          )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Restaurant",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RestReminder()));
                            },
                            child: Text(
                              "SET",
                              style: TextStyle(
                                  fontWeight: regular,
                                  fontSize: 11,
                                  color: primaryColor,
                                  fontFamily: 'Open Sans'),
                            )),
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
                                    "Sleep",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SleepReminder()));
                          },
                          child: Text(
                            "SET",
                            style: TextStyle(
                                fontWeight: regular,
                                fontSize: 11,
                                color: primaryColor,
                                fontFamily: 'Open Sans'),
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
                                    "Water",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WaterReminder()));
                          },
                          child: Text(
                            "SET",
                            style: TextStyle(
                                fontWeight: regular,
                                fontSize: 11,
                                color: primaryColor,
                                fontFamily: 'Open Sans'),
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SvgPicture.asset(
                          'assets/svg_icons/selfie_svg.svg',
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
                                    "Selfie",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelfieReminder()));
                          },
                          child: Text(
                            "SET",
                            style: TextStyle(
                                fontWeight: regular,
                                color: primaryColor,
                                fontSize: 11,
                                fontFamily: 'Open Sans'),
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SvgPicture.asset(
                          'assets/svg_icons/weight_svg.svg',
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
                                    "Weight",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF23233C)),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeightReminder()));
                          },
                          child: Text(
                            "SET",
                            style: TextStyle(
                                fontWeight: regular,
                                fontSize: 11,
                                color: primaryColor,
                                fontFamily: 'Open Sans'),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
