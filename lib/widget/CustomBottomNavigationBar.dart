import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';

class CustomStaticBottomNavigationBar extends StatefulWidget {
  final homeColor, diaryColor, liveTrackingColor, heartColor;
  const CustomStaticBottomNavigationBar(
      {Key key,
      this.homeColor,
      this.diaryColor,
      this.heartColor,
      this.liveTrackingColor})
      : super(key: key);

  @override
  _CustomStaticBottomNavigationBarState createState() =>
      _CustomStaticBottomNavigationBarState();
}

class _CustomStaticBottomNavigationBarState
    extends State<CustomStaticBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      shape: CircularNotchedRectangle(),
      notchMargin: MySize.size10,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MySize.size20),
              topRight: Radius.circular(MySize.size20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: MySize.size2,
              offset: Offset(
                0,
                0,
              ), // Shadow position
            ),
          ],
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MaterialButton(
                minWidth: MySize.size50,
                onPressed: () {
                  setState(
                    () {
                      _navigateToBottomTab(0);
                      // currentScreen = DashboardScreen();
                      // _selectedIndex = 0;
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MySize.size4, left: MySize.size6),
                  child: Image.asset(
                    "assets/icons/home.png",
                    color: BottomBar.currentTabIndex != 0
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                minWidth: MySize.size50,
                onPressed: () {
                  setState(
                    () {
                      _navigateToBottomTab(1);
                      // currentScreen = DashboardScreen();
                      // _selectedIndex = 0;
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MySize.size4, left: MySize.size6),
                  child: Image.asset(
                    "assets/icons/bottombar_1.png",
                    color: BottomBar.currentTabIndex == 1
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                minWidth: MySize.size50,
                onPressed: () {
                  setState(
                    () {
                      _navigateToBottomTab(2);
                      // _selectedIndex = 1;
                      // currentScreen = DiaryView();
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Image.asset(
                    "assets/icons/bottombar_2.png",
                    color: BottomBar.currentTabIndex == 2
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                hoverColor: Colors.transparent,
                minWidth: MySize.size50,
                onPressed: () {
                  setState(
                    () {
                      _navigateToBottomTab(3);
                      // _selectedIndex = 2;
                      // currentScreen = LiveTrackingView();
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Icon(
                    FontAwesomeIcons.chartBar,
                    color: BottomBar.currentTabIndex == 3
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                minWidth: MySize.size50,
                onPressed: () {
                  setState(
                    () {
                      _navigateToBottomTab(4);
                      // currentScreen = FavouriteTabInnerPage();
                      // _selectedIndex = 3;
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Image.asset(
                    "assets/icons/bottombar_4.png",
                    color: BottomBar.currentTabIndex == 4
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToBottomTab(int position) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomBarNew(position)),
        (route) => false);
  }
}
