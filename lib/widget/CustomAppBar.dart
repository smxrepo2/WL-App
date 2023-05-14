import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/screens/NotificationScreen.dart';

import '../screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';

class CustomAppBar extends StatefulWidget {
  final tabBar;
  final elevation;
  final bellColor;
  const CustomAppBar({Key key, this.tabBar, this.elevation, this.bellColor})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // TabBar _tabBar;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: widget.tabBar,
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              child: Image.asset(
                "assets/icons/menuu.png",
                color: Color(0xff797A7A),
              ),
            ),
          );
        },
      ),
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: widget.elevation == null ? 0 : widget.elevation,
      backgroundColor: Colors.white,
      actions: [
        /*
        GestureDetector(
          onTap: () {
            Get.to(() => const FavouriteTabInnerPage());
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 15,
              ),
            ),
          ),
        ),
*/

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Image.asset("assets/icons/heart_my_favourite.png",
                color: widget.bellColor == null ? Colors.red : Colors.red),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavouriteTabInnerPage()));
            },
          ),
        ),
      ],
    );
  }
}
