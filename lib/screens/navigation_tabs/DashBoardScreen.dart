import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/HomePageData.dart';
import 'package:weight_loser/Controller/video.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/screens/articles_screens/ArticleDetails.dart';
import 'package:weight_loser/screens/cbt/body.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';
import 'package:weight_loser/screens/story/profilePage.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/SizeConfig.dart';
import 'package:weight_loser/widget/Shimmer/today_shimmer_widget.dart';

import 'New_meditation.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin<DashboardScreen> {
  @override
  bool get wantKeepAlive => true;

  bool isFlipped = false;
  int userid;

  @override
  initState() {
    super.initState();
    //AuthService.getUserId();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          networkConnection = true;
        });
      } else {
        setState(() {
          networkConnection = false;
        });
      }
    });
    //fetchDashboardData();
  }

// Be sure to cancel subscription after you are done
  var subscription;

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  bool networkConnection;

  Future<Dairy> fetchDairy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('userid') != null) {
      userid = prefs.getInt('userid');
      print('hello $userid');
    }
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
        isUtc: true);
    print(DateTime.now());
    final response = await get(
      Uri.parse(
          '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
    );
    print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      return Dairy.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  Future<DashboardModel> fetchDashboardData() async {
    print("USER ID FOR DASHBOARD IS $userid");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('userid') != null) {
      userid = prefs.getInt('userid');
      print('hello $userid');
    }

    final response = await get(
      Uri.parse('$apiUrl/api/dashboard/$userid'),
    );
    print("Dashboard response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      DashboardModel _dbm = DashboardModel.fromJson(jsonDecode(response.body));
      return _dbm;
    } else {
      throw Exception('Failed to load dashboard');
    }
  }

  var quotation =
      "As they say it\'s all in the mind. the better the mind state more likely you succeed";
  var esterik = "*";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: homePageBody(),
    );
    // return DefaultTabController(
    //   length: 4,
    //   child: Scaffold(
    //       drawer: CustomDrawer(),
    //       appBar: customAppBar(
    //         context,
    //         elevation: 0.5,
    //         tabBar: TabBar(
    //           labelPadding: EdgeInsets.only(left: MySize.size4),
    //           indicatorColor: Color(0xff4885ED),
    //           labelColor: Color(0xff4885ED),
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
    //       backgroundColor: Colors.white,
    //       body: networkConnection != false
    //           ? Column(
    //               children: [
    //                 // Divider(),
    //                 Expanded(
    //                     child: TabBarView(
    //                   children: [
    //                     TodayScreen(),
    //                     // homePageBody(),
    //                     DietTabView(),
    //                     RunningTabView(),
    //                     MindTabView(),
    //                   ],
    //                 ))
    //               ],
    //             )
    //           : Center(
    //               child: Text("No Internet Connection"),
    //             )),
    // );
  }

// ############################ APP BAR VIEW #################################

  Widget appBarView() {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      bottom: TabBar(
        labelPadding: EdgeInsets.only(left: MySize.size4),
        indicatorColor: Color(0xff4885ED),
        labelColor: Color(0xff4885ED),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.black87,
        tabs: [
          Tab(
            text: 'Today',
          ),
          Tab(text: 'Diet'),
          Tab(text: 'Exercise'),
          Tab(text: 'Mind'),
        ],
      ),
    );
  }

