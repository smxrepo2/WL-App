import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weight_loser/models/selfie_model.dart';

import 'package:weight_loser/models/user_profile_data.dart';
import 'package:weight_loser/screens/dashboardRevised/methods.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../CustomWidgets/SizeConfig.dart';
import '../../Service/Responsive.dart';
import '../../utils/AppConfig.dart';
import '../../constants/constant.dart';
import '../../models/user_dashboard_report.dart';
import '../../models/user_goal_data.dart' as userGoals;
import '../exercise_screens/LineChartSyncFusion.dart';

class DashboardRevised extends StatefulWidget {
  const DashboardRevised({Key key}) : super(key: key);

  @override
  State<DashboardRevised> createState() => _DashboardRevisedState();
}

class _DashboardRevisedState extends State<DashboardRevised> {
  Future<UserProfileData> _userProfileData;
  Future<UserDashboardReport> _userDashboardReport;
  Future<SelfieModel> _userSelfieModel;
  UserProfileData userProfileData;
  UserDashboardReport userDashboardReport;
  final List<ChartData> chartData = <ChartData>[
    //ChartData(DateTime(2022, 8, 18), 87),
    //ChartData(DateTime(2022, 8, 24), 85),
    //ChartData(DateTime(2022, 8, 31), 84),
    //ChartData(DateTime(2022, 9, 7),  82),
    //ChartData(DateTime(2022, 9, 14), 80),
    //ChartData(DateTime(2022, 9, 21), 79),
    //ChartData(DateTime(2022, 9, 28), 78),
  ];

  final List<ChartData> bmi = <ChartData>[
    ChartData(DateTime(2022, 8, 18), 84),
    ChartData(DateTime(2022, 8, 24), 83),
    ChartData(DateTime(2022, 8, 31), 82),
    ChartData(DateTime(2022, 9, 7), 81),
    ChartData(DateTime(2022, 9, 14), 80),
    ChartData(DateTime(2022, 9, 21), 80),
    ChartData(DateTime(2022, 9, 28), 80),
  ];

  final List<ChartData> target = <ChartData>[];

  @override
  void initState() {
    super.initState();
    //average();
    chartData.clear();
    target.clear();
    _userProfileData = fetchUserProfileData();
    _userDashboardReport = fetchDashboardReport();
    _userSelfieModel = fetchUserSelfies();
  }

  //List<int> weeklyWeight = [90, 87, 84, 82, 80, 79, 78];
  double weeklyAverage = 0;

