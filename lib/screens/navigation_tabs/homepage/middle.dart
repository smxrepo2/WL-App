import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';

// import 'package:http/http.dart' as http;
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/Controller/DashBoardController.dart';
import 'package:weight_loser/Controller/HomePageData.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Today_api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/constants/notificationsubscription.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/models/food_recipe_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/MoreFoodScreen/AddRestaurantFood.dart';
import 'package:weight_loser/screens/MoreFoodScreen/RestaurentFood.dart';
import 'package:weight_loser/screens/MoreFoodScreen/morefood.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/Shimmer/Food%20Dialog%20Shimmer.dart';
import 'package:weight_loser/widget/Shimmer/HomMiddle_shimmer.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../../notifications/getit.dart';
import '../../maps/restaturant_location.dart';
import '../foodreplacementprov.dart';
import '../replace_food.dart';

class Middle extends StatefulWidget {
  //final List<ActiveFoodPlans> activeFoodPlans;
  Middle({Key key, this.networkConnection, this.replace}) : super(key: key);
  //int choice;
  final bool networkConnection;
  final GlobalKey replace;
  @override
  _MiddleState createState() => _MiddleState();

//HomePageMiddle(this.activeFoodPlans);
}

class _MiddleState extends State<Middle> {
  //   with  AutomaticKeepAliveClientMixin<HomePageMiddle> {
  //
  // @override
  // bool get wantKeepAlive => true;
  double yOffset = 0;

  bool isbfPress = false;
  bool islunchPress = false;
  bool issnackPress = false;
  bool isdinnerPress = false;

  Future<List<dynamic>> _breakFastFuture;
  Future<List<dynamic>> _snackFuture;
  Future<List<dynamic>> _lunchFastFuture;
  Future<List<dynamic>> _dinnerFastFuture;
  List<ActiveFoodPlans> breakfast = [];
  List<ActiveFoodPlans> lunch = [];
  List<ActiveFoodPlans> dinner = [];
  List<ActiveFoodPlans> snack = [];
  int itemsOfbf = 0;
  int itemsOfdinner = 0;
  int itemsOflunch = 0;
  int itemsOfsnack = 0;
  int userid;
  int bfbuttonCount = 0;
  int lunchbuttonCount = 0;
  int dinnerbuttonCount = 0;
  int snackbuttonCount = 0;
  int flag = 0;
  TabController _controller;
  int selectedTab;
  //bool networkConnection = false;

