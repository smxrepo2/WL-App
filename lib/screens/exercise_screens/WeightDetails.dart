// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/user_goal_data.dart';
import 'package:weight_loser/models/user_profile_data.dart';
import 'package:weight_loser/screens/exercise_screens/LineChartSyncFusion.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';

// ignore: unused_import
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/add_water_widget.dart';
import 'package:weight_loser/widget/add_weight_widget.dart';

class WeightDetails extends StatefulWidget {
  const WeightDetails({Key key}) : super(key: key);

  @override
  _WeightDetailsState createState() => _WeightDetailsState();
}

class _WeightDetailsState extends State<WeightDetails>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<WeightDetails> {
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;

  bool _isShowDial = false;
  bool _isVisible = false;
  UserDataProvider provider;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];
  int userid;

  @override
  void initState() {
    provider = Provider.of<UserDataProvider>(context, listen: false);
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<Widget>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else if (snapshot.hasError) {
              return Center(
                child: Text('No Internet Connectivity'),
              );
            }
            return loadingView();
          },
        ),
      ),
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
    ).then((value) {
      setState(() {
        fetchData();
      });
    });
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

  Future<Widget> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response =
        await get(Uri.parse('$apiUrl/api/profile/getuser/$userid'));

    if (response.statusCode == 200) {
      UserProfileData userProfileData =
          UserProfileData.fromJson(jsonDecode(response.body));
      print(jsonDecode(response.body));
      if (userProfileData.profileVMs != null) {
        return showData(userProfileData);
      } else {
        return Center(
          child: Text('No Internet Connectivity'),
        );
      }
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  Future<UserGoalData> fetchGraphData() async {
    final response = await get(Uri.parse('$apiUrl/api/history/weight/$userid'));
    if (response.statusCode == 200) {
      UserGoalData userProfileData =
          UserGoalData.fromJson(jsonDecode(response.body));
      return userProfileData;
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  showData(UserProfileData userProfileData) {
    String startingDate = DateFormat('dd/mm/yyyy')
        .format(DateTime.parse(userProfileData.profileVMs.joiningDate));
    String currentDate = DateFormat('dd/mm/yyyy').format(DateTime.now());
    String acheivedStatus;
    if ((userProfileData.profileVMs.currentweight -
            userProfileData.profileVMs.goalWeight) <=
        0) {
      acheivedStatus = "Acheived";
    } else {
      int num = userProfileData.profileVMs.currentweight -
          userProfileData.profileVMs.goalWeight;
      acheivedStatus = "${num.abs()}kg to go";
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MySize.size14, bottom: MySize.size20, top: MySize.size30),
            child: Row(
              children: [
                Text("Weight Tracker"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[100])),
            height: 200,
            child: FutureBuilder<UserGoalData>(
              future: fetchGraphData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data.goals.last);

                  var seen = Set<String>();
                  List<Goals> goals = snapshot.data.goals
                      .where((element) => seen.add(element.createdAt))
                      .toList();
                  return LineChartSyncFusion(
                    goals: goals,
                    goalweight:
                        userProfileData.profileVMs.goalWeight.toDouble(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('No Internet Connectivity'),
                  );
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Container(
                    height: 200,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MySize.size40,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[100])),
            padding: EdgeInsets.all(MySize.size20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: MySize.size14),
                        child: Image.asset("assets/icons/start.png"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DDText(
                            title: "Starting Weight",
                            size: 11,
                          ),
                          DDText(
                            title:
                                "${userProfileData.profileVMs.startWeight.toString()} kg",
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DDText(
                  title: "Taken: $startingDate",
                  size: 11,
                  color: Color(0xff797A7A),
                )
              ],
            ),
          ),
          SizedBox(height: MySize.size20),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[100])),
              padding: EdgeInsets.all(MySize.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: MySize.size14),
                        child: Image.asset("assets/icons/date.png"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DDText(
                            title: "Current Weight",
                            size: 11,
                          ),
                          DDText(
                            title:
                                "${userProfileData.profileVMs.currentweight.toString()} kg",
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  DDText(
                    title: "Today: $currentDate",
                    size: 11,
                    color: Color(0xff797A7A),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MySize.size20),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[100])),
              padding: EdgeInsets.all(MySize.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: MySize.size14,
                        ),
                        child: Image.asset("assets/icons/goal.png"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DDText(
                            title: "Goal Weight",
                            size: 11,
                          ),
                          DDText(
                            title:
                                "${userProfileData.profileVMs.goalWeight.toString()} kg",
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  DDText(
                    title: "$acheivedStatus",
                    size: 11,
                    color: Color(0xff797A7A),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MySize.size14,
                  bottom: MySize.size20,
                  top: MySize.size30),
              child: Row(
                children: const [
                  Text("Weight Tracker"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[100])),
              height: 200,
            ),
            SizedBox(
              height: MySize.size40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[100])),
              padding: EdgeInsets.all(MySize.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: MySize.size14),
                          child: Image.asset("assets/icons/start.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Starting Weight",
                              size: 11,
                            ),
                            DDText(
                              title: "0 kg",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DDText(
                    title: "Taken: 06/24/2021",
                    size: 11,
                    color: Color(0xff797A7A),
                  )
                ],
              ),
            ),
            SizedBox(height: MySize.size20),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[100])),
                padding: EdgeInsets.all(MySize.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: MySize.size14),
                          child: Image.asset("assets/icons/date.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Current Weight",
                              size: 11,
                            ),
                            DDText(
                              title: "50 kg",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    DDText(
                      title: "Today: 06/24/2021",
                      size: 11,
                      color: Color(0xff797A7A),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MySize.size20),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[100])),
                padding: EdgeInsets.all(MySize.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: MySize.size14,
                          ),
                          child: Image.asset("assets/icons/goal.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Goal Weight",
                              size: 11,
                            ),
                            DDText(
                              title: "0 kg",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    DDText(
                      title: "Achieved: 05 kg to go",
                      size: 11,
                      color: Color(0xff797A7A),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