  /*
  void average() {
    double temp = 0;
    for (int i = 0; i < weeklyWeight.length - 1; i++) {
      int diff = weeklyWeight[i] - weeklyWeight[i + 1];
      temp += diff;
    }
    temp = temp / weeklyWeight.length;
    setState(() {
      weeklyAverage = temp;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        //appBar: AppBar(
        //elevation: 0.1,
        //iconTheme: IconThemeData(color: Colors.grey),
        //backgroundColor: const Color(0xffffffff),
        /*
          title: Text(
            'Dashboard',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
              color: const Color(0xff797a7a),
            ),
            softWrap: false,
          ),
          actions: [],
        */
        //),
        body: FutureBuilder<UserProfileData>(
          future: _userProfileData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userProfileData = snapshot.data;
              //var dateFormat = DateFormat("dd/MM/yyyy");
              //var joining = dateFormat
              //  .format(userProfileData.profileVMs.joiningDate)
              //.toString();
              //print("Joining:" + joining);
              DateTime joining =
                  DateTime.parse(userProfileData.profileVMs.joiningDate);
              joining =
                  DateFormat('yyyy-mm-dd').parse(joining.toIso8601String());
              String formattedDate =
                  '${joining.day}.${joining.month}.${joining.year}';

              return FutureBuilder<UserDashboardReport>(
                future: _userDashboardReport,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    userDashboardReport = snapshot.data;

                    weeklyAverage = double.parse(userDashboardReport
                        .weightHistoryVM.avgWeight
                        .toString());
                    /*
                    List<Goals> goals =
                        userDashboardReport.weightHistoryVM.goals;
                    DateTime goalDate = DateTime.parse(goals[0].createdAt);
                    goalDate = goalDate
                        .subtract(Duration(days: 49 - (7 * goals.length)));

                    if (goals.length < 7) {
                      target.add(ChartData(
                          goalDate.add(Duration(days: 7)),
                          double.parse(userDashboardReport
                              .weightHistoryVM.goals.last.goalWeight
                              .toString())));
                      target.add(ChartData(
                          DateTime.parse(userDashboardReport
                                  .weightHistoryVM.goals.last.createdAt)
                              .add(Duration(days: 7)),
                          double.parse(userDashboardReport
                              .weightHistoryVM.goals.last.goalWeight
                              .toString())));
                      for (int i = 0; i < 7 - goals.length; i++) {
                        if (goalDate
                                .compareTo(DateTime.parse(goals[0].createdAt)) <
                            0) {
                          goalDate = goalDate.add(Duration(days: 7));
                          chartData.add(ChartData(goalDate, 0));
                        }
                      }
                    } else {
                      target.add(ChartData(
                          DateTime.parse(userDashboardReport
                              .weightHistoryVM.goals.first.createdAt),
                          double.parse(userDashboardReport
                              .weightHistoryVM.goals.last.goalWeight
                              .toString())));
                      target.add(ChartData(
                          DateTime.parse(userDashboardReport
                                  .weightHistoryVM.goals.last.createdAt)
                              .add(Duration(days: 7)),
                          double.parse(userDashboardReport
                              .weightHistoryVM.goals.last.goalWeight
                              .toString())));
                    }
                    var currentGoal = goals[goals.length - 1].goalWeight;
                    userDashboardReport.weightHistoryVM.goals
                        .forEach((element) {
                      chartData.add(ChartData(DateTime.parse(element.createdAt),
                          double.parse(element.currentWeight.toString())));
                    });

                    chartData.add(ChartData(
                        DateTime.parse(goals[goals.length - 1].createdAt)
                            .add(Duration(days: 7)),
                        double.parse((userDashboardReport
                                    .weightHistoryVM.goals.last.currentWeight -
                                1)
                            .toString())));
*/
                    //print(chartData.toList().toString());

                    double goalBurnCal = double.parse(
                        userDashboardReport.goalBurnCal.toString());
                    goalBurnCal = goalBurnCal / userDashboardReport.totalDays;
                    print("Average goal burn cal:$goalBurnCal");

                    double goalBurnperc = double.parse(
                            userDashboardReport.avgCalCount.toString()) /
                        goalBurnCal;

                    double exTotalVideos = double.parse(
                        userDashboardReport.exTotatVideos.toString());
                    exTotalVideos =
                        exTotalVideos / userDashboardReport.totalDays;
                    ;
                    double exTotalVideosPerc = double.parse(userDashboardReport
                            .avgExerciseVideoCount
                            .toString()) /
                        exTotalVideos;
                    if (exTotalVideosPerc >= 1) exTotalVideosPerc = 0.99999;
                    if (goalBurnperc >= 1) goalBurnperc = 0.99999;
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Joined on $formattedDate',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 11,
                                    color: const Color(0xff797a7a),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  softWrap: false,
                                ),
                                /*
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Reset Stats',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 11,
                                      color: const Color(0xff4885ed),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.right,
                                    softWrap: false,
                                  ),
                                )
                                */
                              ],
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            Container(
                              // height: height / 7,
                              decoration: BoxDecoration(
                                // shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 10.0, top: 15),
                                child: Column(children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '$imageBaseUrl${userProfileData.profileVMs.fileName}'),
                                            radius: 30,
                                          ),
                                          Text(
                                            '${userProfileData.profileVMs.userName}',
                                            style: GoogleFonts.openSans(
                                              //fontFamily: 'Open Sans',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff2b2b2b),
                                            ),
                                            softWrap: false,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        height: 60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${userProfileData.streakLevel == "" ? "Streak Day 1" : userProfileData.streakLevel}',
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 11,
                                                color: const Color(0xff23233C),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              softWrap: false,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 8,
                                                    child: Image.asset(
                                                        'assets/icons/diamond.png')),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${userProfileData.customerPackage} Plan',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 11,
                                                    fontWeight: regular,
                                                    color:
                                                        const Color(0xff23233c),
                                                  ),
                                                  softWrap: false,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      /*
                                      Container(
                                        height: 70,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // SizedBox(
                                            //   height: ,
                                            // ),
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/black-belt.png'),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Black Belt',
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 11,
                                                color: const Color(0xff797a7a),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              textAlign: TextAlign.right,
                                              softWrap: false,
                                            )
                                          ],
                                        ),
                                      ),
                                      */
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //   MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       '85%',
                                  //       style: labelStyle(11, medium, queColor),
                                  //     ),
                                  //     Text("15 for next level ",
                                  //         style:
                                  //         labelStyle(11, light, queColor)),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 2.5),
                                  //   width: double.infinity,
                                  //   height: 7,
                                  //   color: Colors.grey[300],
                                  //   child: LinearPercentIndicator(
                                  //     linearStrokeCap: LinearStrokeCap.round,
                                  //     // width: double.infinity,
                                  //     lineHeight: 5.0,
                                  //     percent: 0.9,
                                  //     padding: const EdgeInsets.all(0),
                                  //     backgroundColor: Color(0xffF4F4F4),
                                  //     progressColor: Color(0xff4885ED),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ]),
                              ),
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                              thickness: 1.7,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Weight Progress',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: 10),
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.grey)),
                              height: 150,
                              child: FutureBuilder<userGoals.UserGoalData>(
                                future: fetchGraphData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //print(snapshot.data.goals.last);

                                    var seen = Set<String>();
                                    List<userGoals.Goals> goals = snapshot
                                        .data.goals
                                        .where((element) =>
                                            seen.add(element.createdAt))
                                        .toList();
                                    print('goals: ${goals[0].goalWeight}');
                                    return LineChartSyncFusion(
                                      goals: goals,
                                      goalweight: userProfileData
                                          .profileVMs.goalWeight
                                          .toDouble(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('unable to load graph'),
                                    );
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey,
                                    enabled: true,
                                    child: Container(
                                      height: 200,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Compliance',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MultipleCircularProgress(userDashboardReport),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                progressComponent(
                                    'assets/icons/food-cover.png',
                                    "${userDashboardReport.userDietAvgScore}%",
                                    "Diet"),
                                progressComponent(
                                    'assets/icons/dumbbell.png',
                                    "${userDashboardReport.avgExerciseVideoCount}%",
                                    "Exercise"),
                                progressComponent(
                                    'assets/icons/Page-1.png',
                                    "${userDashboardReport.mindAvgVideoCount}%",
                                    "Mind"),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Average Water Intake',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${userDashboardReport.avgWaterCount.toStringAsFixed(2)} ',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 13,
                                          color: const Color(0xff2b2b2b),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'cups daily',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 13,
                                          color: const Color(0xff2b2b2b),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                // userDashboardReport!.totalWaterCount == 0
                                //     ? 1
                                //     : userDashboardReport!.totalWaterCount,
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (userDashboardReport.totalWaterCount == 0)
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                          'assets/images/water-glass.png'),
                                    );
                                  else
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                          'assets/images/water-glass.png'),
                                    );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Daily Sleep Average',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                doubleText("${userDashboardReport.sleepcount}"),
                                if (userDashboardReport.sleepHistory.length >=
                                    1)
                                  DailySleepAvgComponent(
                                      userDashboardReport
                                                  .sleepHistory[0].sleepType ==
                                              "Deep Sleep"
                                          ? "assets/icons/sleeping.png"
                                          : "assets/icons/Group 22740.png",
                                      "${userDashboardReport.sleepHistory[0].sleepType}",
                                      calcualteSleepTime(userDashboardReport
                                          .sleepHistory[0].sleepTime)),
                                if (userDashboardReport.sleepHistory.length >=
                                    2)
                                  DailySleepAvgComponent(
                                      userDashboardReport
                                                  .sleepHistory[1].sleepType ==
                                              "Deep Sleep"
                                          ? "assets/icons/sleeping.png"
                                          : "assets/icons/Group 22740.png",
                                      "${userDashboardReport.sleepHistory[1].sleepType}",
                                      calcualteSleepTime(userDashboardReport
                                          .sleepHistory[0].sleepTime)),
                                if (userDashboardReport.sleepHistory.length >=
                                    3)
                                  DailySleepAvgComponent(
                                      userDashboardReport
                                                  .sleepHistory[2].sleepType ==
                                              "Deep Sleep"
                                          ? "assets/icons/sleeping.png"
                                          : "assets/icons/Group 22740.png",
                                      "${userDashboardReport.sleepHistory[0].sleepType}",
                                      calcualteSleepTime(userDashboardReport
                                          .sleepHistory[2].sleepTime))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 3,
                              color: Colors.grey[300],
                              child: LinearPercentIndicator(
                                // width: double.infinity,
                                lineHeight: 5.0,
                                percent: calculateAvgSleepProgress(
                                    userDashboardReport),
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.blue[100],
                              ),
                            ),
                            SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Average Calories Consumed',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  circularProgress(
                                      "Carbs",
                                      Color(0xffDFBB9D),
                                      userDashboardReport.carbCount,
                                      userDashboardReport.calCount,
                                      context),
                                  circularProgress(
                                      "Fat",
                                      Color(0xffFFD36E),
                                      userDashboardReport.fatCount,
                                      userDashboardReport.calCount,
                                      context),
                                  circularProgress(
                                      "Protein",
                                      Color(0xffFF8C8C),
                                      userDashboardReport.proteinCount,
                                      userDashboardReport.calCount,
                                      context),
                                  circularProgress("Sodium", Color(0xffE6D1F8),
                                      0, 0, context),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(color: Colors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Avg.',
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 10,
                                    color: const Color(0xff797a7a),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${userDashboardReport.calCount}',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 13,
                                          color: queColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'cal',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 13,
                                          color: queColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            /*
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Average Steps',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextImageComponent('assets/icons/Group 22735.png',
                                '8119', '11899 is the highest'),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              height: 4,
                              color: Colors.grey[300],
                              child: LinearPercentIndicator(
                                // width: double.infinity,
                                lineHeight: 5.0,
                                percent: 0.9,
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.green[100],
                              ),
                            ),
                            */
                            SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Average Exercise Done',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Avg.',
                                  style: labelStyle(11, light, queColor),
                                ),
                                // Text("Completion Rate ",
                                //   style: labelStyle(11, light, queColor)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${double.parse(userDashboardReport.avgCalCount.toString()).toStringAsFixed(0)} cal',
                                  style: labelStyle(13, medium, black),
                                ),
                                /*
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        "${goalBurnCal.toStringAsFixed(0)} cal",
                                        style: labelStyle(13, medium, black)),

                                    /*
                                    Text(
                                      " / ",
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 16),
                                    ),
                                    Text(
                                        "${double.parse(userDashboardReport.avgExerciseVideoCount.toString()).toStringAsFixed(0)}%",
                                        style: labelStyle(13, medium, black)),
                                        */
                                  ],
                                ),*/
                                /*
                                Text(
                                  '${double.parse(exTotalVideos.toString()).toStringAsFixed(0)}%',
                                  style: labelStyle(13, medium, black),
                                ),
                                */
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            MultiLineBars(
                                width, goalBurnperc, exTotalVideosPerc),
                            SizedBox(
                              height: height / 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ultimate Selfie',
                                style: GoogleFonts.openSans(
                                  fontSize: 11,
                                  fontWeight: regular,
                                  color: const Color(0xff23233C),
                                ),
                                softWrap: false,
                              ),
                            ),
                            SizedBox(height: 20),
                            FutureBuilder<SelfieModel>(
                                future: _userSelfieModel,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.ultimateSelfies.length >
                                        0)
                                      return UltimateSefieComponent(
                                          context, snapshot.data);
                                    else
                                      return Center(child: Text("No Selfies"));
                                  }
                                  return CircularProgressIndicator();
                                })
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

