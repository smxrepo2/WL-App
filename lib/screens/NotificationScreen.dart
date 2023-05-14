import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weight_loser/Component/DDText.dart';

import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import 'Bottom_Navigation/bottom.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key key}) : super(key: key);
  final notikey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      Navigator.pop(context, true);
      return false; // return true if the route to be popped
    }

    MySize().init(context);
    List notificationData = [
      {
        "title": "Meal reminder (Lunch)",
        "details": "Your lunch time is about to start at 12:30",
        "icon": Icons.dinner_dining,
        "image": "assets/icons/dinner.png",
        "color": Color(0xffD1DFF8)
      },
      {
        "title": "Catalog reminder (Lunch)",
        "details": "You forgot to log Your morning meal",
        "icon": Icons.list_alt,
        "image": "assets/icons/diary.png",
        "color": Colors.red
      },
      {
        "title": "Workout reminder (Lunch)",
        "details": "Your workout (Get Up Get Go) will start in 30 min",
        "icon": Icons.calculate,
        "image": "assets/icons/running-person.png",
        "color": Colors.yellow
      },
      {
        "title": "Meal reminder (Lunch)",
        "details": "Your lunch time is about to start at 12:30",
        "icon": Icons.dinner_dining,
        "image": "assets/icons/dinner.png",
        "color": Color(0xffD1DFF8)
      },
      {
        "title": "Catalog reminder (Lunch)",
        "details": "You forgot to log Your morning meal",
        "icon": Icons.list_alt,
        "image": "assets/icons/diary.png",
        "color": Colors.red
      },
      {
        "title": "Workout reminder (Lunch)",
        "details": "Your workout (Get Up Get Go) will start in 30 min",
        "icon": Icons.calculate,
        "image": "assets/icons/running-person.png",
        "color": Colors.yellow
      },
      {
        "title": "Meal reminder (Lunch)",
        "details": "Your lunch time is about to start at 12:30",
        "icon": Icons.dinner_dining,
        "image": "assets/icons/dinner.png",
        "color": Color(0xffD1DFF8)
      },
      {
        "title": "Catalog reminder (Lunch)",
        "details": "You forgot to log Your morning meal",
        "icon": Icons.list_alt,
        "image": "assets/icons/diary.png",
        "color": Colors.red
      },
      {
        "title": "Workout reminder (Lunch)",
        "details": "Your workout (Get Up Get Go) will start in 30 min",
        "icon": Icons.calculate,
        "image": "assets/icons/running-person.png",
        "color": Colors.yellow
      },
    ];
    return Scaffold(
      key: notikey,
      drawer: CustomDrawer(),
      appBar: customAppBar(
        context,
        bellColor: primaryColor,
      ),
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(MySize.size20),
                child: Row(
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: MySize.size14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 14,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: notificationData.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: MySize.size16,
                                top: MySize.size16,
                                bottom: MySize.size16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: MySize.size26,
                                      child: Image.asset(
                                          notificationData[i]["image"]),
                                      backgroundColor: notificationData[i]
                                          ["color"],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MySize.size16,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DDText(
                                        title: notificationData[i]["title"],
                                        size: MySize.size14,
                                        weight: FontWeight.w600,
                                      ),
                                      DDText(
                                        title: notificationData[i]["details"],
                                        size: MySize.size12,
                                      )
                                    ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MySize.size20,
                              right: MySize.size20,
                            ),
                            child: Divider(
                              // color: Colors.grey,
                              thickness: 0.5,
                            ),
                          )
                        ],
                      );
                    }),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("click");
                    Flushbar(
                      backgroundColor: Colors.green,
                      title: "Success",
                      message: "Notification Deleted!!",
                      duration: Duration(seconds: 1),
                    )..show(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Color(0xffdfdfdf),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        FontAwesomeIcons.solidTrashAlt,
                        size: 20,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
