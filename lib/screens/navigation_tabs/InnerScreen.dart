import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';

import 'ExerciseSceen.dart';

class InnerPage extends StatefulWidget {
  final initialIndex;

  const InnerPage({Key key, this.initialIndex}) : super(key: key);
  @override
  _InnerPageState createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> with TickerProviderStateMixin {
  List<bool> days = [false, false, false, false, false, false, false];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _tabController = new TabController(
        length: 3, vsync: this, initialIndex: widget.initialIndex);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double heightOfTabBar = MediaQuery.of(context).size.height * 0.04;
    double heightOfBottomBar = MediaQuery.of(context).size.height * 0.07;
    double margin = height * 0.02;

    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/Diet.png"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Oats",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      "250 grams",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    )
                                  ],
                                ),
                                Text(
                                  "200 kcal",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            ),
                            Text(
                              "Recipe",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "1 cup fat free milk",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "1 cup oats",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "1 tbsp chopped walnuts",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: customAppBar(context),
        bottomNavigationBar: Container(
          height: heightOfBottomBar,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/home.png",
                color: Colors.grey[300],
              ),
              Image.asset("assets/icons/diaryy.png"),
              Image.asset("assets/icons/watch.png"),
              Icon(
                FontAwesomeIcons.solidHeart,
                color: primaryColor,
              ),
              CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                // Container(
                //   height: AppBar().preferredSize.height,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10.0),
                //         child: Icon(Icons.menu, color: Colors.grey),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(right: 10.0),
                //         child: Icon(
                //           Icons.notifications,
                //           color: Colors.grey,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  height: height -
                      (AppBar().preferredSize.height + heightOfBottomBar),
                  //margin: EdgeInsets.only(top: AppBar().preferredSize.height),
                  child: Column(
                    children: [
                      // Container(
                      //   height: heightOfTabBar,
                      //   child: TabBar(
                      //     controller: _tabController,
                      //     indicator: BoxDecoration(
                      //       border: Border(
                      //         bottom:
                      //             BorderSide(width: 2.2, color: Colors.blue),
                      //       ),
                      //     ),
                      //     /*indicator:  UnderlineTabIndicator(
                      //     borderSide: BorderSide(width: 0.0,color: Colors.white),
                      //     insets: EdgeInsets.symmetric(horizontal:16.0)
                      // ),*/
                      //     labelColor: Colors.blue,
                      //     labelStyle: TextStyle(
                      //         fontSize: 12, fontWeight: FontWeight.w500),
                      //     unselectedLabelColor: Colors.grey,
                      //     tabs: [
                      //       Tab(text: 'Running'),
                      //       Tab(text: 'Diet'),
                      //       Tab(text: 'Favourites'),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: height -
                            (AppBar().preferredSize.height +
                                heightOfTabBar +
                                heightOfBottomBar),
                        child:
                            TabBarView(controller: _tabController, children: <
                                Widget>[
                          // running tab
                          Container(
                            child: ListView(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: height * 0.25,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/bannar.png',
                                          fit: BoxFit.cover,
                                          height: height * 0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "Get Up Go Up",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 20),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(margin, margin, 0, 0),
                                  child: Text(
                                    "Days",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                daysRowUpdated(margin, height),
                                SizedBox(height: 20),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        margin, 10, margin, margin),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Set 1",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "2 Reps",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        margin, 0, margin, margin),
                                    child: ListView.builder(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                              {} //ExerciseScreen([],0)
                                                          );
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (BuildContext
                                                      //             context) =>
                                                      //         ExerciseScreen([],0),
                                                      //   ),
                                                      // );
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, margin, 0),
                                                      height: height * 0.12,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.18,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                'assets/images/1.png',
                                                              ))),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: height * 0.12,
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width -
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "Walk",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Text(
                                                                "10 minutes",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color:
                                                                    Colors.blue,
                                                              )
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "200 kcal",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .blue,
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                                thickness: 0.3,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),

                          // Diet Tab
                          Container(
                            child: ListView(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: height * 0.25,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/Diet.png',
                                          fit: BoxFit.cover,
                                          height: height * 0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "Keto Diet",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 20),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(margin, margin, 0, 0),
                                  child: Text(
                                    "Days",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(margin),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[0] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.001,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[0]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[0]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "1",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[0]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[1] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[1]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[1]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "2",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[1]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[2] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[2]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[2]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "3",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[2]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[3] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[3]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[3]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "4",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[3]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[4] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[4]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[4]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "5",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[4]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[5] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[5]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[5]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "6",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[5]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              for (int i = 0;
                                                  i < days.length;
                                                  i++) {
                                                setState(() {
                                                  days[i] = false;
                                                });
                                              }
                                              setState(() {
                                                days[6] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  height * 0.005,
                                                  height * 0.015,
                                                  height * 0.005,
                                                  height * 0.015),
                                              margin: EdgeInsets.only(
                                                  right: height * 0.02),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: days[6]
                                                      ? selectedBgColor
                                                      : unSelectedBgColor),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[6]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                  Text(
                                                    "7",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: days[6]
                                                            ? selectedTextColor
                                                            : unSelectedTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 20),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        margin, 10, margin, margin),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Morning",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "8:30",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        margin, 0, margin, margin),
                                    child: ListView.builder(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showDialog();
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, margin, 0),
                                                      height: height * 0.12,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.18,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                'assets/images/diet1.png',
                                                              ))),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: height * 0.12,
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width -
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "Green Tea",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                            .grey[
                                                                        700],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Text(
                                                                "250 Grams",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color:
                                                                    Colors.blue,
                                                              )
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "200 kcal",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .blue,
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                                thickness: 0.3,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),

                          //Favourites Tab
                          Container(
                            child: ListView(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: height * 0.25,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/fav.png',
                                          fit: BoxFit.cover,
                                          height: height * 0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: DefaultTabController(
                                        length: 2,
                                        child: Column(children: [
                                          Container(
                                            height: heightOfTabBar,
                                            child: TabBar(
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              indicator: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 2.2,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              /*indicator:  UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.0,color: Colors.white),
                          insets: EdgeInsets.symmetric(horizontal:16.0)
                      ),*/
                                              labelColor: Colors.blue,
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              unselectedLabelColor: Colors.grey,
                                              tabs: [
                                                Tab(text: 'My Diets'),
                                                Tab(text: 'My Workouts'),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: height -
                                                  (AppBar()
                                                          .preferredSize
                                                          .height +
                                                      heightOfTabBar +
                                                      heightOfBottomBar),
                                              child: TabBarView(
                                                  children: <Widget>[
                                                    //favourite diet tab
                                                    Container(
                                                      child: ListView(
                                                        children: [
                                                          SizedBox(height: 20),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      margin,
                                                                      0,
                                                                      margin,
                                                                      margin),
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: 2,
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            margin: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                10,
                                                                                10,
                                                                                margin),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "Morning",
                                                                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                                                                ),
                                                                                Text(
                                                                                  "8:30",
                                                                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                                                              height: height * 0.12,
                                                                              width: MediaQuery.of(context).size.width * 0.18,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: AssetImage(
                                                                                        'assets/images/diet2.png',
                                                                                      ))),
                                                                            ),
                                                                            Container(
                                                                                height: height * 0.12,
                                                                                width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.3),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Oats",
                                                                                          style: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Text(
                                                                                          "250 grams",
                                                                                          style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.play_arrow,
                                                                                          color: Colors.blue,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          "200 kcal",
                                                                                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.favorite,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.add,
                                                                                              color: Colors.blue,
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                          thickness:
                                                                              0.3,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    //favourite workout tab
                                                    Container(
                                                      child: ListView(
                                                        children: [
                                                          SizedBox(height: 20),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      margin,
                                                                      10,
                                                                      margin,
                                                                      margin),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Set 1",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  Text(
                                                                    "2 Reps",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              )),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      margin,
                                                                      0,
                                                                      margin,
                                                                      margin),
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: 2,
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                                                              height: height * 0.12,
                                                                              width: MediaQuery.of(context).size.width * 0.18,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: AssetImage(
                                                                                        'assets/images/1.png',
                                                                                      ))),
                                                                            ),
                                                                            Container(
                                                                                height: height * 0.12,
                                                                                width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.3),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Walk",
                                                                                          style: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Text(
                                                                                          "10 minutes",
                                                                                          style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.play_arrow,
                                                                                          color: Colors.blue,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          "200 kcal",
                                                                                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.favorite,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.add,
                                                                                              color: Colors.blue,
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                          thickness:
                                                                              0.3,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ]))
                                        ]))),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container daysRowUpdated(double margin, double height) {
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < days.length; i++) {
                    setState(() {
                      days[i] = false;
                    });
                  }
                  setState(() {
                    days[0] = true;
                  });
                },
                child: dayNumberUpdated(height, "1", 0),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[1] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "2", 1)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[2] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "3", 2)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[3] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "4", 3)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[4] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "5", 4)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[5] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "6", 5)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[6] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "7", 6)),
            ),
          ],
        ));
  }

  Container dayNumberUpdated(double height, number, index) {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size4,
        bottom: MySize.size4,
      ),
      // padding: EdgeInsets.fromLTRB(height * 0.001,
      //     height * 0.018, height * 0.002, height * 0.015),
      margin: EdgeInsets.only(
        right: height * 0.025,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: days[index] ? selectedBgColor : unSelectedBgColor),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DDText(
              title: "Day",
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
            DDText(
              title: number,
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