// ############################{{{ MAIN HOME PAGE SECTION }}} #################################

  Widget homePageBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<DashboardModel>(
                    future: fetchDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return profileSection(snapshot.data.profileVM);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No Internet Connectivity'),
                        );
                      }

                      // By default, show a loading spinner.
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: Container(
                          // color: Colors.red,
                          padding: EdgeInsets.only(
                              left: MySize.size16,
                              top: MySize.size20,
                              right: MySize.size20),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(''),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: MySize.size6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DDText(
                                          title: "",
                                          size: MySize.size13,
                                        ),
                                        DDText(
                                          title: "",
                                          size: MySize.size11,
                                          color: Colors.grey,
                                          weight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => FavouriteTabInnerPage());
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  //   return FavouriteTabInnerPage();
                                  // }));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(""),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MySize.size14),
                                      child: Row(
                                        children: [
                                          DDText(
                                            title: "My Favourites",
                                            size: MySize.size13,
                                          ),
                                          SizedBox(
                                            width: MySize.size4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Image.asset(
                                              "assets/icons/heart_my_favourite.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  SizedBox(height: MySize.size16),
                  /*
                  FutureBuilder<Dairy>(
                    future: fetchDairy(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return goalFoodExerciseCaloriesView(snapshot.data,
                            MySize.size4, MySize.size26, context);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No Internet Connectivity'),
                        );
                      }

                      // By default, show a loading spinner.
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                  */
                  FutureBuilder<DashboardModel>(
                    future: fetchDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return goalFoodExerciseCaloriesView(snapshot.data,
                            MySize.size4, MySize.size26, context, "");
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No Internet Connectivity'),
                        );
                      }

                      // By default, show a loading spinner.
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  FutureBuilder<DashboardModel>(
                    future: fetchDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            // HomePageMiddle(snapshot.data.activeFoodPlans),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2),
                            profileSection(snapshot.data.profileVM),
                            Divider(
                              color: Colors.transparent,
                            ),
                            SizedBox(height: MySize.size16),
                            FutureBuilder<DashboardModel>(
                              future: fetchDashboardData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return goalFoodExerciseCaloriesView(
                                      snapshot.data,
                                      MySize.size4,
                                      MySize.size26,
                                      context,
                                      "");
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('No Internet Connectivity'),
                                  );
                                }
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    enabled: true,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        circularProgress(
                                            "Carbs", Color(0xffDFBB9D), 0, 0),
                                        circularProgress(
                                            "Fat", Color(0xffFFD36E), 0, 0),
                                        circularProgress(
                                            "Protein", Color(0xffFF8C8C), 0, 0),
                                        circularProgress("Calories",
                                            Color(0xffE6D1F8), 0, 0),
                                      ],
                                    ));

                                /*
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  enabled: true,
                                  child: Container(
                                    // color: Colors.red,
                                    margin: EdgeInsets.only(
                                      left: MySize.size20,
                                    ),
                                    padding: EdgeInsets.only(
                                      left: MySize.size4,
                                      right: MySize.size26,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DDText(
                                                  title: "Goal",
                                                  size: 15,
                                                  weight: FontWeight.w500,
                                                ),
                                                Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Countup(
                                                      begin: 0,
                                                      end: 0,
                                                      duration:
                                                          Duration(seconds: 1),
                                                      separator: ',',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                    ),

                                                    // DDText(
                                                    //   title: "11,00",
                                                    //   size: MySize.size15,
                                                    //   weight:
                                                    //       FontWeight.w300,
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(height: MySize.size10),
                                                Container(
                                                  // margin: EdgeInsets.only(left: MySize.size20),
                                                  width: MySize.size34,
                                                  child: StepProgressIndicator(
                                                    totalSteps: 100,
                                                    direction: Axis.horizontal,
                                                    currentStep: 100,
                                                    padding: 0,
                                                    selectedColor: primaryColor,
                                                    unselectedColor:
                                                        Colors.black12,
                                                    progressDirection:
                                                        TextDirection.ltr,
                                                    //selectedSize: 10.0,
                                                    // roundedEdges: Radius.elliptical(6, 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: MySize.size10),
                                                  child: Image.asset(
                                                      "assets/icons/minus.png"),
                                                ),
                                                Text("")
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MySize.size20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  DDText(
                                                    title: "Food",
                                                    size: 15,
                                                  ),
                                                  Countup(
                                                    begin: 0,
                                                    end: 100,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    separator: ',',
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  SizedBox(
                                                      height: MySize.size10),
                                                  Container(
                                                    width: MySize.size36,
                                                    child:
                                                        StepProgressIndicator(
                                                      totalSteps: 10,
                                                      direction:
                                                          Axis.horizontal,
                                                      currentStep: 2,
                                                      padding: 0,
                                                      selectedColor:
                                                          primaryColor,
                                                      unselectedColor:
                                                          Colors.black12,
                                                      progressDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: MySize.size10,
                                                      left: MySize.size2,
                                                      right: MySize.size8),
                                                  child: Image.asset(
                                                      "assets/icons/plus.png"),
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
                                                  size: 15,
                                                ),
                                                Countup(
                                                  begin: 0,
                                                  end: 0,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  separator: ',',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(height: MySize.size10),
                                                Container(
                                                  width: MySize.size56,
                                                  child: StepProgressIndicator(
                                                    totalSteps: 10,
                                                    direction: Axis.horizontal,
                                                    currentStep: 2,
                                                    padding: 0,
                                                    selectedColor: primaryColor,
                                                    unselectedColor:
                                                        Colors.black12,
                                                    progressDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: MySize.size10,
                                                      left: MySize.size10,
                                                      right: MySize.size6),
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
                                                  end: 1,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  separator: ',',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: MySize.size10,
                                                    ),
                                                    Container(
                                                      width: MySize.size84,
                                                      child:
                                                          StepProgressIndicator(
                                                        totalSteps: 10,
                                                        direction:
                                                            Axis.horizontal,
                                                        currentStep: 0,
                                                        padding: 0,
                                                        selectedColor:
                                                            primaryColor,
                                                        unselectedColor:
                                                            Colors.black12,
                                                        progressDirection:
                                                            TextDirection.ltr,
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
                                  ),
                                );
                                */
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Column(
                              children: [
                                // HomePageMiddle(snapshot.data.activeFoodPlans),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                cheatFoodText(),

                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                CheatFood(),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                ),
                                cheatFoodBar(),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 5,
                                ),
                                quotationSection(MySize.size36, MySize.size32),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 5,
                                ),
                                //workoutSection1(),
                                workoutSection(
                                    snapshot.data.activeExercisePlans),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                // psychologicalSectionView(),
                                // SizedBox(
                                //   height: SizeConfig.safeBlockVertical * 2,
                                // ),
                                psychologicalSection(snapshot.data.meditation,
                                    snapshot.data.mindPlans),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                blogSection(snapshot.data.blogs),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No Internet Connectivity'),
                        );
                      } else {
                        // By default, show a loading spinner.
                        return const TodayShimmerWidget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// ############################ BLOG SECTION #################################

  Widget cheatFoodText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Cheat Food',
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 11,
          color: Colors.black,
        ),
        softWrap: false,
      ),
    );
  }

  Widget cheatFoodBar() {
    return Container(
      width: double.infinity,
      height: 7,
      color: Colors.grey[300],
      child: LinearPercentIndicator(
        // width: double.infinity,
        lineHeight: 5.0,
        percent: 0.99,
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.grey[300],
        progressColor: Colors.orange,
      ),
    );
  }

  Widget CheatFood() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        'Big Mac',
        style: labelStyle(13, semiBold, Colors.black),
      ),
      Text("Redeemed ", style: labelStyle(11, light, queColor)),
    ]);
  }

  Widget blogSection(List<dynamic> blogs) {
    return Padding(
      padding: EdgeInsets.only(
          left: MySize.size6, bottom: MySize.size30, right: MySize.size14),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Get.to(() => ArticleDetails(
                      blogs[i].id,
                      blogs[i].title,
                      blogs[i].description,
                      '$imageBaseUrl${blogs[i].fileName}',
                      blogs[i].createdAt,
                      blogs));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return ArticleDetails(
                  //       blogs[i].title,
                  //       blogs[i].description,
                  //       '$imageBaseUrl${blogs[i].fileName}',
                  //       blogs[i].createdAt,
                  //       blogs);
                  // }));
                },
                child: Card(
                  margin: EdgeInsets.only(
                    left: MySize.size10,
                    top: MySize.size5,
                    bottom: MySize.size5,
                  ),
                  elevation: 0,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[100],
                                  spreadRadius: 1,
                                  blurRadius: 0.2)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    top: MySize.size8,
                                    // bottom: MySize.size8,
                                    left: MySize.size8,
                                    right: MySize.size28),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: MySize.size8),
                                      child: DDText(
                                        line: 3,
                                        title: blogs[i].title,
                                        weight: FontWeight.w500,
                                        center: null,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              Container(
                                height: MySize.size100,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          '$imageBaseUrl${blogs[i].fileName}',
                                        ),
                                        scale: 4,
                                        fit: BoxFit.fitHeight)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// ############################ PSYCHOLOGICAL SECTION #################################
  Future<List<dynamic>> getMind() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/dashboard/TodayMind/$userid'),
    );
    print("response ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['ctiveMindPlanVMs'];
      // return ActiveFoodPlans.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('No food items');
    }
  }

  List<ActiveMindPlan> plans = [];
  bool isLoadingPlan = true;

  fetchExcercies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/dashboard/TodayMind/$userid'),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      setState(() {
        plans = List<ActiveMindPlan>.from(
            l.map((model) => ActiveMindPlan.fromJson(model)));
        isLoadingPlan = false;
      });
    } else {
      setState(() {
        isLoadingPlan = true;
      });
      throw Exception('Failed to load plan');
    }
  }

  Widget psychologicalSection(Meditation meditation, MindPlans plans) {
    List psychologicalData = [
      {
        "title": "Cognitive Behavior Therapy",
        "subtitle": "Healthy mind healthy you",
        "icon": "assets/images/meditation.png",
        // "route": VideoWidget(url: '${meditation.videoFile}', play: true)
        "route": CBTScreen() //VideoWidget(
        //url: '$videosBaseUrl${meditation.videoFile}', play: true)
      },
      {
        "title": "Meditation",
        "subtitle": "7 values",
        "icon": "assets/images/exercise.png",
        "route": NewMeditation(),
        // "route": MeditationViewMind(plans['PlanImage'],"", plans['MindPlanId'], 4,)
      },
    ];

    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MySize.size300,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: MySize.size7,
            mainAxisSpacing: MySize.size100),
        itemCount: psychologicalData.length,
        itemBuilder: (BuildContext context, index) {
          print("Video URL:" + meditation.videoFile);
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return psychologicalData[index]["route"];
              }));
              // } else {
              //   getMind();
              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     return psychologicalData[index]["route"];
              //   }));
            },
            child: Container(
              margin: index == 0
                  ? EdgeInsets.only(
                      left: MySize.size14,
                      // right: MySize.size5,
                    )
                  : EdgeInsets.only(right: MySize.size14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xffDFDFDF),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: MySize.size10,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      psychologicalData[index]["icon"],
                      // width: index == 4 ? 300 : 200,
                      // height: index == 4 ? 300 : 200,
                    ),
                    index % 2 == 0
                        ? SizedBox(
                            height: MySize.size15,
                          )
                        : SizedBox(
                            height: MySize.size15,
                          ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        // padding: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DDText(
                              // title: plan.title,
                              title: psychologicalData[index]["title"],
                              center: true,
                              size: MySize.size11,
                              weight: FontWeight.w600,
                            ),
                            index == 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: DDText(
                                          title: psychologicalData[index]
                                              ["subtitle"],
                                          center: true,
                                          size: MySize.size11,
                                          weight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DDText(
                                        title: '',
                                        // title:psychologicalData[index]["title"],
                                        center: true,
                                        size: MySize.size11,
                                        weight: FontWeight.w300,
                                      ),
                                      SizedBox(
                                        width: MySize.size4,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Text(
                                        // "${plan.duration} min",
                                        "10 min",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

// ############################ WORKOUT SECTION #################################

  // Future<ActiveExercise> fetchMindPlanDetail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userid = prefs.getInt('userid');
  //   final response = await get(
  //     Uri.parse('$apiUrl/api/dashboard/TodayExercise/$userid'),
  //   );
  //   print("response ${response.statusCode} ${response.body}");
  //   if (response.statusCode == 200) {
  //     return ActiveExercise.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load plan');
  //   }
  // }

  Future<List<ActiveMindPlan>> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/dashboard/TodayExercise/$userid'),
    );

    var responseJson = json.decode(response.body);
    return (responseJson['ctiveMindPlanVMs'] as List)
        .map((p) => ActiveMindPlan.fromJson(p))
        .toList();
  }

  bool isActive = false;

  // Widget workoutSection1() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: MySize.size18),
  //         child: DDText(
  //           title: "Today's Workout",
  //           size: MySize.size12,
  //         ),
  //       ),
  //       Column(
  //         children: [
  //           FutureBuilder<ActiveExercise>(
  //             future: fetchMindPlanDetail(),
  //               builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               List<ActiveExercisePlans> posts =
  //                   snapshot.data.activeExercisePlans;
  //               return ListView.builder(
  //                   shrinkWrap: true,
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount:snapshot.data.activeExercisePlans.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Container(
  //                       width: 200,
  //                       height: MediaQuery.of(context).size.height * 2,
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5.0),
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: <Widget>[
  //                             GestureDetector(
  //                               onTap: () {
  //                                 setState(() {});
  //                                 // initialIndex = 0;
  //                               },
  //                               child: Container(
  //                                 height: 100,
  //                                 child: ClipRRect(
  //                                   borderRadius: BorderRadius.only(
  //                                     topLeft: Radius.circular(10),
  //                                     topRight: Radius.circular(10),
  //                                   ),
  //                                   child: Image.network(
  //                                     '$imageBaseUrl${posts[index].burnerImage}',
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             // Container(
  //                             //   margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
  //                             //   child: Column(
  //                             //     crossAxisAlignment: CrossAxisAlignment.start,
  //                             //     children: [
  //                             //       Text(
  //                             //          posts[index].name,
  //                             //           style: TextStyle(
  //                             //               fontSize: 12,
  //                             //               fontWeight: FontWeight.w400,
  //                             //               color: Colors.black)),
  //                             //       Row(
  //                             //         mainAxisAlignment: MainAxisAlignment.start,
  //                             //         children: [
  //                             //           Padding(
  //                             //             padding: const EdgeInsets.only(top: 5.0),
  //                             //             child: Row(
  //                             //               children: [
  //                             //                 Text(
  //                             //                   "10 values",
  //                             //                   style: TextStyle(
  //                             //                       color: Colors.grey,
  //                             //                       fontSize: 11,
  //                             //                       fontWeight: FontWeight.w300),
  //                             //                 ),
  //                             //                 SizedBox(
  //                             //                   width: MySize.size4,
  //                             //                 ),
  //                             //                 Container(
  //                             //                   padding: EdgeInsets.only(top: 4.0),
  //                             //                   child: Text(
  //                             //                     "*",
  //                             //                     style: TextStyle(
  //                             //                         color: Colors.grey,
  //                             //                         fontSize: 11,
  //                             //                         fontWeight: FontWeight.w300),
  //                             //                   ),
  //                             //                 ),
  //                             //                 Text(
  //                             //                   "5 sets",
  //                             //                   style: TextStyle(
  //                             //                       color: Colors.grey,
  //                             //                       fontSize: 11,
  //                             //                       fontWeight: FontWeight.w300),
  //                             //                 ),
  //                             //               ],
  //                             //             ),
  //                             //           ),
  //                             //           Expanded(child: Container()),
  //                             //           Padding(
  //                             //             padding: EdgeInsets.only(
  //                             //                 top: 5.0, right: MySize.size10),
  //                             //             child: Row(
  //                             //               children: [
  //                             //                 Text(
  //                             //                  posts[index]
  //                             //                       .calories
  //                             //                       .toStringAsFixed(1),
  //                             //                   style: TextStyle(
  //                             //                       color: Colors.black,
  //                             //                       fontSize: 13,
  //                             //                       fontWeight: FontWeight.w500),
  //                             //                 ),
  //                             //                 SizedBox(width: 2),
  //                             //                 Text(
  //                             //                   "cal",
  //                             //                   style: TextStyle(
  //                             //                       color: Colors.grey,
  //                             //                       fontSize: 13,
  //                             //                       fontWeight: FontWeight.w300),
  //                             //                 ),
  //                             //               ],
  //                             //             ),
  //                             //           ),
  //                             //         ],
  //                             //       )
  //                             //     ],
  //                             //   ),
  //                             // ),
  //                           ],
  //                         ),
  //                       ),
  //                     );
  //                   });
  //             } else if (snapshot.hasError) {
  //
  //               print('${snapshot.error}');
  //               return Text('${snapshot.error}');
  //             }
  //             return const CircularProgressIndicator();
  //           }),
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget workoutSection(List<ActiveExercisePlans> values) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: MySize.size18),
        child: DDText(
          title: "Today's Workout",
          size: MySize.size12,
        ),
      ),
      if (values == null || values.length == 0)
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20, left: MySize.size18),
          child: DDText(
            title: "No workout planned today",
            size: MySize.size12,
          ),
        ),
      Container(
          height: values.length == 0 ? 0 : 200,
          margin: EdgeInsets.all(10),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: values.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: 200,
                    height: MediaQuery.of(context).size.height * 2,
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => VideoWidget(
                              url: '$videosBaseUrl${values[index].videoFile}',
                              play: true));
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return VideoWidget(
                          //       url: '$videosBaseUrl${values[index].videoFile}',
                          //       play: true);
                          // }));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // GestureDetector(
                                //   onTap: () {
                                //     setState(() {});
                                //     // initialIndex = 0;
                                //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //       return VideoWidget(url:'$videosBaseUrl${values[index].videoFile}', play: true);
                                //     }));
                                //     // Navigator.push(
                                //     //   context,
                                //     //   MaterialPageRoute(
                                //     //     builder: (BuildContext context) => GetUpGoUp(
                                //     //         '$imageBaseUrl${values[index].burnerImage}',
                                //     //         values[index].name,
                                //     //         values[index].planTypeId,
                                //     //         int.parse(values[index].planDuration)),
                                //     //   ),
                                //     // );
                                //   },
                                //   child: Container(
                                //     height: 100,
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.only(
                                //         topLeft: Radius.circular(10),
                                //         topRight: Radius.circular(10),
                                //       ),
                                //       child: Image.network(
                                //         '$imageBaseUrl${values[index].burnerImage}',
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      '$imageBaseUrl${values[index].burnerImage}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                values == null || values.length == 0
                                    ? Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            top: 20, left: MySize.size18),
                                        child: DDText(
                                          title: "No workout planned today",
                                          size: MySize.size12,
                                        ),
                                      )
                                    : Container(
                                        height: values.length == 0 ? 0 : 200,
                                        margin: EdgeInsets.all(10),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: values.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              width: 200,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(() => VideoWidget(
                                                      url:
                                                          '$videosBaseUrl${values[index].videoFile}',
                                                      play: true));
                                                  // Navigator.push(context,
                                                  //     MaterialPageRoute(builder: (context) {
                                                  //   return VideoWidget(
                                                  //       url: '$videosBaseUrl${values[index].videoFile}',
                                                  //       play: true);
                                                  // }));
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     setState(() {});
                                                      //     // initialIndex = 0;
                                                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      //       return VideoWidget(url:'$videosBaseUrl${values[index].videoFile}', play: true);
                                                      //     }));
                                                      //     // Navigator.push(
                                                      //     //   context,
                                                      //     //   MaterialPageRoute(
                                                      //     //     builder: (BuildContext context) => GetUpGoUp(
                                                      //     //         '$imageBaseUrl${values[index].burnerImage}',
                                                      //     //         values[index].name,
                                                      //     //         values[index].planTypeId,
                                                      //     //         int.parse(values[index].planDuration)),
                                                      //     //   ),
                                                      //     // );
                                                      //   },
                                                      //   child: Container(
                                                      //     height: 100,
                                                      //     child: ClipRRect(
                                                      //       borderRadius: BorderRadius.only(
                                                      //         topLeft: Radius.circular(10),
                                                      //         topRight: Radius.circular(10),
                                                      //       ),
                                                      //       child: Image.network(
                                                      //         '$imageBaseUrl${values[index].burnerImage}',
                                                      //         fit: BoxFit.cover,
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        height: 100,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: values[index]
                                                                      .burnerImage ==
                                                                  null
                                                              ? Container()
                                                              : Image.network(
                                                                  '$imageBaseUrl${values[index].burnerImage}',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                10, 10, 0, 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                values[index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black)),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "10 values",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MySize
                                                                            .size4,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(top: 4.0),
                                                                        child:
                                                                            Text(
                                                                          "*",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w300),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "5 sets",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Container()),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 5.0,
                                                                      right: MySize
                                                                          .size10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        values[index]
                                                                            .calories
                                                                            .toStringAsFixed(1),
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              2),
                                                                      Text(
                                                                        "cal",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                              ],
                            ))));
              }))
    ]);
  }