Widget MultiLineBars(width, goalBurnPerc, exTotalVideosPerc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 310,
        height: 4,
        color: Colors.grey[300],
        child: LinearPercentIndicator(
          // width: double.infinity,
          lineHeight: 5.0,
          percent: goalBurnPerc,
          padding: const EdgeInsets.all(0),
          //backgroundColor: Colors.grey[300],
          progressColor: Color(0xffFF8C8C),
        ),
      ),
      /*
      SizedBox(
        width: 5,
      ),
      Container(
        width: 30,
        height: 4,
        color: Colors.grey[300],
        child: LinearPercentIndicator(
          // width: double.infinity,
          lineHeight: 5.0,
          percent: 1.0,
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey[300],
          progressColor: Colors.yellow,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        width: 140,
        height: 4,
        color: Colors.grey[300],
        child: LinearPercentIndicator(
          // width: double.infinity,
          lineHeight: 5.0,
          percent: exTotalVideosPerc,
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.grey[300],
          progressColor: Colors.green[300],
        ),
      ),
      */
    ],
  );
}

Widget circularProgress(text, color, count, cal, BuildContext context) {
  double percent = count / cal;
  //if (percent > 1) percent = percent / 10;
  //if (percent > 10) percent = percent / 100;
  if (percent > 1) percent = 0.999999;
  print('here is percent $percent');
  return CircularPercentIndicator(
    radius: MediaQuery.of(context).size.width * 0.2,
    lineWidth: 6.0,
    percent: percent.isNaN ? 0 : percent,
    circularStrokeCap: CircularStrokeCap.round,
    center: new Text(
      '$text\n${count}g',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
      ),
    ),
    progressColor: color,
    backgroundColor: Color(0xffE9E9E9),
  );
}

