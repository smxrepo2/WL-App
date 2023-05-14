import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';

import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';

import 'package:weight_loser/screens/exercise_screens/SelectExercisePlan.dart';

import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ColorConfig.dart';
import 'package:weight_loser/utils/Responsive.dart';
import 'package:weight_loser/widget/SizeConfig.dart';
import 'package:weight_loser/widget/Shimmer/diary_shimmer_widget.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({
    Key key,
    this.responsive,
    this.colors,
  }) : super(key: key);

  final Responsive responsive;
  final ColorConfig colors;

  @override
  _DiaryViewState createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<DiaryView> {
  @override
  bool get wantKeepAlive => true;

  int userid;

  Future<Response> deleteEntry(int typeId, int itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    return delete(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "Id": itemId
      }),
    );
  }

/*
  Future<void> _showMyDialog(
      int userId, int typeId, int itemId, BuildContext snackContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: SingleChildScrollView(
            child: ListBody(children: const <Widget>[
              Text('Do you want to delete this entry?'),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('YES'),
              onPressed: () {
                deleteEntry(typeId, itemId).then((value) {
                  if (value.statusCode == 200) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarNew(4)));
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        "Unable to delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                }).onError((error, stackTrace) {
                  final snackBar = SnackBar(
                    content: Text(
                      error.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
*/
  int totalBreakFastCalories = 0;
  int totalLunchCalories = 0;
  int totalDinnerCalories = 0;
  int totalSnacksCalories = 0;
  int totalWaterServings = 0;
  Future<Dairy> fetchDairy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
        isUtc: true);
    final response = await get(
      Uri.parse(
          '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
    );

    if (response.statusCode == 200) {
      return Dairy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  getTotalCalories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
        isUtc: true);
    print("todays date:" + datetime.toIso8601String());
    final response = await get(
      Uri.parse(
          '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
    );

    if (response.statusCode == 200) {
      Dairy _dairy = Dairy.fromJson(jsonDecode(response.body));
      print("diary data:" + _dairy.breakfastList.toString());
      _dairy.breakfastList.forEach((element) {
        setState(() {
          totalBreakFastCalories += element.consCalories.toInt();
        });
      });
      _dairy.luncheList.forEach((element) {
        setState(() {
          totalLunchCalories += element.consCalories.toInt();
        });
      });
      _dairy.dinnerList.forEach((element) {
        setState(() {
          totalDinnerCalories += element.consCalories.toInt();
        });
      });
      _dairy.snackList.forEach((element) {
        setState(() {
          totalSnacksCalories += element.consCalories.toInt();
        });
      });
      _dairy.waterList.forEach((element) {
        setState(() {
          totalWaterServings += element.serving.toInt();
        });
      });
    }
  }

  _showAddWaterDialog() async {
    int waterServings = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            increaseWaterServingSize() {
              setState(() {
                waterServings++;
              });
            }

            int getCups() {
              return waterServings;
            }

            decreaseWaterServingSize() {
              setState(() {
                waterServings--;
              });
            }

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Water Servings"),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (waterServings > 0)
                                  decreaseWaterServingSize();
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              waterServings.toString(),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                increaseWaterServingSize();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff4C86EC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              print("cups $waterServings");

                              if (getCups() != 0) {
                                post(
                                  Uri.parse('$apiUrl/api/diary'),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "userId": userid,
                                    "F_type_id": 6,
                                    "WaterServing": getCups()
                                  }),
                                ).then((value) {
                                  print("water response ${value.statusCode}");

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(4)));
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString}");
                                  DDToast().showToast(
                                      "Message", error.toString(), true);
                                });
                              } else {
                                final snackBar = SnackBar(
                                    content: Text('Water count is empty',
                                        style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.red);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(fontSize: MySize.size14),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  TabController _tabController;
  TabController _mainTabController;
  int _indexOfTab = 0;

  @override
  void dispose() {
    _tabController.dispose();
    _mainTabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
    _mainTabController = TabController(vsync: this, length: 4);

    getTotalCalories();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomBarNew(0)));
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: diaryBody(context)),
          ],
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 4,
    //   child: WillPopScope(
    //     onWillPop: _willPopCallback,
    //     child: Scaffold(
    //       drawer: CustomDrawer(),
    //       appBar: customAppBar(
    //         context,
    //         elevation: 0.5,
    //         tabBar: TabBar(
    //           controller: _mainTabController,
    //           onTap: (index) {
    //             setState(() {
    //               _indexOfTab = index;
    //             });
    //           },
    //           labelPadding: EdgeInsets.only(left: MySize.size4),
    //           indicatorColor: _indexOfTab == 0
    //               ? Colors.transparent
    //               : _indexOfTab == 1
    //                   ? Colors.blue
    //                   : Colors.blue,
    //           labelColor: _indexOfTab == 0 ? Colors.black : Color(0xff4885ED),
    //           indicatorSize: TabBarIndicatorSize.label,
    //           unselectedLabelColor: Colors.black87,
    //           tabs: [
    //             Tab(
    //               text: 'Today',
    //             ),
    //             Tab(text: 'Diet'),
    //             Tab(text: 'Exercise'),
    //             Tab(text: 'Mind'),
    //           ],
    //         ),
    //       ),
    //       // appBar: customAppBar(
    //       //   context,
    //       //   elevation: 0.5,
    //       //   tabBar: TabBar(
    //       //     controller: _mainTabController,
    //       //     labelPadding: EdgeInsets.only(left: MySize.size4),
    //       //     indicatorColor: Color(0xff4885ED),
    //       //     labelColor: Color(0xff4885ED),
    //       //     indicatorSize: TabBarIndicatorSize.label,
    //       //     unselectedLabelColor: Colors.black87,
    //       //     tabs: [
    //       //       Tab(
    //       //         text: 'Today',
    //       //       ),
    //       //       Tab(text: 'Diet'),
    //       //       Tab(text: 'Exercise'),
    //       //       Tab(text: 'Mind'),
    //       //     ],
    //       //   ),
    //       // ),
    //       body: Container(
    //         color: Colors.white,
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 child: Column(
    //                   children: [
    //                     Expanded(
    //                         child: TabBarView(
    //                       controller: _mainTabController,
    //                       children: [
    //                         diaryBody(context),
    //                         DietTabView(),
    //                         RunningTabView(),
    //                         MindTabView(),
    //                       ],
    //                     )),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  SingleChildScrollView diaryBody(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Padding(
            padding: Responsive1.isDesktop(context)
                ? const EdgeInsets.only(left: 100, right: 100)
                : const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MySize.size26),
                  child: DDText(
                    title: "Budget",
                    weight: FontWeight.w500,
                    size: MySize.size14,
                  ),
                ),

                // GestureDetector(
                //   onTap: () {
                //     var route = MaterialPageRoute(
                //       builder: (context) => CheatFoodScreen(),
                //     );
                //     Navigator.push(context, route);
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         "assets/icons/cheeseburger.png",
                //         width: 20,
                //         height: 20,
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(right: MySize.size26),
                //         child: DDText(
                //           title: "Cheat Food",
                //           weight: FontWeight.w500,
                //           size: MySize.size14,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          FutureBuilder<Dairy>(
            future: fetchDairy(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Padding(
                  padding: Responsive1.isDesktop(context)
                      ? const EdgeInsets.only(left: 100, right: 100)
                      : const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //goalFoodExerciseCaloriesView(snapshot.data),
                      SizedBox(
                        height: MySize.size30,
                      ),
                      diaryPart(context, snapshot.data),
                      SizedBox(
                        height: MySize.size16,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: MySize.size18, right: MySize.size20),
                          child: Divider(
                            thickness: 0.5,
                          )),
                      tabBarTabs(),
                      Container(
                        margin: EdgeInsets.only(
                            left: MySize.size18, right: MySize.size20),
                        child: Divider(
                          thickness: 0.3,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(children: [Text("BREAKFAST"),Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: SizedBox(width:MediaQuery.of(context).size.width*0.4,child: Divider(thickness: 1,)),
                      //   ),GestureDetector(onTap:(){ print("pressed ${_tabController.index + 1}");
                      //   final provider =
                      //   Provider.of<UserDataProvider>(context, listen: false);
                      //   provider.setTypeId(_tabController.index + 1);
                      //   if (_tabController.index + 1 == 6) {
                      //     _showAddWaterDialog();
                      //   } else if (_tabController.index + 1 == 5) {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //       return SelectExercisePlan(false);
                      //     }));
                      //   } else {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //       return SearchFood(false);
                      //       // return BottomBar(0);
                      //     }));
                      //   }},child: Icon(Icons.add))],),
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Expanded(
                                child: TabBarView(
                              controller: _tabController,
                              children: [
                                snapshot.data.breakfastList.length == 0
                                    ? Center(
                                        child: Text("No Breakfast Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount: snapshot
                                              .data.breakfastList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot
                                                        .data
                                                        .breakfastList[index]
                                                        .bfId,
                                                    context);
                                              */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${snapshot.data.breakfastList[index].fName}",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.breakfastList[index].consCalories}cal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                snapshot.data.luncheList.length == 0
                                    ? Center(
                                        child: Text("No Lunch Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data.luncheList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot.data
                                                        .luncheList[index].lId,
                                                    context); */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${snapshot.data.luncheList[index].fName}",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.luncheList[index].consCalories}cal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                snapshot.data.dinnerList.length == 0
                                    ? Center(
                                        child: Text("No Dinner Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data.dinnerList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot.data
                                                        .dinnerList[index].dId,
                                                    context);
                                                    */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${snapshot.data.dinnerList[index].fName}",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.dinnerList[index].consCalories}cal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                snapshot.data.snackList.length == 0
                                    ? Center(
                                        child: Text("No Snack Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data.snackList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot
                                                        .data
                                                        .snackList[index]
                                                        .snckId,
                                                    context);
                                              */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${snapshot.data.snackList[index].fName}",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.snackList[index].consCalories}cal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                snapshot.data.userExcerciseList.length == 0
                                    ? Center(
                                        child: Text("No Exercise Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount: snapshot
                                              .data.userExcerciseList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot
                                                        .data
                                                        .userExcerciseList[
                                                            index]
                                                        .ueId,
                                                    context);
                                              */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${snapshot.data.userExcerciseList[index].duration} mins",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.userExcerciseList[index].burnCalories} cal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                snapshot.data.waterList.length == 0
                                    ? Center(
                                        child: Text("No Water Added"),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data.waterList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onLongPress: () {
                                                /*
                                                _showMyDialog(
                                                    userid,
                                                    1,
                                                    snapshot.data
                                                        .waterList[index].id,
                                                    context);
                                              */
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: MySize.size8,
                                                    right: MySize.size8),
                                                child: Card(
                                                  elevation: 0.3,
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     side: BorderSide(
                                                  //         style: BorderStyle.solid,
                                                  //         color: Colors.transparent)),
                                                  // elevation: 0.5,
                                                  margin: EdgeInsets.only(
                                                      left: MySize.size12,
                                                      right: MySize.size12,
                                                      bottom: MySize.size6,
                                                      top: MySize.size8),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: MySize.size14,
                                                          // top: MySize.size8,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text("Servings",
                                                                style: TextStyle(
                                                                    fontSize: MySize
                                                                        .size14)),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: MySize
                                                                      .size14),
                                                              child: Text(
                                                                  "${snapshot.data.waterList[index].serving} cups",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          MySize
                                                                              .size14)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1.3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('No Internet Connectivity'),
                );
              }

              // By default, show a loading spinner.
              return DiaryShimmerWidget();
            },
          ),
          //goalFoodExerciseCaloriesLeftSection(),

          addButton(context)
        ],
      ),
    );
  }

// #################### ADD FOOD BUTTON #####################

  Row addButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff4C86EC),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              print("pressed ${_tabController.index + 1}");
              final provider =
                  Provider.of<UserDataProvider>(context, listen: false);
              provider.setTypeId(_tabController.index + 1);
              if (_tabController.index + 1 == 6) {
                _showAddWaterDialog();
              } else if (_tabController.index + 1 == 5) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelectExercisePlan(false);
                }));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchFood(false);
                  // return BottomBar(0);
                }));
              }
            },
            child: Text(
              "Add",
              style: TextStyle(fontSize: MySize.size14),
            ))
      ],
    );
  }