  @override
  void initState() {
    super.initState();
    //var _foodProvider = getit<replacementnotiprovider>();
    //selectedTab = _foodProvider.getData();
    //if (selectedTab == null) selectedTab = 0;
    //buttonCount = widget.choice;
    _breakFastFuture = fetchTodayDiet("breakfast");
    //_breakFastFuture1 = fetchTodayFoodSuggestion("breakfast", flag);
    _snackFuture = fetchTodayDiet("snacks");
    //_snackFuture1 = fetchTodayFoodSuggestion("snack", flag);
    _lunchFastFuture = fetchTodayDiet("lunch");
    //_lunchFastFuture1 = fetchTodayFoodSuggestion("lunch", flag);
    _dinnerFastFuture = fetchTodayDiet("dinner");
    //_dinnerFastFuture1 = fetchTodayFoodSuggestion("dinner", flag);
    fetchActivePlans();
    print("initiating middle");
/*
    var subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          networkConnection = true;
          print("internet connectivity:$networkConnection");
        });
      } else {
        setState(() {
          networkConnection = false;
          print("internet connectivity:$networkConnection");
        });
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    // double height =
    //     MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double heightOfTabBar = MediaQuery.of(context).size.height * 0.04;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    //print("Button $buttonCount");
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: orientation == Orientation.landscape
                          ? 20
                          : heightOfTabBar,
                      child: TabBar(
                        controller: _controller,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.2, color: Colors.blue),
                          ),
                        ),
                        /*indicator:  UnderlineTabIndicator(
                        borderSide: BorderSide(width: 0.0,color: Colors.white),
                        insets: EdgeInsets.symmetric(horizontal:16.0)
                    ),*/
                        labelColor: Colors.blue,
                        labelStyle: GoogleFonts.openSans(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        unselectedLabelColor: Colors.grey,
                        onTap: (val) {
                          if (val == 0) {
                            fetchMealLodgedStatus("breakfast");
                          } else if (val == 1) {
                            fetchMealLodgedStatus("snack");
                          } else if (val == 2) {
                            fetchMealLodgedStatus("lunch");
                          } else if (val == 3) {
                            fetchMealLodgedStatus("dinner");
                          }
                        },
                        tabs: [
                          Tab(text: 'Breakfast'),
                          Tab(text: 'Snacks'),
                          Tab(text: 'Lunch'),
                          Tab(text: 'Dinner'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MySize.size22, right: MySize.size28),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // color: Colors.red,
                      width: orientation == Orientation.portrait
                          ? double.infinity
                          : 485,
                      height: MySize.size240,
                      child: TabBarView(
                        // controller: _controller,
                        children: <Widget>[
                          ///Breakfast tab
                          isbfPress == false
                              ? FutureBuilder(
                                  future: widget.networkConnection
                                      ? _breakFastFuture
                                      : offlinefetchTodayDiet("breakfast"),
                                  builder: (context,
                                      AsyncSnapshot<List<dynamic>> snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      var _breakFast = snapshot.data;

                                      if (itemsOfbf >= _breakFast.length) {
                                        itemsOfbf = 0;
                                      }
                                      //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
                                      var _fourItems = _breakFast.toList();
                                      return Container(
                                        width:
                                            orientation == Orientation.portrait
                                                ? 300
                                                : 300,
                                        padding: EdgeInsets.only(
                                          top: MySize.size30,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: MySize.size4,
                                                  left: MySize.size6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (_fourItems.length >= 1)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[0]['FoodId'],
                                                        _fourItems[0]['Name'],
                                                        _fourItems[0]
                                                            ['ServingSize'],
                                                        _fourItems[0]
                                                            ['Calories'],
                                                        _fourItems[0]['Carbs'],
                                                        _fourItems[0]['fat'],
                                                        _fourItems[0]
                                                            ['Protein'],
                                                        _fourItems[0]
                                                            ['Description'],
                                                        _fourItems[0]
                                                            ["Procedure"],
                                                        '$imageBaseUrl${_fourItems[0]['FoodImage']}',
                                                        1,
                                                        0,
                                                        _fourItems[0]
                                                            ['Cuisine'],
                                                        _fourItems[0]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 2)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[1]['FoodId'],
                                                        _fourItems[1]['Name'],
                                                        _fourItems[1]
                                                            ['ServingSize'],
                                                        _fourItems[1]
                                                            ['Calories'],
                                                        _fourItems[1]['Carbs'],
                                                        _fourItems[1]['fat'],
                                                        _fourItems[1]
                                                            ['Protein'],
                                                        _fourItems[1]
                                                            ['Description'],
                                                        _fourItems[1]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[1]['FoodImage']}',
                                                        1,
                                                        0,
                                                        _fourItems[1]
                                                            ['Cuisine'],
                                                        _fourItems[1]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            addFoodDivider(
                                              1,
                                              "breakfast",
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MySize.size10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (_fourItems.length >= 3)
                                                    itemRight(
                                                        context,
                                                        _fourItems[2]['FoodId'],
                                                        _fourItems[2]['Name'],
                                                        _fourItems[2]
                                                            ['ServingSize'],
                                                        _fourItems[2]
                                                            ['Calories'],
                                                        _fourItems[2]['Carbs'],
                                                        _fourItems[2]['fat'],
                                                        _fourItems[2]
                                                            ['Protein'],
                                                        _fourItems[2]
                                                            ['Description'],
                                                        _fourItems[2]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[2]['FoodImage']}',
                                                        1,
                                                        0,
                                                        _fourItems[2]
                                                            ['Cuisine'],
                                                        _fourItems[2]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 4)
                                                    itemRight(
                                                        context,
                                                        _fourItems[3]['FoodId'],
                                                        _fourItems[3]['Name'],
                                                        _fourItems[3]
                                                            ['ServingSize'],
                                                        _fourItems[3]
                                                            ['Calories'],
                                                        _fourItems[3]['Carbs'],
                                                        _fourItems[3]['fat'],
                                                        _fourItems[3]
                                                            ['Protein'],
                                                        _fourItems[3]
                                                            ['Description'],
                                                        _fourItems[3]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[3]['FoodImage']}',
                                                        1,
                                                        0,
                                                        _fourItems[3]
                                                            ['Cuisine'],
                                                        _fourItems[3]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return HomeMiddleShimmer();
                                    }
                                    return isbfPress == false
                                        ? DefaultHomeData(context)
                                        : breakfastSuggestion();
                                  })
                              : breakfastSuggestion(),

                          /// Snacks View
                          issnackPress == false
                              ? FutureBuilder(
                                  future: widget.networkConnection
                                      ? _snackFuture
                                      : offlinefetchTodayDiet("snacks"),
                                  builder: (context,
                                      AsyncSnapshot<List<dynamic>> snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      var _breakFast = snapshot.data;
                                      if (itemsOfsnack >= _breakFast.length) {
                                        itemsOfsnack = 0;
                                      }
                                      //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
                                      var _fourItems = _breakFast.toList();
                                      return Container(
                                        padding: EdgeInsets.only(
                                          top: MySize.size30,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: MySize.size4,
                                                  left: MySize.size6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (_fourItems.length >= 1)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[0]['FoodId'],
                                                        _fourItems[0]['Name'],
                                                        _fourItems[0]
                                                            ['ServingSize'],
                                                        _fourItems[0]
                                                            ['Calories'],
                                                        _fourItems[0]['Carbs'],
                                                        _fourItems[0]['fat'],
                                                        _fourItems[0]
                                                            ['Protein'],
                                                        _fourItems[0]
                                                            ['Description'],
                                                        _fourItems[0]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[0]['FoodImage']}',
                                                        4,
                                                        1,
                                                        _fourItems[0]
                                                            ['Cuisine'],
                                                        _fourItems[0]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 2)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[1]['FoodId'],
                                                        _fourItems[1]['Name'],
                                                        _fourItems[1]
                                                            ['ServingSize'],
                                                        _fourItems[1]
                                                            ['Calories'],
                                                        _fourItems[1]['Carbs'],
                                                        _fourItems[1]['fat'],
                                                        _fourItems[1]
                                                            ['Protein'],
                                                        _fourItems[1]
                                                            ['Description'],
                                                        _fourItems[1]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[1]['FoodImage']}',
                                                        4,
                                                        1,
                                                        _fourItems[1]
                                                            ['Cuisine'],
                                                        _fourItems[1]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            addFoodDivider(
                                              4,
                                              "snack",
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MySize.size16,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (_fourItems.length >= 3)
                                                    itemRight(
                                                        context,
                                                        _fourItems[2]['FoodId'],
                                                        _fourItems[2]['Name'],
                                                        _fourItems[2]
                                                            ['ServingSize'],
                                                        _fourItems[2]
                                                            ['Calories'],
                                                        _fourItems[2]['Carbs'],
                                                        _fourItems[2]['fat'],
                                                        _fourItems[2]
                                                            ['Protein'],
                                                        _fourItems[2]
                                                            ['Description'],
                                                        _fourItems[2]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[2]['FoodImage']}',
                                                        4,
                                                        1,
                                                        _fourItems[2]
                                                            ['Cuisine'],
                                                        _fourItems[2]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 4)
                                                    itemRight(
                                                        context,
                                                        _fourItems[3]['FoodId'],
                                                        _fourItems[3]['Name'],
                                                        _fourItems[3]
                                                            ['ServingSize'],
                                                        _fourItems[3]
                                                            ['Calories'],
                                                        _fourItems[3]['Carbs'],
                                                        _fourItems[3]['fat'],
                                                        _fourItems[3]
                                                            ['Protein'],
                                                        _fourItems[3]
                                                            ['Description'],
                                                        _fourItems[3]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[3]['FoodImage']}',
                                                        4,
                                                        1,
                                                        _fourItems[3]
                                                            ['Cuisine'],
                                                        _fourItems[3]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return HomeMiddleShimmer();
                                    }
                                    return issnackPress == false
                                        ? DefaultHomeData(context)
                                        : SnackSuggestion();
                                  })
                              : SnackSuggestion(),

                          ///Lunch tab
                          islunchPress == false
                              ? FutureBuilder(
                                  future: widget.networkConnection
                                      ? _lunchFastFuture
                                      : offlinefetchTodayDiet("lunch"),
                                  builder: (context,
                                      AsyncSnapshot<List<dynamic>> snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      var _breakFast = snapshot.data;
                                      if (itemsOflunch >= _breakFast.length) {
                                        itemsOflunch = 0;
                                      }
                                      //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
                                      var _fourItems = _breakFast.toList();
                                      return Container(
                                        padding: EdgeInsets.only(
                                          top: MySize.size30,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: MySize.size4,
                                                  left: MySize.size6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (_fourItems.length >= 1)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[0]['FoodId'],
                                                        _fourItems[0]['Name'],
                                                        _fourItems[0]
                                                            ['ServingSize'],
                                                        _fourItems[0]
                                                            ['Calories'],
                                                        _fourItems[0]['Carbs'],
                                                        _fourItems[0]['fat'],
                                                        _fourItems[0]
                                                            ['Protein'],
                                                        _fourItems[0]
                                                            ['Description'],
                                                        _fourItems[0]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[0]['FoodImage']}',
                                                        2,
                                                        2,
                                                        _fourItems[0]
                                                            ['Cuisine'],
                                                        _fourItems[0]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 2)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[1]['FoodId'],
                                                        _fourItems[1]['Name'],
                                                        _fourItems[1]
                                                            ['ServingSize'],
                                                        _fourItems[1]
                                                            ['Calories'],
                                                        _fourItems[1]['Carbs'],
                                                        _fourItems[1]['fat'],
                                                        _fourItems[1]
                                                            ['Protein'],
                                                        _fourItems[1]
                                                            ['Description'],
                                                        _fourItems[1]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[1]['FoodImage']}',
                                                        2,
                                                        2,
                                                        _fourItems[1]
                                                            ['Cuisine'],
                                                        _fourItems[1]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            addFoodDivider(
                                              2,
                                              "lunch",
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MySize.size16,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (_fourItems.length >= 3)
                                                    itemRight(
                                                        context,
                                                        _fourItems[2]['FoodId'],
                                                        _fourItems[2]['Name'],
                                                        _fourItems[2]
                                                            ['ServingSize'],
                                                        _fourItems[2]
                                                            ['Calories'],
                                                        _fourItems[2]['Carbs'],
                                                        _fourItems[2]['fat'],
                                                        _fourItems[2]
                                                            ['Protein'],
                                                        _fourItems[2]
                                                            ['Description'],
                                                        _fourItems[2]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[2]['FoodImage']}',
                                                        2,
                                                        2,
                                                        _fourItems[2]
                                                            ['Cuisine'],
                                                        _fourItems[2]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 4)
                                                    itemRight(
                                                        context,
                                                        _fourItems[3]['FoodId'],
                                                        _fourItems[3]['Name'],
                                                        _fourItems[3]
                                                            ['ServingSize'],
                                                        _fourItems[3]
                                                            ['Calories'],
                                                        _fourItems[3]['Carbs'],
                                                        _fourItems[3]['fat'],
                                                        _fourItems[3]
                                                            ['Protein'],
                                                        _fourItems[3]
                                                            ['Description'],
                                                        _fourItems[3]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[3]['FoodImage']}',
                                                        2,
                                                        2,
                                                        _fourItems[3]
                                                            ['Cuisine'],
                                                        _fourItems[3]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return HomeMiddleShimmer();
                                    }
                                    return islunchPress == false
                                        ? DefaultHomeData(context)
                                        : LunchSuggestion();
                                  })
                              : LunchSuggestion(),

