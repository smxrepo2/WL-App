import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/AuthService.dart';

import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/CoachesList.dart';
import 'package:weight_loser/screens/Daily%20Log/Daily_log.dart';
import 'package:weight_loser/screens/PaymentScreen/paymentScreen.dart';
import 'package:weight_loser/screens/groupExercise/screens/exerciseGroup.dart';
import 'package:weight_loser/screens/navigation_tabs/LiveTracking.dart';
import 'package:weight_loser/watches/screens/connect_watch.dart';
import 'package:weight_loser/screens/SettingScreen/setting_screen.dart';
import 'package:weight_loser/screens/cbt/body.dart';
import 'package:weight_loser/screens/chat/DetailChatScreen.dart';

import 'package:weight_loser/screens/GroceryList.dart';
import 'package:weight_loser/screens/UltimateSelfieView.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/screens/choose_your_plan.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';

import 'package:get/get.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/recipie/views/body.dart';
import 'package:weight_loser/screens/sleep_detail.dart';
import 'package:weight_loser/screens/water_detail.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/test.dart';

import '../screens/dashboardRevised/dashboard_revised.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: MySize.size100),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(MySize.size50),
                    bottomRight: Radius.circular(MySize.size50)),
                child: SizedBox(
                  width: MySize.size220,
                  height: 585,
                  child: Drawer(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ListView(
                            // Important: Remove any padding from the ListView.
                            physics: orientation == Orientation.landscape
                                ? ClampingScrollPhysics()
                                : ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.home,
                                      color: Colors.grey[400],
                                      height: 20,
                                    ),
                                  ),
                                  title: DDText(title: 'Home'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Get.to(() => BottomBarNew(0));
                                  },
                                ),
                              ),
                              /*
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                      padding: EdgeInsets.only(
                                          left: MySize.size4,
                                          top: MySize.size4),
                                      child: Icon(
                                        Icons.dashboard,
                                        color: Colors.grey,
                                      )),
                                  title: DDText(title: 'Dashboard'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Get.to(() => DashboardRevised());
                                    //Get.to(() => UploadScreen());
                                  },
                                ),
                              ),
                              */
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.heart,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Favourites'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Get.to(() => FavouriteTabInnerPage());
                                  },
                                ),
                              ),
                              /*
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.exerciseR,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  
                                  title: DDText(title: 'Group Exercise'),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ExerciseGroup()));
                                  },
                                ),
                              ),
                              */
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.malePerson,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Coaches'),
                                  onTap: () {
                                    Get.to(() => CoachesList());
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.selfie,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Ultimate Selfie'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Get.to(() => UltimateSelfieView());
                                    //Get.to(() => UploadScreen());
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.grocery,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Grocery List'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Get.to(() => GroceryList());
                                  },
                                ),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     //                    <-- BoxDecoration
                              //     border: Border(bottom: BorderSide(color: Colors.grey[300], width: 0.5)),
                              //   ),
                              //   child: ListTile(
                              //     horizontalTitleGap: 3,
                              //     leading: Padding(
                              //       padding: EdgeInsets.only(left: MySize.size4, top: MySize.size4),
                              //       child: Image.asset(
                              //         'assets/icons/custom_food.png',
                              //         color: Colors.grey[400],
                              //       ),
                              //     ),
                              //     title: DDText(title: 'Custom Plans'),
                              //     onTap: () {
                              //       var route = MaterialPageRoute(builder: (context) => CustomPlans());
                              //       Navigator.push(context, route);
                              //     },
                              //   ),
                              // ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     //                    <-- BoxDecoration
                              //     border: Border(
                              //         bottom: BorderSide(
                              //             color: Colors.grey[300], width: 0.5)),
                              //   ),
                              //   child: ListTile(
                              //     horizontalTitleGap: 3,
                              //     leading: Padding(
                              //       padding: EdgeInsets.only(
                              //           left: MySize.size4, top: MySize.size4),
                              //       child: Image.asset(
                              //         'assets/icons/custom_food.png',
                              //         color: Colors.grey[400],
                              //       ),
                              //     ),
                              //     title: DDText(title: 'Custom Food'),
                              //     onTap: () {
                              //       var route = MaterialPageRoute(
                              //           builder: (context) => SearchFood(false));
                              //       Navigator.push(context, route);
                              //     },
                              //   ),
                              // ),
                              /*
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.malePerson,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'CBT'),
                                  onTap: () {
                                    Get.to(() => CBTScreen());
                                  },
                                ),
                              ), */

                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.malePerson,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Technical Support'),
                                  onTap: () {
                                    Get.to(() => DetailChatScreen(
                                          title: "Technical support",
                                        ));
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.3)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size2, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.smallWatch,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Watch'),
                                  onTap: () {
                                    Get.to(() => WatchScreen());
                                  },
                                ),
                              ),
                              /*Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 0.5)),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      'assets/icons/invoice.png',
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Billing'),
                                  onTap: () {
                                    //############ NAVIGATOR ##########
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
                                  },
                                ),
                              ),*/
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.setting,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Settings'),
                                  onTap: () {
                                    Get.to(() =>
                                        SettingScreen(navigateToStory: false));
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return const SettingScreen();
                                    // }));
                                  },
                                ),
                              ),
                              /*
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.setting,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Daily Log'),
                                  onTap: () {
                                    Get.to(() => DailyLog());
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return const SettingScreen();
                                    // }));
                                  },
                                ),
                              ),
                              */
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.sleepR,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'sleep Detail'),
                                  onTap: () {
                                    Get.to(() => SleepDetail());
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return const SettingScreen();
                                    // }));
                                  },
                                ),
                              ),
                              /*
                              Container(
                                decoration: BoxDecoration(
                                  //                    <-- BoxDecoration
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Colors.grey[300],
                                    width: 0.5,
                                  )),
                                ),
                                child: ListTile(
                                  horizontalTitleGap: 3,
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left: MySize.size4, top: MySize.size4),
                                    child: Image.asset(
                                      ImagePath.malePerson,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  title: DDText(title: 'Sleep 2'),
                                  onTap: () {
                                    Get.to(() => MindTabView());
                                  },
                                ),
                              ), */
                              ListTile(
                                horizontalTitleGap: 3,
                                leading: Padding(
                                  padding: EdgeInsets.only(
                                      top: MySize.size4, left: MySize.size2),
                                  child: Image.asset(
                                    ImagePath.waterR,
                                    color: Colors.grey,
                                  ),
                                ),
                                title: DDText(title: 'Water'),
                                onTap: () async {
                                  Get.to(() => WaterDetail());
                                },
                              ),
                              ListTile(
                                horizontalTitleGap: 3,
                                leading: Padding(
                                  padding: EdgeInsets.only(
                                      top: MySize.size4, left: MySize.size2),
                                  child: Image.asset(ImagePath.logOut),
                                ),
                                title: DDText(title: 'Logout'),
                                onTap: () async {
                                  var user = FirebaseAuth.instance;
                                  await AuthService.deleteUserId();
                                  await user.signOut().then((value) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => LoginScreen()));
                                  });

                                  /*
                                  else {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (route) => false);
                                  }*/
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
