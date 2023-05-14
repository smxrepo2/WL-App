import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import 'exercise-reminder.dart';

class BlogReminder extends StatefulWidget {
  const BlogReminder({Key key}) : super(key: key);

  @override
  State<BlogReminder> createState() => _BlogReminderState();
}

class _BlogReminderState extends State<BlogReminder> {
  bool reminderValue = false;
  int id = 1;
  List<NumberList> nList = [
    NumberList(
      val: false,
      number: "Exercise",
    ),
    NumberList(
      val: false,
      number: "Weight Loss",
    ),
    NumberList(
      val: false,
      number: "Food",
    ),
    NumberList(
      val: false,
      number: "Restaurant",
    ),
    NumberList(
      val: false,
      number: "other",
    ),
  ];

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
                      'Blog Reminders',
                      style: GoogleFonts.montserrat(fontWeight: regular,
                          fontSize: 15, color: Colors.grey),
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
                      'assets/svg_icons/favourite_svg.svg',
                      color: primaryColor,
                      height: 30,
                      width: 35,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recommended Blog Notification",
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
                          onChanged: (v) => setState(() => reminderValue = v),
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
            Column(
              children: nList
                  .map((data) => Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: CheckboxListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    title: Text(
                      data.number,
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF23233C)),
                    ),
                        value: data.val,
                        onChanged: (val) {
                          setState(() {
                             data.val=val;
                          });
                        }),
                  ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class NumberList {
  String number;
  bool val;
  NumberList({this.number, this.val});
}