Widget TextImageComponent(var image, String title, String subTitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 15,
                color: const Color(0xff23233c),
              )),
          Image.asset('$image')
        ],
      ),
      Text(
        subTitle,
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 11,
          color: const Color(0xff2b2b2b),
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.right,
        softWrap: false,
      ),
    ],
  );
}

Widget doubleText(
  String title,
) {
  var splitTitle;
  var hour, minute;

  print("SleepCount:$title");
  splitTitle = title.split(':');
  hour = splitTitle[0];
  minute = splitTitle[1];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${hour}h ${minute}min',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 15,
            color: const Color(0xff23233c),
          )),
    ],
  );
}

Widget progressComponent(
  String image,
  String title,
  String subtitle,
) {
  return Row(
    children: [
      Image.asset(image),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: labelStyle(11, medium, queColor)),
          Text(subtitle, style: labelStyle(11, light, lightGrey))
        ],
      )
    ],
  );
}

Widget DailySleepAvgComponent(
  String image,
  String title,
  String subtitle,
) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Image.asset(image),
      ),
      const SizedBox(width: 7),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: labelStyle(11, light, queColor)),
          Text(subtitle, style: labelStyle(11, light, lightGrey))
        ],
      )
    ],
  );
}

Widget UltimateSefieComponent(context, SelfieModel selfies) {
  var dateFormat = DateFormat("dd/MM/yyyy");
  DateTime firstdate = DateTime.parse(selfies.ultimateSelfies[0].dated);
  DateTime seconddate = DateTime.parse(selfies
      .ultimateSelfies[selfies.ultimateSelfies.length - 1].dated
      .toString());

  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // padding: EdgeInsets.only(right: 2),
              height: MediaQuery.of(context).size.height / 3,
              width: Responsive1.isMobile(context)
                  ? MediaQuery.of(context).size.width / 2
                  : 300,
              child: Image.network(
                '${selfies.imagePath}${selfies.ultimateSelfies[0].imageName}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 2, right: 0),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                '${selfies.imagePath}${selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1].imageName}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Weight:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${selfies.ultimateSelfies[0].weight}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'kg',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Waist:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "${selfies.ultimateSelfies[0].waist}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'in',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Text(
                        "${firstdate.day}.${firstdate.month}.${firstdate.year}",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Container(
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Weight:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: selfies
                                      .ultimateSelfies[
                                          selfies.ultimateSelfies.length - 1]
                                      .weight
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'kg',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Waist:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: selfies
                                      .ultimateSelfies[
                                          selfies.ultimateSelfies.length - 1]
                                      .waist
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'in',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date:',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                      Text(
                        "${seconddate.day}.${seconddate.month}.${seconddate.year}",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 30),
      Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'LEMON MILK',
            fontSize: 14,
            color: const Color(0xff23233c),
          ),
          children: [
            if ((selfies.ultimateSelfies[0].weight -
                    selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1]
                        .weight) >
                0)
              TextSpan(
                text: 'You gained ',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              )
            else if ((selfies.ultimateSelfies[0].weight -
                    selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1]
                        .weight) ==
                0)
              TextSpan(
                text: "Your weight did't change ",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              )
            else
              TextSpan(
                text: 'Congratulation you lost ',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            if ((selfies.ultimateSelfies[0].weight -
                    selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1]
                        .weight) !=
                0)
              TextSpan(
                text:
                    "${'${(selfies.ultimateSelfies[0].weight - selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1].weight).abs()}'}",
                style: TextStyle(
                  color: const Color(0xff4885ed),
                  fontWeight: FontWeight.w500,
                ),
              ),
            if ((selfies.ultimateSelfies[0].weight -
                    selfies.ultimateSelfies[selfies.ultimateSelfies.length - 1]
                        .weight) !=
                0)
              TextSpan(
                text: ' kg',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
          ],
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.center,
        softWrap: false,
      )
    ],
  );
}