                          ///Dinner tab
                          isdinnerPress == false
                              ? FutureBuilder(
                                  future: widget.networkConnection
                                      ? _dinnerFastFuture
                                      : offlinefetchTodayDiet("dinner"),
                                  builder: (context,
                                      AsyncSnapshot<List<dynamic>> snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      var _breakFast = snapshot.data;
                                      if (itemsOfdinner >= _breakFast.length) {
                                        itemsOfdinner = 0;
                                      }
                                      //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
                                      var _fourItems = _breakFast.toList();
                                      return Container(
                                        padding: EdgeInsets.only(
                                          top: MySize.size30,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: MySize.size4,
                                                  left: MySize.size6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (_fourItems.length >= 1)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[0]['FoodId'],
                                                        _fourItems[0]['Name'],
                                                        _fourItems[0]
                                                            ['ServingSize'],
                                                        _fourItems[0]
                                                            ['Calories'],
                                                        _fourItems[0]['Carbs'],
                                                        _fourItems[0]['fat'],
                                                        _fourItems[0]
                                                            ['Protein'],
                                                        _fourItems[0]
                                                            ['Description'],
                                                        _fourItems[0]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[0]['FoodImage']}',
                                                        3,
                                                        3,
                                                        _fourItems[0]
                                                            ['Cuisine'],
                                                        _fourItems[0]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 2)
                                                    itemLeft(
                                                        context,
                                                        _fourItems[1]['FoodId'],
                                                        _fourItems[1]['Name'],
                                                        _fourItems[1]
                                                            ['ServingSize'],
                                                        _fourItems[1]
                                                            ['Calories'],
                                                        _fourItems[1]['Carbs'],
                                                        _fourItems[1]['fat'],
                                                        _fourItems[1]
                                                            ['Protein'],
                                                        _fourItems[1]
                                                            ['Description'],
                                                        _fourItems[1]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[1]['FoodImage']}',
                                                        3,
                                                        3,
                                                        _fourItems[1]
                                                            ['Cuisine'],
                                                        _fourItems[1]['PlanId'],
                                                        yOffset)
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterLeft(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            addFoodDivider(
                                              3,
                                              "dinner",
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MySize.size16,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (_fourItems.length >= 3)
                                                    itemRight(
                                                        context,
                                                        _fourItems[2]['FoodId'],
                                                        _fourItems[2]['Name'],
                                                        _fourItems[2]
                                                            ['ServingSize'],
                                                        _fourItems[2]
                                                            ['Calories'],
                                                        _fourItems[2]['Carbs'],
                                                        _fourItems[2]['fat'],
                                                        _fourItems[2]
                                                            ['Protein'],
                                                        _fourItems[2]
                                                            ['Description'],
                                                        _fourItems[2]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[2]['FoodImage']}',
                                                        3,
                                                        3,
                                                        _fourItems[2]
                                                            ['Cuisine'],
                                                        _fourItems[2]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                  SizedBox(
                                                    height: MySize.size10,
                                                  ),
                                                  if (_fourItems.length >= 4)
                                                    itemRight(
                                                        context,
                                                        _fourItems[3]['FoodId'],
                                                        _fourItems[3]['Name'],
                                                        _fourItems[3]
                                                            ['ServingSize'],
                                                        _fourItems[3]
                                                            ['Calories'],
                                                        _fourItems[3]['Carbs'],
                                                        _fourItems[3]['fat'],
                                                        _fourItems[3]
                                                            ['Protein'],
                                                        _fourItems[3]
                                                            ['Description'],
                                                        _fourItems[3]
                                                            ['Procedure'],
                                                        '$imageBaseUrl${_fourItems[3]['FoodImage']}',
                                                        3,
                                                        3,
                                                        _fourItems[3]
                                                            ['Cuisine'],
                                                        _fourItems[3]['PlanId'])
                                                  else
                                                    GestureDetector(
                                                      onTap: () {
                                                        WaterDialog(context);
                                                      },
                                                      child: waterRight(
                                                          ImagePath.glass,
                                                          "Water",
                                                          "",
                                                          "Add",
                                                          context),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                      return HomeMiddleShimmer();
                                    }
                                    return isdinnerPress == false
                                        ? DefaultHomeData(context)
                                        : DinnerSuggestion();
                                  })
                              : DinnerSuggestion()
                        ],
                      ),
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

  FutureBuilder<List<dynamic>> DinnerSuggestion() {
    return FutureBuilder(
        future: fetchTodayFoodSuggestion("dinner", dinnerbuttonCount),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var _breakFast = snapshot.data;
            if (itemsOfdinner >= _breakFast.length) {
              itemsOfdinner = 0;
            }

            //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
            var _fourItems = _breakFast;
            return Container(
              padding: EdgeInsets.only(
                top: MySize.size30,
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive1.isMobile(context) ? null : 336,
                    padding: EdgeInsets.only(
                        right: MySize.size4, left: MySize.size6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_fourItems.length >= 1)
                          foodItemLeft(
                              context,
                              _fourItems[0]['FoodId'],
                              _fourItems[0]['Ingredients'],
                              _fourItems[0]['Name'],
                              _fourItems[0]['ServingSize'],
                              _fourItems[0]['Calories'],
                              _fourItems[0]['Carbs'],
                              _fourItems[0]['fat'],
                              _fourItems[0]['Protein'],
                              _fourItems[0]['Description'],
                              _fourItems[0]['Procedure'],
                              '$imageBaseUrl${_fourItems[0]['FileName']}',
                              3,
                              3,
                              _fourItems[0]['Cuisine'],
                              _fourItems[0]['PlanId'],
                              yOffset,
                              isdinnerPress, () {
                            print("Reload Previous");
                            setState(() {
                              isdinnerPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 2)
                          foodItemLeft(
                              context,
                              _fourItems[1]['FoodId'],
                              _fourItems[1]['Ingredients'],
                              _fourItems[1]['Name'],
                              _fourItems[1]['ServingSize'],
                              _fourItems[1]['Calories'],
                              _fourItems[1]['Carbs'],
                              _fourItems[1]['fat'],
                              _fourItems[1]['Protein'],
                              _fourItems[1]['Description'],
                              _fourItems[1]['Procedure'],
                              '$imageBaseUrl${_fourItems[1]['FileName']}',
                              3,
                              3,
                              _fourItems[1]['Cuisine'],
                              _fourItems[1]['PlanId'],
                              yOffset,
                              isdinnerPress, () {
                            print("Reload Previous");
                            setState(() {
                              isdinnerPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                  addFoodDivider(
                    3,
                    "dinner",
                  ),
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                      left: MySize.size16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_fourItems.length >= 3)
                          foodItemRight(
                              context,
                              _fourItems[2]['FoodId'],
                              _fourItems[2]['Ingredients'],
                              _fourItems[2]['Name'],
                              _fourItems[2]['ServingSize'],
                              _fourItems[2]['Calories'],
                              _fourItems[2]['Carbs'],
                              _fourItems[2]['fat'],
                              _fourItems[2]['Protein'],
                              _fourItems[2]['Description'],
                              _fourItems[2]['Procedure'],
                              '$imageBaseUrl${_fourItems[2]['FileName']}',
                              3,
                              3,
                              _fourItems[2]['Cuisine'],
                              _fourItems[2]['PlanId'],
                              isdinnerPress, () {
                            print("Reload Previous");
                            setState(() {
                              isdinnerPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 4)
                          foodItemRight(
                              context,
                              _fourItems[3]['FoodId'],
                              _fourItems[3]['Ingredients'],
                              _fourItems[3]['Name'],
                              _fourItems[3]['ServingSize'],
                              _fourItems[3]['Calories'],
                              _fourItems[3]['Carbs'],
                              _fourItems[3]['fat'],
                              _fourItems[3]['Protein'],
                              _fourItems[3]['Description'],
                              _fourItems[3]['Procedure'],
                              '$imageBaseUrl${_fourItems[3]['FileName']}',
                              3,
                              3,
                              _fourItems[3]['Cuisine'],
                              _fourItems[3]['PlanId'],
                              isdinnerPress, () {
                            print("Reload Previous");
                            setState(() {
                              isdinnerPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return HomeMiddleShimmer();
          } else {
            return DefaultHomeData(context);
          }
        });
  }

  FutureBuilder<List<dynamic>> LunchSuggestion() {
    return FutureBuilder(
        future: fetchTodayFoodSuggestion("lunch", lunchbuttonCount),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var _breakFast = snapshot.data;
            if (itemsOflunch >= _breakFast.length) {
              itemsOflunch = 0;
            }
            // var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
            var _fourItems = _breakFast;
            return Container(
              padding: EdgeInsets.only(
                top: MySize.size30,
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                        right: MySize.size4, left: MySize.size6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_fourItems.length >= 1)
                          foodItemLeft(
                              context,
                              _fourItems[0]['FoodId'],
                              _fourItems[0]['Ingredients'],
                              _fourItems[0]['Name'],
                              _fourItems[0]['ServingSize'],
                              _fourItems[0]['Calories'],
                              _fourItems[0]['Carbs'],
                              _fourItems[0]['fat'],
                              _fourItems[0]['Protein'],
                              _fourItems[0]['Description'],
                              _fourItems[0]['Procedure'],
                              '$imageBaseUrl${_fourItems[0]['FileName']}',
                              2,
                              2,
                              _fourItems[0]['Cuisine'],
                              _fourItems[0]['PlanId'],
                              yOffset,
                              islunchPress, () {
                            print("Reload Previous");
                            setState(() {
                              islunchPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 2)
                          foodItemLeft(
                              context,
                              _fourItems[1]['FoodId'],
                              _fourItems[1]['Ingredients'],
                              _fourItems[1]['Name'],
                              _fourItems[1]['ServingSize'],
                              _fourItems[1]['Calories'],
                              _fourItems[1]['Carbs'],
                              _fourItems[1]['fat'],
                              _fourItems[1]['Protein'],
                              _fourItems[1]['Description'],
                              _fourItems[1]['Procedure'],
                              '$imageBaseUrl${_fourItems[1]['FileName']}',
                              2,
                              2,
                              _fourItems[1]['Cuisine'],
                              _fourItems[1]['PlanId'],
                              yOffset,
                              islunchPress, () {
                            print("Reload Previous");
                            setState(() {
                              islunchPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                  addFoodDivider(
                    2,
                    "lunch",
                  ),
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                      left: MySize.size16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_fourItems.length >= 3)
                          foodItemRight(
                              context,
                              _fourItems[2]['FoodId'],
                              _fourItems[2]['Ingredients'],
                              _fourItems[2]['Name'],
                              _fourItems[2]['ServingSize'],
                              _fourItems[2]['Calories'],
                              _fourItems[2]['Carbs'],
                              _fourItems[2]['fat'],
                              _fourItems[2]['Protein'],
                              _fourItems[2]['Description'],
                              _fourItems[2]['Procedure'],
                              '$imageBaseUrl${_fourItems[2]['FileName']}',
                              2,
                              2,
                              _fourItems[2]['Cuisine'],
                              _fourItems[2]['PlanId'],
                              islunchPress, () {
                            print("Reload Previous");
                            setState(() {
                              islunchPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 4)
                          foodItemRight(
                              context,
                              _fourItems[3]['FoodId'],
                              _fourItems[3]['Ingredients'],
                              _fourItems[3]['Name'],
                              _fourItems[3]['ServingSize'],
                              _fourItems[3]['Calories'],
                              _fourItems[3]['Carbs'],
                              _fourItems[3]['fat'],
                              _fourItems[3]['Protein'],
                              _fourItems[3]['Description'],
                              _fourItems[3]['Procedure'],
                              '$imageBaseUrl${_fourItems[3]['FileName']}',
                              2,
                              2,
                              _fourItems[3]['Cuisine'],
                              _fourItems[3]['PlanId'],
                              islunchPress, () {
                            print("Reload Previous");
                            setState(() {
                              islunchPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {},
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return HomeMiddleShimmer();
          } else {
            return DefaultHomeData(context);
          }
        });
  }

  FutureBuilder<List<dynamic>> SnackSuggestion() {
    return FutureBuilder(
        future: fetchTodayFoodSuggestion("snacks", snackbuttonCount),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var _breakFast = snapshot.data;
            if (itemsOfsnack >= _breakFast.length) {
              itemsOfsnack = 0;
            }
            //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
            var _fourItems = _breakFast;
            return Container(
              padding: EdgeInsets.only(
                top: MySize.size30,
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                        right: MySize.size4, left: MySize.size6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_fourItems.length >= 1)
                          foodItemLeft(
                              context,
                              _fourItems[0]['FoodId'],
                              _fourItems[0]['Ingredients'],
                              _fourItems[0]['Name'],
                              _fourItems[0]['ServingSize'],
                              _fourItems[0]['Calories'],
                              _fourItems[0]['Carbs'],
                              _fourItems[0]['fat'],
                              _fourItems[0]['Protein'],
                              _fourItems[0]['Description'],
                              _fourItems[0]['Procedure'],
                              '$imageBaseUrl${_fourItems[0]['FileName']}',
                              4,
                              1,
                              _fourItems[0]['Cuisine'],
                              _fourItems[0]['PlanId'],
                              yOffset,
                              issnackPress, () {
                            print("Reload Previous");
                            setState(() {
                              issnackPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 2)
                          foodItemLeft(
                              context,
                              _fourItems[1]['FoodId'],
                              _fourItems[1]['Ingredients'],
                              _fourItems[1]['Name'],
                              _fourItems[1]['ServingSize'],
                              _fourItems[1]['Calories'],
                              _fourItems[1]['Carbs'],
                              _fourItems[1]['fat'],
                              _fourItems[1]['Protein'],
                              _fourItems[1]['Description'],
                              _fourItems[1]['Procedure'],
                              '$imageBaseUrl${_fourItems[1]['FileName']}',
                              4,
                              1,
                              _fourItems[1]['Cuisine'],
                              _fourItems[1]['PlanId'],
                              yOffset,
                              issnackPress, () {
                            print("Reload Previous");
                            setState(() {
                              issnackPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                  addFoodDivider(
                    4,
                    "snack",
                  ),
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                      left: MySize.size16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_fourItems.length >= 3)
                          foodItemRight(
                              context,
                              _fourItems[2]['FoodId'],
                              _fourItems[2]['Ingredients'],
                              _fourItems[2]['Name'],
                              _fourItems[2]['ServingSize'],
                              _fourItems[2]['Calories'],
                              _fourItems[2]['Carbs'],
                              _fourItems[2]['fat'],
                              _fourItems[2]['Protein'],
                              _fourItems[2]['Description'],
                              _fourItems[2]['Procedure'],
                              '$imageBaseUrl${_fourItems[2]['FileName']}',
                              4,
                              1,
                              _fourItems[2]['Cuisine'],
                              _fourItems[2]['PlanId'],
                              issnackPress, () {
                            print("Reload Previous");
                            setState(() {
                              issnackPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 4)
                          foodItemRight(
                              context,
                              _fourItems[3]['FoodId'],
                              _fourItems[3]['Ingredients'],
                              _fourItems[3]['Name'],
                              _fourItems[3]['ServingSize'],
                              _fourItems[3]['Calories'],
                              _fourItems[3]['Carbs'],
                              _fourItems[3]['fat'],
                              _fourItems[3]['Protein'],
                              _fourItems[3]['Description'],
                              _fourItems[3]['Procedure'],
                              '$imageBaseUrl${_fourItems[3]['FileName']}',
                              4,
                              1,
                              _fourItems[3]['Cuisine'],
                              _fourItems[3]['PlanId'],
                              issnackPress, () {
                            print("Reload Previous");
                            setState(() {
                              issnackPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return HomeMiddleShimmer();
          } else {
            return DefaultHomeData(context);
          }
        });
  }

  Container DefaultHomeData(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size30,
      ),
      child: Row(
        children: [
          Container(
            width: Responsive1.isDesktop(context) ? 300 : null,
            padding: EdgeInsets.only(right: MySize.size4, left: MySize.size6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    WaterDialog(context);
                  },
                  child:
                      waterLeft(ImagePath.glass, "Water", "", "Add", context),
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                GestureDetector(
                  onTap: () {
                    WaterDialog(context);
                  },
                  child:
                      waterLeft(ImagePath.glass, "Water", "", "Add", context),
                ),
              ],
            ),
          ),
          addFoodDivider(
            1,
            "Breakfast",
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    WaterDialog(context);
                  },
                  child:
                      waterRight(ImagePath.glass, "Water", "", "Add", context),
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                GestureDetector(
                  onTap: () {
                    WaterDialog(context);
                  },
                  child:
                      waterRight(ImagePath.glass, "Water", "", "Add", context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<dynamic>> breakfastSuggestion() {
    return FutureBuilder(
        future: fetchTodayFoodSuggestion("breakfast", bfbuttonCount),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print("Tapped for suggesstions  $bfbuttonCount");
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var _breakFast = snapshot.data;
            if (itemsOfbf >= _breakFast.length) {
              itemsOfbf = 0;
            }
            //var _fourItems = _breakFast.getRange(itemsOf, (itemsOf + 4)).toList();
            var _fourItems = _breakFast;
            print("fourItems:" + _fourItems.toString());
            return Container(
              padding: EdgeInsets.only(
                top: MySize.size30,
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                        right: MySize.size4, left: MySize.size6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_fourItems.length >= 1)
                          foodItemLeft(
                              context,
                              _fourItems[0]['FoodId'],
                              _fourItems[0]['Ingredients'],
                              _fourItems[0]['Name'],
                              _fourItems[0]['ServingSize'],
                              _fourItems[0]['Calories'],
                              _fourItems[0]['Carbs'],
                              _fourItems[0]['fat'],
                              _fourItems[0]['Protein'],
                              _fourItems[0]['Description'],
                              _fourItems[0]['Procedure'],
                              '$imageBaseUrl${_fourItems[0]['FileName']}',
                              1,
                              0,
                              _fourItems[0]['Cuisine'],
                              _fourItems[0]['PlanId'],
                              yOffset,
                              isbfPress, () {
                            print("Reload Previous");
                            setState(() {
                              isbfPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 2)
                          foodItemLeft(
                              context,
                              _fourItems[1]['FoodId'],
                              _fourItems[1]['Ingredients'],
                              _fourItems[1]['Name'],
                              _fourItems[1]['ServingSize'],
                              _fourItems[1]['Calories'],
                              _fourItems[1]['Carbs'],
                              _fourItems[1]['fat'],
                              _fourItems[1]['Protein'],
                              _fourItems[1]['Description'],
                              _fourItems[1]['Procedure'],
                              '$imageBaseUrl${_fourItems[1]['FileName']}',
                              1,
                              0,
                              _fourItems[1]['Cuisine'],
                              _fourItems[1]['PlanId'],
                              yOffset,
                              isbfPress, () {
                            print("Reload Previous");
                            setState(() {
                              isbfPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterLeft(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                  addFoodDivider(
                    1,
                    "breakfast",
                  ),
                  Container(
                    width: Responsive1.isMobile(context) ? null : 300,
                    padding: EdgeInsets.only(
                      left: MySize.size16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_fourItems.length >= 3)
                          foodItemRight(
                              context,
                              _fourItems[2]['FoodId'],
                              _fourItems[2]['Ingredients'],
                              _fourItems[2]['Name'],
                              _fourItems[2]['ServingSize'],
                              _fourItems[2]['Calories'],
                              _fourItems[2]['Carbs'],
                              _fourItems[2]['fat'],
                              _fourItems[2]['Protein'],
                              _fourItems[2]['Description'],
                              _fourItems[2]['Procedure'],
                              '$imageBaseUrl${_fourItems[2]['FileName']}',
                              1,
                              0,
                              _fourItems[2]['Cuisine'],
                              _fourItems[2]['PlanId'],
                              isbfPress, () {
                            print("Reload Previous");
                            setState(() {
                              isbfPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        if (_fourItems.length >= 4)
                          foodItemRight(
                              context,
                              _fourItems[3]['FoodId'],
                              _fourItems[3]['Ingredients'],
                              _fourItems[3]['Name'],
                              _fourItems[3]['ServingSize'],
                              _fourItems[3]['Calories'],
                              _fourItems[3]['Carbs'],
                              _fourItems[3]['fat'],
                              _fourItems[3]['Protein'],
                              _fourItems[3]['Description'],
                              _fourItems[3]['Procedure'],
                              '$imageBaseUrl${_fourItems[3]['FileName']}',
                              1,
                              0,
                              _fourItems[3]['Cuisine'],
                              _fourItems[3]['PlanId'],
                              isbfPress, () {
                            print("Reload Previous");
                            setState(() {
                              isbfPress = false;
                            });
                          })
                        else
                          GestureDetector(
                            onTap: () {
                              WaterDialog(context);
                            },
                            child: waterRight(
                                ImagePath.glass, "Water", "", "Add", context),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return HomeMiddleShimmer();
          } else {
            return DefaultHomeData(context);
          }
        });
  }

  List<String> types = [
    'All Cuisines',
    'Indians',
    'Thai',
    'Italian',
    'Mexican',
  ];
  int selectedIndex = 0;

  //int selectedEatingTime = 0;
  int ingredientOrProcedure = 0;

  Widget addFoodDivider(
    int typeId,
    type,
  ) {
    DashboardController c = Get.put(DashboardController());
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              if (widget.networkConnection) {
                print("tapped type:" + type);
                c.rotate(90);
                await Future.delayed(Duration(milliseconds: 600));
                setState(() {
                  if (bfbuttonCount == 3) {
                    bfbuttonCount = 1;
                  }
                  if (lunchbuttonCount == 3) {
                    lunchbuttonCount = 1;
                  }
                  if (snackbuttonCount == 3) {
                    snackbuttonCount = 1;
                  }
                  if (dinnerbuttonCount == 3) {
                    dinnerbuttonCount = 1;
                  }
                  if (type == "breakfast") {
                    isbfPress = true;
                    itemsOfbf = 0;
                    itemsOfbf = itemsOfbf + 4;
                    bfbuttonCount += 1;
                  }
                  if (type == "lunch") {
                    islunchPress = true;
                    itemsOflunch = 0;
                    itemsOflunch = itemsOflunch + 4;
                    lunchbuttonCount += 1;
                  }
                  if (type == "snack") {
                    issnackPress = true;
                    itemsOfsnack = 0;
                    itemsOfsnack = itemsOfsnack + 4;
                    snackbuttonCount += 1;
                  }
                  if (type == "dinner") {
                    isdinnerPress = true;
                    itemsOfdinner = 0;
                    itemsOfdinner = itemsOfdinner + 4;
                    dinnerbuttonCount += 1;
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(noInternetsnackBar);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DDText(
                title: "Replace all",
                size: MySize.size11,
                color: primaryColor,
              ),
            ),
          ),

          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.blue)),
          ),
          SizedBox(
            height: 50.0,
            child: SolidLineConnector(),
          ),
          GestureDetector(
            onTap: () {
              if (widget.networkConnection) {
                final provider =
                    Provider.of<UserDataProvider>(context, listen: false);
                provider.setTypeId(typeId);
                print("food Id for adding:${provider.foodTypeId}");

                Get.to(() => SearchFood(false));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(noInternetsnackBar);
              }
            },
            child: DDText(
              title: "Add Food",
              size: MySize.size11,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: 50.0,
            child: SolidLineConnector(),
          ),

          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.blue)),
          ),
          // OutlinedDotIndicator(),
          GestureDetector(
            onTap: () {
              if (widget.networkConnection) {
                Responsive1.isMobile(context)
                    ? //Get.to(() => RestaurantLocation())
                    Get.to(() => FavouriteRes(type: type))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: //RestaurantLocation()
                              FavouriteRes(type: type),
                        );
                        //return MoreFoodScreen(type: type);
                      }));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(noInternetsnackBar);
              }
            },
            child: DDText(
              title: "Restaurant\n     food",
              size: MySize.size11,
              line: 2,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showChoiceDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 50,
            height: 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text("Add Food"),
                    leading: Icon(
                      Icons.room_service,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TrackFood()));
                    },
                    title: Text("Replace"),
                    leading: Icon(
                      Icons.autorenew,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

int ingredientOrProcedure = 0;

///dialog for active plan food
showFoodDialog(
    BuildContext context,
    title,
    servings,
    cal,
    carb,
    fat,
    protein,
    description,
    procedure,
    imageurl,
    int typeId,
    selectedEatingTime,
    cuisines,
    ActiveFoodPlans food,
    id) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          var size = MediaQuery.of(context).size.width;
          var mobile = Responsive1.isMobile(context);
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: Responsive1.isMobile(context)
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.only(left: 400, right: 400, top: 10),
              child: Container(
                width: Responsive1.isMobile(context) ? double.infinity : 500,
                height: Responsive1.isMobile(context) ? double.infinity : 560,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.20
                                  : size * 0.15,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(imageurl)
                                          //'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    title,
                                    // softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '${servings} Serving, 250 grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          cuisines ?? "-",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width:
                                    //   MediaQuery.of(context).size.width *
                                    //       0.02,
                                    // ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.red[100],
                                    //       borderRadius:
                                    //       BorderRadius.circular(100)),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: 4, horizontal: 10),
                                    //     child: Text(
                                    //       'Keton: Avoid',
                                    //       style: GoogleFonts.montserrat(
                                    //           fontSize: 9, color: Colors.red),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey, width: .5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cals',
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  Text(
                                    "${cal.toString()}",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * .02,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${carb}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '0g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: mobile
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 0;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 1;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 2;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 3;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              servings,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      FutureBuilder(
                          future: fetchRecipe1(int.parse(id)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var ab = snapshot.data["Ingredients"];
                              var ingredient = jsonDecode(ab);
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 0;
                                                });
                                              },
                                              child: Text(
                                                'Ingredients',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                0
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 0
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 1;
                                                });
                                              },
                                              child: Text(
                                                'Procedure',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                1
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 1
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: .5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: ingredientOrProcedure == 1
                                            ? snapshot.data['Procedure'] == null
                                                ? "No Procedure Available"
                                                : Text(
                                                    snapshot.data['Procedure']
                                                        .replaceAll("<p>", "")
                                                        .replaceAll("</p>", "")
                                                        .replaceAll('"', "")
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "")
                                                        .replaceAll('<li>', "")
                                                        .replaceAll("</li>", "")
                                                        .replaceAll("<ul>", "")
                                                        .replaceAll(
                                                            '</ul>', ""),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                  )
                                            : ingredientOrProcedure == 0
                                                ? snapshot.data[
                                                            'Ingredients'] ==
                                                        null
                                                    ? "No Ingredients Available"
                                                    : ListView.builder(
                                                        itemCount:
                                                            ingredient.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Text(
                                                            ingredient[index],
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                          );
                                                        })
                                                : "Not Available",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return FoodDialogShimmer();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Type $typeId");
                              final provider = Provider.of<UserDataProvider>(
                                  context,
                                  listen: false);
                              if (typeId == 6) {
                                post(
                                  Uri.parse('$apiUrl/api/diary'),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "userId": provider.userData.user.id,
                                    "F_type_id": 6,
                                    "WaterServing": 1
                                  }),
                                ).then((value) {
                                  print("water response ${value.statusCode}");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(0)));
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString}");
                                  DDToast().showToast(
                                      "Message", error.toString(), true);
                                });
                              } else {
                                // double servingDouble =
                                // double.parse(food.servingSize.toString());
                                // int serving = servingDouble.toInt();
                                final provider = Provider.of<UserDataProvider>(
                                    context,
                                    listen: false);
                                int type = provider.foodTypeId;
                                final ProgressDialog pr =
                                    ProgressDialog(context);
                                pr.show();
                                // createFood(typeId,
                                //   provider.userData.user.id, serving, cal,serving,fat, protein,carb,id)
                                print(servings);
                                post(
                                  Uri.parse('$apiUrl/api/diary'),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "userId": provider.userData.user.id,
                                    "F_type_id": typeId,
                                    "FoodId": id,
                                    "Cons_Cal": cal,
                                    "ServingSize": int.parse(servings),
                                    "fat": fat,
                                    "Protein": protein,
                                    "Carbs": carb
                                  }),
                                ).then((value) {
                                  print("Add Food ${value.body}");
                                  pr.hide();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(0)));
                                }).onError((error, stackTrace) {
                                  pr.hide();
                                  print(error.toString());
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      );
    },
  );
}

Future<bool> AddFoodToDiary(
    context,
    name,
    ingredients,
    serving,
    calories,
    carb,
    fat,
    pro,
    desc,
    procedure,
    imagePath,
    typeId,
    eatingTime,
    cuisine,
    id) async {
  final provider = Provider.of<UserDataProvider>(context, listen: false);
  //final ProgressDialog pr = ProgressDialog(context);
  //pr.show();
  // createFood(typeId,
  //   provider.userData.user.id, serving, cal,serving,fat, protein,carb,id)
  print(serving);
  var response = await post(
    Uri.parse('$apiUrl/api/diary'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "userId": provider.userData.user.id,
      "F_type_id": typeId,
      "FoodId": id.toString(),
      "Cons_Cal": calories,
      "ServingSize": int.parse(serving),
      "fat": fat,
      "Protein": pro,
      "Carbs": carb
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else
    return false;
}

/// Dialog for food
showFoodDialog1(
    BuildContext context,
    title,
    ingredients,
    servings,
    cal,
    carb,
    fat,
    protein,
    description,
    procedure,
    imageurl,
    int typeId,
    selectedEatingTime,
    cuisines,
    ActiveFoodPlans food,
    id) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          var size = MediaQuery.of(context).size.width;
          var mobile = Responsive1.isMobile(context);
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: Responsive1.isMobile(context)
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.only(left: 400, right: 400),
              child: Container(
                width: Responsive1.isMobile(context) ? double.infinity : 500,
                height: Responsive1.isMobile(context) ? double.infinity : 560,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            mobile ? EdgeInsets.all(8.0) : EdgeInsets.all(2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.20
                                  : size * 0.15,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(imageurl)
                                          //'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    title,
                                    // softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '${servings} Serving, 250 grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          cuisines ?? "-",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width:
                                    //   MediaQuery.of(context).size.width *
                                    //       0.02,
                                    // ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.red[100],
                                    //       borderRadius:
                                    //       BorderRadius.circular(100)),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: 4, horizontal: 10),
                                    //     child: Text(
                                    //       'Keton: Avoid',
                                    //       style: GoogleFonts.montserrat(
                                    //           fontSize: 9, color: Colors.red),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                            Visibility(
                                visible: mobile,
                                child: Expanded(child: SizedBox())),
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey, width: .5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cals',
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  Text(
                                    "${cal.toString()}",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * .01,
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: mobile?MediaQuery.of(context).size.width * 0.01:0,
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${carb}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '0g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: mobile
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 0;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 1;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 2;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 3;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '250',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      FutureBuilder(
                          future: fetchRecipe1(int.parse(id)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var ab = snapshot.data["Ingredients"];
                              var ingredient = jsonDecode(ab);
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 0;
                                                });
                                              },
                                              child: Text(
                                                'Ingredients',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                0
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 0
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 1;
                                                });
                                              },
                                              child: Text(
                                                'Procedure',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                1
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 1
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: .5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: ingredientOrProcedure == 1
                                            ? snapshot.data['Procedure'] == null
                                                ? "No Procedure Available"
                                                : Text(
                                                    snapshot.data['Procedure']
                                                        .replaceAll("<p>", "")
                                                        .replaceAll("</p>", "")
                                                        .replaceAll('"', "")
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "")
                                                        .replaceAll('<li>', "")
                                                        .replaceAll("</li>", "")
                                                        .replaceAll("<ul>", "")
                                                        .replaceAll(
                                                            '</ul>', ""),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                  )
                                            : ingredientOrProcedure == 0
                                                ? snapshot.data[
                                                            'Ingredients'] ==
                                                        null
                                                    ? "No Ingredients Available"
                                                    : ListView.builder(
                                                        itemCount:
                                                            ingredient.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Text(
                                                            ingredient[index],
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                          );
                                                        })
                                                : "Not Available",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return FoodDialogShimmer();
                          }),

                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Type $typeId");
                              final provider = Provider.of<UserDataProvider>(
                                  context,
                                  listen: false);
                              if (typeId == 6) {
                                post(
                                  Uri.parse('$apiUrl/api/diary'),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "userId": provider.userData.user.id,
                                    "F_type_id": 6,
                                    "WaterServing": 1
                                  }),
                                ).then((value) {
                                  print("water response ${value.statusCode}");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(0)));
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString}");
                                  DDToast().showToast(
                                      "Message", error.toString(), true);
                                });
                              } else {
                                // double servingDouble =
                                // double.parse(food.servingSize.toString());
                                // int serving = servingDouble.toInt();
                                int type = provider.foodTypeId;
                                final ProgressDialog pr =
                                    ProgressDialog(context);
                                pr.show();
                                // createFood(typeId,
                                //   provider.userData.user.id, serving, cal,serving,fat, protein,carb,id)
                                print(servings);
                                post(
                                  Uri.parse('$apiUrl/api/diary'),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "userId": provider.userData.user.id,
                                    "F_type_id": typeId,
                                    "FoodId": id.toString(),
                                    "Cons_Cal": cal,
                                    "ServingSize": int.parse(servings),
                                    "fat": fat,
                                    "Protein": protein,
                                    "Carbs": carb
                                  }),
                                ).then((value) {
                                  print("Add Food ${value.body}");
                                  pr.hide();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(0)));
                                }).onError((error, stackTrace) {
                                  pr.hide();
                                  print(error.toString());
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      );
    },
  );
}
