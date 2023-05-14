import 'package:flutter/material.dart';
import 'package:weight_loser/screens/NotificationScreen.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../constants/constant.dart';

AppBar customAppBar(BuildContext context, {tabBar, elevation, bellColor}) {
  return AppBar(
    bottom: tabBar,
    leading: Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Image.asset(
            ImagePath.menu,
            color: Color(0xff797A7A),
          ),
        );
      },
    ),
    iconTheme: IconThemeData(color: Colors.grey),
    elevation: elevation == null ? 0 : elevation,
    backgroundColor: Colors.white,
    actions: [
      GestureDetector(
        onTap: () {
          print("Notification Key:" + context.widget.key.toString());
          //if (context.widget.key != NotificationScreen().key)
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FavouriteTabInnerPage();
          }));
        },
        child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            )),
      ),
    ],
  );
}

AppBar customBar(BuildContext context, {tabBar, elevation, bellColor}) {
  return AppBar(
    bottom: tabBar,
    leading: Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Row(children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/icons/back_arrow.png')),
        SizedBox(width: 9),
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                ImagePath.menu,
                color: Color(0xff797A7A),
              ),
            );
          },
        )
      ]),
    ),
    iconTheme: IconThemeData(color: Colors.grey),
    elevation: elevation == null ? 0 : elevation,
    backgroundColor: Colors.white,
    actions: [
      GestureDetector(
        onTap: () {
          print("Notification Key:" + context.widget.key.toString());
          //if (context.widget.key != NotificationScreen().key)
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FavouriteTabInnerPage();
          }));
        },
        child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            )),
      ),
    ],
  );
}

AppBar titleAppBar({BuildContext context, String title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        );
      },
    ),
    title: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),
    ),
  );
}
