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
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/widget/add_water_widget.dart';
import 'package:weight_loser/widget/add_weight_widget.dart';

import '../screens/UltimateSelfieView.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  @override
  FloatingActionButtonWidgetState createState() =>
      FloatingActionButtonWidgetState();
}

class FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  bool _isShowDial = false;
  bool _isVisible = false;
  UserDataProvider provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserDataProvider>(context, listen: false);
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
      floatingActionButtonWidgetChildren: [
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
          heroTag: "selfie",
          mini: true,
          child: Tooltip(
            message: "selfie",
            child: Icon(
              FontAwesomeIcons.camera,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to toggle menu after click

            setState(() {
              _isShowDial = false;
              _isVisible = false;
            });
            Get.to(() => UltimateSelfieView());
            //Get.to(() => BottomBarNew(2));
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
}
