import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/CoachesList.dart';
import 'package:weight_loser/screens/food_screens/NutritionScreenView.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/screens/navigation_tabs/DashBoardScreen.dart';
import 'package:weight_loser/screens/navigation_tabs/DiaryView.dart';
import 'package:weight_loser/screens/navigation_tabs/LiveTracking.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/add_water_widget.dart';
import 'package:weight_loser/widget/add_weight_widget.dart';

enum ThemeStyle {
  FloatingBar,
  Light,
}

class BottomBar extends StatefulWidget {
  static int currentTabIndex = 0;
  final checkIndex;

  BottomBar(
    this.checkIndex,
  );

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool _isShowDial = false;
  bool _isVisible = false;

  List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    CoachesList(),
    WatchScreen(),
    NutritionScreenView(),
    DiaryView(),
  ];
  int _selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  UserDataProvider provider;
  Widget currentScreen;

  @override
  void initState() {
    provider = Provider.of<UserDataProvider>(context, listen: false);
    super.initState();
    setState(() {
      currentScreen = _widgetOptions[widget.checkIndex];
      _selectedIndex = widget.checkIndex;
      BottomBar.currentTabIndex = widget.checkIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        floatingActionButton:
            _selectedIndex == 3 ? Container() : _getFloatingActionButton(),
        drawer: CustomDrawer(),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(MySize.size56),
        //   child: CustomAppBar(),
        // ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        /*PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),*/
        bottomNavigationBar: bottomNavigationView(),
      ),
    );
  }

// ############################## DIALOG FOR FOOD IN FAB(Floating Action Button) ###########################

  dialogForFood() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(1);
                    Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/breakfast.png"),
                          SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Breakfast",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(2);
                    Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/lunch.png"),
                          SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Lunch",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(3);
                    Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/dinner2.png"),
                          SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Dinner",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(4);
                    Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/snack.png"),
                          SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Snacks",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

// ############################## DIALOG FOR WEIGHT IN FAB(Floating Action Button) ###########################

  dialogForWeight() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, stateSet) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            // contentPadding: EdgeInsets.all(0),
            actions: <Widget>[AddWeightWidget()],
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

// ############################## DIALOG FOR WATER IN FAB(Floating Action Button) ###########################

  dialogForWater() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, stateSet) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            // contentPadding: EdgeInsets.all(0),
            actions: <Widget>[AddWaterWidget()],
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

// ############################ BOTTOM NAVIGATION VIEW #################################

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      isEnableAnimation: true,

      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        _isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          isExtended: true,
          heroTag: "floating_button_menu",
          backgroundColor: primaryColor,
          mini: false,
          autofocus: true,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: primaryColor),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          heroTag: "water",
          mini: true,
          child: Tooltip(
            message: "Water",
            child: Icon(
              Icons.water,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to close menu after click

            setState(() {
              _isVisible = false;
              _isShowDial = false;
              print(_isVisible);
            });
            dialogForWater();
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "exercise",
          mini: true,
          child: Tooltip(
            message: "Exercise",
            child: Icon(
              FontAwesomeIcons.running,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
            setState(() {});
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "food",
          mini: true,
          child: Tooltip(
            message: "Food",
            child: Icon(
              Icons.food_bank,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            setState(() {
              _isVisible = false;
              _isShowDial = false;
              print(_isVisible);
            });
            dialogForFood();
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "weight",
          mini: true,
          child: Tooltip(
            message: "Weight",
            child: Icon(
              Icons.monitor_weight,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            setState(() {
              _isVisible = false;
              _isShowDial = false;
            });

            dialogForWeight();
          },
          backgroundColor: Colors.white,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  BottomAppBar bottomNavigationView() {
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
                      currentScreen = DashboardScreen();
                      _selectedIndex = 0;
                      BottomBar.currentTabIndex = 0;
                      print("index $_selectedIndex");
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MySize.size4, left: MySize.size6),
                  child: Image.asset(
                    "assets/icons/home.png",
                    color: _selectedIndex == 0
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
                      currentScreen = CoachesList();
                      _selectedIndex = 1;
                      BottomBar.currentTabIndex = 1;
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MySize.size4, left: MySize.size6),
                  child: Image.asset(
                    "assets/icons/bottombar_1.png",
                    color: _selectedIndex == 1
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
                      _selectedIndex = 2;
                      BottomBar.currentTabIndex = 2;
                      //currentScreen=LiveTrackingView();
                      currentScreen = WatchScreen();
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Image.asset(
                    "assets/icons/bottombar_2.png",
                    color: _selectedIndex == 2
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
                      BottomBar.currentTabIndex = 3;
                      _selectedIndex = 3;
                      currentScreen = Center(child: NutritionScreenView());
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Icon(
                    FontAwesomeIcons.chartBar,
                    color: _selectedIndex == 3
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
                      currentScreen = DiaryView();
                      _selectedIndex = 4;
                      BottomBar.currentTabIndex = 4;
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: MySize.size4),
                  child: Image.asset(
                    "assets/icons/bottombar_4.png",
                    color: _selectedIndex == 4
                        ? Color(0xff4885ED)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: MaterialButton(
            //     minWidth: MySize.size50,
            //     onPressed: () {
            //       setState(
            //         () {
            //           print("add button pressed");
            //           _selectedIndex = 4;
            //         },
            //       );
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.only(top: MySize.size4),
            //       child: Icon(
            //         FontAwesomeIcons.plusCircle,
            //         size: 45,
            //         color: primaryColor,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(MySize.size8),
            //   child: Container(
            //     width: MySize.size44,
            //     height: MySize.size80,
            //     // decoration: BoxDecoration(
            //     //   color: Color(0xff4885ED),
            //     //   border: Border.all(
            //     //     color: Color(0xff4885ED),
            //     //   ),
            //     //   borderRadius: BorderRadius.all(
            //     //     Radius.circular(MySize.size30),
            //     //   ),
            //     // ),
            //     child: IconButton(
            //       onPressed: () {
            //         print("add pressed");
            //         setState(
            //           () {
            //             _selectedIndex = 4;
            //           },
            //         );
            //       },
            //       icon: Align(
            //         alignment: Alignment.topLeft,
            //         child: Icon(
            //           FontAwesomeIcons.plusCircle,
            //           color: Colors.blue,
            //           size: 50,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