String calcualteSleepTime(String sleepTime) {
  var splitavg = sleepTime.split(':');
  return '${splitavg[0]}h ${splitavg[1]}min';
}

double calculateAvgSleepProgress(UserDashboardReport userdbm) {
  String avgsleep = userdbm.sleepcount;
  var splitavg = avgsleep.split(':');
  int avgminutes = (int.parse(splitavg[0]) * 60) + int.parse(splitavg[1]);
  double percent = avgminutes / 4800 * 10;
  if (percent > 1) percent = 0.999999;
  print("Sleep Percent:$percent");
  return percent;
}

Widget MultipleCircularProgress(UserDashboardReport dbr) {
  double diet = double.parse(dbr.userDietAvgScore.toString());
  double exe = double.parse(dbr.avgExerciseVideoCount.toString());
  double mind = double.parse(dbr.mindAvgVideoCount.toString());
  double totalavg = (diet + exe + mind) / 3;
  bool progressWidth = false;

  diet = diet / 100;
  exe = exe / 100;
  mind = mind / 100;
  if (diet <= 0 && mind <= 0 && exe <= 0) {
    progressWidth = true;
  }
  return Stack(
    children: [
      CircularPercentIndicator(
          radius: 100.0,
          lineWidth: progressWidth ? 6.0 : 11.0,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          curve: Curves.easeInOutCubic,
          percent: mind,
          center: new Text(""),
          progressColor: Color(0xffC1E2FF),
          backgroundColor: Color(0xffE9E9E9)),
      CircularPercentIndicator(
        radius: 100.0,
        lineWidth: 11.0,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        curve: Curves.easeInOutCubic,
        startAngle: mind < 0.05
            ? 25
            : mind < 0.1
                ? 40
                : mind < 0.15
                    ? 60
                    : mind < 0.2
                        ? 80
                        : mind < 0.25
                            ? 100
                            : mind < 0.3
                                ? 120
                                : mind < 0.35
                                    ? 140
                                    : mind < 0.4
                                        ? 160
                                        : mind < 0.45
                                            ? 180
                                            : mind < 0.5
                                                ? 200
                                                : mind < 0.55
                                                    ? 220
                                                    : mind < 0.6
                                                        ? 240
                                                        : mind < 0.65
                                                            ? 260
                                                            : mind < 0.7
                                                                ? 280
                                                                : mind < 0.75
                                                                    ? 300
                                                                    : mind < 0.8
                                                                        ? 320
                                                                        : mind <
                                                                                0.85
                                                                            ? 340
                                                                            : mind < 0.9
                                                                                ? 360
                                                                                : mind < 0.95
                                                                                    ? 380
                                                                                    : 400,
        percent: exe,
        center: new Text(""),
        progressColor: exe > 0 ? Color(0xffCBECE5) : Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 11.0,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          curve: Curves.easeInOutCubic,
          startAngle: mind + exe < 0.05
              ? 25
              : mind + exe < 0.1
                  ? 40
                  : mind + exe < 0.15
                      ? 60
                      : mind + exe < 0.2
                          ? 80
                          : mind + exe < 0.25
                              ? 100
                              : mind + exe < 0.3
                                  ? 120
                                  : mind + exe < 0.35
                                      ? 140
                                      : mind + exe < 0.4
                                          ? 160
                                          : mind + exe < 0.45
                                              ? 180
                                              : mind + exe < 0.5
                                                  ? 200
                                                  : mind + exe < 0.55
                                                      ? 220
                                                      : mind + exe < 0.6
                                                          ? 240
                                                          : mind + exe < 0.65
                                                              ? 260
                                                              : mind + exe < 0.7
                                                                  ? 280
                                                                  : mind + exe <
                                                                          0.75
                                                                      ? 300
                                                                      : mind + exe <
                                                                              0.8
                                                                          ? 320
                                                                          : mind + exe <
                                                                                  0.85
                                                                              ? 340
                                                                              : mind + exe <
                                                                                      0.9
                                                                                  ? 360
                                                                                  : mind + exe <
                                                                                          0.95
                                                                                      ? 380
                                                                                      : 400,
          percent: diet,
          center: new Text("Total Avg.\n${totalavg.toStringAsFixed(2)}%",
              textAlign: TextAlign.center),
          progressColor: diet > 0 ? Color(0xffF7D4A6) : Colors.transparent,
          backgroundColor: Colors.transparent),
    ],
  );
}