// ############################ PROFILE SECTION #################################

  Container profileSection(ProfileVM profile) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
          left: MySize.size16, top: MySize.size20, right: MySize.size20),
      child: Row(
        children: [
          Row(
            children: [
              profile.imageFile == null
                  ? const CircleAvatar(
                      backgroundColor: Colors.green,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage('$imageBaseUrl${profile.fileName}'),
                    ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(left: MySize.size6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DDText(
                        title: profile.name,
                        size: MySize.size13,
                      ),
                      DDText(
                        title: "",
                        size: MySize.size11,
                        color: Colors.grey,
                        weight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              Get.to(() => FavouriteTabInnerPage());
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return FavouriteTabInnerPage();
              // }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(""),
                Padding(
                  padding: EdgeInsets.only(bottom: MySize.size14),
                  child: Row(
                    children: [
                      DDText(
                        title: "My Favourites",
                        size: MySize.size13,
                      ),
                      SizedBox(
                        width: MySize.size4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Image.asset(
                          "assets/icons/heart_my_favourite.png",
                          width: 10,
                          height: 10,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

// ############################ FUNCTION FOR API HANDLING #################################

// getApiData() async {
//   final provider = Provider.of<DashboardProvider>(context, listen: false);

//   String url = BASE_URL + "dashboard/28";

//   var response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     DashboardModel model = DashboardModel.fromJson(jsonDecode(response.body));

//     provider.setDashboardModel(model);

//     print(IMAGES_URL + model.blogs[0].fileName);
//   }
// }

}
