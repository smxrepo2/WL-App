import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/CoachesList.dart';
import 'package:weight_loser/screens/food_screens/NutritionScreenView.dart';
import 'package:weight_loser/screens/navigation_tabs/DiaryView.dart';
import 'package:weight_loser/screens/navigation_tabs/LiveTracking.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';

class CustomBottomBar extends StatefulWidget {
  int index;
  CustomBottomBar(this.index);
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndexForBottomBar = 0;
  int _selectedIndexForTabBar = 0;

  final List<Widget> _widgetOptions = <Widget>[
    // DashboardScreen(),
    TodayScreen(),
    CoachesList(),
    WatchScreen(),
    NutritionScreenView(),
    DiaryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _selectedIndexForBottomBar == 0
            ? Colors.grey[300]
            : Color(0xff4885ED),
        unselectedItemColor: Colors.grey[300],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _navigateToBottomTab,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              "assets/icons/home.png",
            )),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              "assets/icons/bottombar_1.png",
            )),
            label: 'Coach',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              "assets/icons/bottombar_2.png",
            )),
            label: 'Live Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartBar),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(
              "assets/icons/bottombar_4.png",
            )),
            label: 'Dairy',
          ),
        ]);
  }

  _navigateToBottomTab(int position) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => BottomBarNew(_selectedIndexForBottomBar)),
        (route) => false);
  }
}