Widget weightChart(context, chartData, bmi, weeklyAverage,
    List<ChartData> target, currentweight) {
  bool checked = false;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 15),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(right: 20, bottom: 8),
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Weekly Avg.\n", style: labelStyle(11, light, queColor)),
          TextSpan(
            text:
                '${double.parse(weeklyAverage.toString()).toStringAsFixed(2)} Kg',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ])),
      ),
      Stack(
        children: [
          // dashed blue horizontal line
          Transform.translate(
            offset: Offset(40, 40),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final boxWidth = constraints.constrainWidth();
                  const dashWidth = 7.5;
                  final dashHeight = 1.5;
                  final dashCount = (boxWidth / (2 * dashWidth)).floor();
                  return Flex(
                    children: List.generate(dashCount, (_) {
                      return SizedBox(
                        width: dashWidth,
                        height: dashHeight,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.blue),
                        ),
                      );
                    }),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: SfCartesianChart(
                primaryXAxis: DateTimeCategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    dateFormat: DateFormat.MMMd(),
                    interval: 1),
                // primaryYAxis: CategoryAxis(isVisible: false),
                // plotAreaBorderWidth: 0,
                onMarkerRender: (MarkerRenderArgs args) {
                  print("renderning markers");
                  if (args.pointIndex == 0 ||
                      args.pointIndex == chartData.length - 1) {
                    print("inside circles");
                    if (args.seriesIndex == 0) {
                      args.borderColor = Colors.purpleAccent;
                      args.color = Colors.purple[100];
                    } else {
                      args.borderColor = Colors.green;
                      args.color = Colors.green[100];
                    }
                    args.borderWidth = 1;
                    args.markerWidth = 10;
                    args.markerHeight = 10;
                    args.shape = DataMarkerType.circle;
                  } else {
                    args.markerWidth = 0;
                    args.markerHeight = 0;
                  }
                  if (chartData[args.pointIndex].y == currentweight) {
                    print("inside Triangle");
                    args.borderColor = Colors.red;
                    args.color = Colors.red[100];
                    args.borderWidth = 1;
                    args.markerWidth = 15;
                    args.markerHeight = 15;
                    args.shape = DataMarkerType.triangle;
                  }
                },
                series: <ChartSeries>[
                  SplineSeries<ChartData, DateTime>(
                      isVisibleInLegend: false,
                      dataSource: chartData,
                      color: Colors.purpleAccent,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                      ),
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Templating the data label
                          builder: (dynamic data, dynamic point, dynamic series,
                              int pointIndex, int seriesIndex) {
                            print("PointIndex:$pointIndex");
                            return pointIndex == 0
                                ? Container(
                                    height: 30,
                                    width: 100,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Starting Weight\n',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10)),
                                        TextSpan(
                                          text:
                                              data.y.toString().split('.')[0] +
                                                  ' ' +
                                                  'Kg',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ])),
                                    ),
                                  )
                                : pointIndex == chartData.length - 2
                                    ? Container(
                                        height: 30,
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Current Weight\n',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10)),
                                            TextSpan(
                                              text: data.y
                                                      .toString()
                                                      .split('.')[0] +
                                                  ' ' +
                                                  'Kg',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ])),
                                        ),
                                      )
                                    : Container();
                          }),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y),
                ]),
          ),
        ],
      ),
    ],
  );
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
/*
Widget MultipleCircularProgress() {
  return SfRadialGauge(axes: <RadialAxis>[
    // Create primary radial axis
    RadialAxis(
      minimum: 0,
      maximum: 100,
      showLabels: false,
      showTicks: false,
      startAngle: 270,
      endAngle: 270,
      radiusFactor: 0.7,
      axisLineStyle: AxisLineStyle(
        thickness: 0.2,
        color: const Color.fromARGB(30, 0, 169, 181),
        thicknessUnit: GaugeSizeUnit.factor,
      ),
      pointers: <GaugePointer>[
        RangePointer(
          value: 0.7,
          width: 0.05,
          pointerOffset: 0.07,
          sizeUnit: GaugeSizeUnit.factor,
        )
      ],
    ),
    // Create secondary radial axis for segmented line
    RadialAxis(
      minimum: 0,
      interval: 1,
      maximum: 4,
      showLabels: false,
      showTicks: true,
      showAxisLine: false,
      tickOffset: -0.05,
      offsetUnit: GaugeSizeUnit.factor,
      minorTicksPerInterval: 0,
      startAngle: 270,
      endAngle: 270,
      radiusFactor: 0.7,
      majorTickStyle: MajorTickStyle(
          length: 0.3,
          thickness: 3,
          lengthUnit: GaugeSizeUnit.factor,
          color: Colors.white),
    )
  ]);
}
*/