// #################### TAB BAR TABS #####################

  Container tabBarTabs() {
    return Container(
      margin: EdgeInsets.only(left: MySize.size16, right: MySize.size8),
      child: DefaultTabController(
        length: 6,
        initialIndex: 0,
        child: Center(
          child: Container(
            // padding:
            // EdgeInsets.symmetric(horizontal: MySize.size22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: primaryColor,
                    unselectedLabelColor: Colors.black,
                    labelPadding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                    ),
                    labelStyle: TextStyle(fontSize: MySize.size12),
                    onTap: (val) {
                      print("Val $val");
                    },
                    tabs: [
                      Tab(
                        text: "Breakfast",
                      ),
                      Tab(
                        text: "Lunch",
                      ),
                      Tab(
                        text: "Dinner",
                      ),
                      Tab(
                        text: "Snacks",
                      ),
                      Tab(
                        text: "Exercise",
                      ),
                      Tab(
                        text: "Water",
                      ),
                    ],
                    labelColor: primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// #################### DIARY VIEW #####################

  GestureDetector diaryPart(BuildContext context, Dairy _dairy) {
    var mobile = Responsive1.isMobile(context);
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return SummaryScreen();
        // }));
      },
      child: Container(
        margin: EdgeInsets.only(left: MySize.size16, right: MySize.size16),
        width: Responsive1.isMobile(context)
            ? MediaQuery.of(context).size.width
            : 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/diary.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(
                left: MySize.size26,
                top: MySize.size14,
                bottom: MySize.size14,
                right: MySize.size18),
            // color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: MySize.size26,
                          //     top: MySize.size14,
                          //     bottom: MySize.size14,
                          //     right: MySize.size18),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: MySize.size26,
                                //     top: MySize.size14,
                                //     bottom: MySize.size14,
                                //     right: MySize.size18),
                                child: Icon(
                                  Icons.free_breakfast_outlined,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size10),
                                child: Text(
                                  "Breakfast",
                                  style: TextStyle(
                                      fontSize: mobile
                                          ? MySize.size14
                                          : MySize.size20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$totalBreakFastCalories cal",
                        style: TextStyle(
                            fontSize: mobile ? MySize.size14 : MySize.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MySize.size26,
                top: MySize.size14,
                bottom: MySize.size14,
                right: MySize.size18),
            // color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: MySize.size26,
                          //     top: MySize.size14,
                          //     bottom: MySize.size14,
                          //     right: MySize.size18),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: MySize.size26,
                                //     top: MySize.size14,
                                //     bottom: MySize.size14,
                                //     right: MySize.size18),
                                child: Icon(
                                  Icons.lunch_dining_outlined,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size10),
                                child: Text(
                                  "Lunch",
                                  style: TextStyle(
                                      fontSize: mobile
                                          ? MySize.size14
                                          : MySize.size20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$totalLunchCalories cals",
                        style: TextStyle(
                            fontSize: mobile ? MySize.size14 : MySize.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MySize.size26,
                top: MySize.size14,
                bottom: MySize.size14,
                right: MySize.size18),
            // color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: MySize.size26,
                          //     top: MySize.size14,
                          //     bottom: MySize.size14,
                          //     right: MySize.size18),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: MySize.size26,
                                //     top: MySize.size14,
                                //     bottom: MySize.size14,
                                //     right: MySize.size18),
                                child: Icon(
                                  MdiIcons.silverwareVariant,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size10),
                                child: Text(
                                  "Dinner",
                                  style: TextStyle(
                                      fontSize: mobile
                                          ? MySize.size14
                                          : MySize.size20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$totalDinnerCalories cals",
                        style: TextStyle(
                            fontSize: mobile ? MySize.size14 : MySize.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MySize.size26,
                top: MySize.size14,
                bottom: MySize.size14,
                right: MySize.size18),
            // color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: MySize.size26,
                          //     top: MySize.size14,
                          //     bottom: MySize.size14,
                          //     right: MySize.size18),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: MySize.size26,
                                //     top: MySize.size14,
                                //     bottom: MySize.size14,
                                //     right: MySize.size18),
                                child: Icon(
                                  MdiIcons.cookieOutline,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size10),
                                child: Text(
                                  "Snacks",
                                  style: TextStyle(
                                      fontSize: mobile
                                          ? MySize.size14
                                          : MySize.size20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$totalSnacksCalories cals",
                        style: TextStyle(
                            fontSize: mobile ? MySize.size14 : MySize.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MySize.size26,
                top: MySize.size14,
                bottom: MySize.size14,
                right: MySize.size18),
            // color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: MySize.size26,
                          //     top: MySize.size14,
                          //     bottom: MySize.size14,
                          //     right: MySize.size18),
                          // color: Colors.red,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(
                                //     left: MySize.size26,
                                //     top: MySize.size14,
                                //     bottom: MySize.size14,
                                //     right: MySize.size18),
                                child: Icon(
                                  Icons.water,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size10),
                                child: Text(
                                  "Water",
                                  style: TextStyle(
                                      fontSize: mobile
                                          ? MySize.size14
                                          : MySize.size20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(""),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "$totalWaterServings servings",
                        style: TextStyle(
                            fontSize: mobile ? MySize.size14 : MySize.size20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

// #################### GOAL, FOOD, EXERCISE AND CALORIES LEFT VIEW #####################

  Padding goalFoodExerciseCaloriesLeftSection() {
    return Padding(
      padding: EdgeInsets.only(left: MySize.size16, right: MySize.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DDText(
                    title: "Goal",
                    size: MySize.size15,
                    weight: FontWeight.w500,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Countup(
                        begin: 0,
                        end: 1100,
                        duration: Duration(seconds: 1),
                        separator: ',',
                        style: GoogleFonts.openSans(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.size10),
                  Container(
                    margin: EdgeInsets.only(left: MySize.size20),
                    width: MySize.size50,
                    child: StepProgressIndicator(
                      totalSteps: 100,
                      direction: Axis.horizontal,
                      currentStep: 100,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MySize.size10),
                    child: Image.asset("assets/icons/minus.png"),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  DDText(
                    title: "Food",
                    size: MySize.size15,
                  ),
                  Countup(
                    begin: 0,
                    end: 300,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MySize.size10),
                  Container(
                    margin: EdgeInsets.only(left: MySize.size20),
                    width: MySize.size50,
                    child: StepProgressIndicator(
                      totalSteps: 100,
                      direction: Axis.horizontal,
                      currentStep: 80,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MySize.size10,
                        left: MySize.size2,
                        right: MySize.size8),
                    child: Image.asset("assets/icons/plus.png"),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  DDText(
                    title: "Exercise",
                    size: MySize.size15,
                  ),
                  Countup(
                    begin: 0,
                    end: 300,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MySize.size10),
                  Container(
                    width: MySize.size50,
                    child: StepProgressIndicator(
                      totalSteps: 100,
                      direction: Axis.horizontal,
                      currentStep: 20,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MySize.size10, left: MySize.size10),
                    child: DDText(
                      title: "=",
                      size: MySize.size18,
                    ),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  DDText(
                    title: "Calories Left",
                    size: MySize.size15,
                  ),
                  Countup(
                    begin: 0,
                    end: 1000,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MySize.size10,
                      ),
                      Container(
                        // margin:
                        //     EdgeInsets.only(
                        //         right: MySize
                        //             .size34),
                        width: MySize.size50,
                        child: StepProgressIndicator(
                          totalSteps: 100,
                          direction: Axis.horizontal,
                          currentStep: 50,
                          padding: 0,
                          selectedColor: primaryColor,
                          unselectedColor: Colors.black12,
                          progressDirection: TextDirection.ltr,
                          //selectedSize: 10.0,
                          // roundedEdges: Radius.elliptical(6, 30),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
