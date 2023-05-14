import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
// import 'package:fit_kit/fit_kit.dart';
// import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/DashboardProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/constants/strings.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/watches/models/connected_watch_model.dart';
import 'package:weight_loser/watches/models/fitbit.dart';
import 'package:weight_loser/watches/models/withingsData.dart';
import 'package:weight_loser/watches/models/withingsSleepData.dart';
import 'package:weight_loser/watches/providers/connected_watch_provider.dart';
import 'package:weight_loser/watches/screens/connect_watch.dart';

import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../../notifications/getit.dart';
import '../../watches/constants/strings.dart';
import '../../watches/providers/fitbit_provider.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(MySize.size56),
              child: AppBar(
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
                      text: 'Connect Watch',
                    ),
                    Tab(text: 'Stats'),
                  ],
                ),
              ),
            ),
            body: TabBarView(children: [ConnectWatch(), LiveTrackingView()])));
  }
}

class LiveTrackingView extends StatefulWidget {
  LiveTrackingView();

  @override
  _LiveTrackingViewState createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
  var workList = ["Today", "Week", "Month"];
  int counter = 0;
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  TabController _tabController;
  bool isSwitched = false;
  bool isSwitched1 = false;
  String tabtext = "Today";

  double calories = 0, distance = 0;
  int minutes = 0, sleep = 0, heartRate, restHeartRate, caloriesLeft = 0;
  int goalSleep = 0, stepCount = 0;
  List goalhours = [8, 0];
  List sleephours = [0, 0];
  String floors = "";

  var totalCalories = 0;
  //DataType _stepCount, _distance, _calories;
  var provider = getit<connectedwatchprovider>();
  SharedPreferences prefs;
  String token, fitbitId;
  String withingToken;
  String watchType;
  final internalStorage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkPermissions();
    ConnectedWatchModel cwm = provider.getConnectedWatch();
    watchType = cwm.userDevices.device;
    print("Connected Watch: $watchType");
    if (watchType == "FitBit") {
   /*   RefreshFitBitToken().then((value) {
        GetFitbitDailyData();
      });*/
    } else if (watchType == "FitKit") {
      FitKitData(counter);
    } else if (watchType == "Withings") {
      GetWithingsDailyData();
    }
  }

  Future saveWatchData(String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    final response = await post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": 8,
        "SleepTime": time,
        "SleepType": "normal",
        "Burn_Cal": calories
      }),
    );
    print("response:${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Update.');
    }
  }

/*
  Future RefreshFitBitToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fitbitId = prefs.getString('userFitbit');
    token = prefs.getString('accessToken');
    final response = FitbitAuthAPIURL.isTokenValid(fitbitAccessToken: token);
    print("token is:" + response.data);
  }
*/

  ///**************************WithingsData************************************* */

  GetWithingsDailyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    withingToken = prefs.getString('accessTokenWithing');

    Dio dio = Dio();
    Response response;
    WithingsDataModel _withingDataModel;
    WithingsSleepData _withingSleepData;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    FormData formdata = new FormData();

    formdata = FormData.fromMap({
      "action": "getactivity",
      "data_fields":
          "steps,distance,elevation,soft,moderate,intense,active,calories,totalcalories,hr_average,hr_min,hr_max,hr_zone_0,hr_zone_1,hr_zone_2,hr_zone_3",
      "startdateymd": "$formattedDate",
      "enddateymd": "$formattedDate",
    });

    response = await dio.post('${Strings.withingBaseUrl}/v2/measure',
        onSendProgress: (int sent, int total) {},
        data: formdata,
        options: Options(headers: {
          'authorization': 'Bearer $withingToken',
          'accept': 'application/json'
        }));

    if (response.statusCode == 200) {
      print("Withings Response Data:" + response.data.toString());
      _withingDataModel = WithingsDataModel.fromJson(response.data);
    }
    formdata = FormData.fromMap({
      "action": "getsummary",
      "data_fields": Strings.withingSleepDataFields,
      "startdateymd": "$formattedDate",
      "enddateymd": "$formattedDate",
    });

    response = await dio.post('${Strings.withingBaseUrl}/v2/sleep',
        onSendProgress: (int sent, int total) {},
        data: formdata,
        options: Options(headers: {
          'authorization': 'Bearer $withingToken',
          'accept': 'application/json'
        }));

    if (response.statusCode == 200) {
      print("Withings Sleep Response Data:" + response.data.toString());
      _withingSleepData = WithingsSleepData.fromJson(response.data);
    }
    setState(() {
      calories = _withingDataModel.body.activities[0].calories.toDouble();
      distance = _withingDataModel.body.activities[0].distance.toDouble();
      distance = distance / 1000 * 0.62137;
      totalCalories =
          _withingDataModel.body.activities[0].totalcalories.toInt();
      caloriesLeft = totalCalories - calories.toInt();
      stepCount = _withingDataModel.body.activities[0].steps.toInt();
      floors = _withingDataModel.body.activities[0].elevation.toString();
      minutes = _withingDataModel.body.activities[0].active.toInt();
      minutes = (minutes / 60).toInt();
      if (_withingSleepData.body.series.length > 0) {
        sleep = _withingSleepData.body.series[0].data.asleepduration;
        goalSleep = _withingSleepData.body.series[0].data.durationtosleep;
        var d1 = (goalSleep / 60 / 60).toString();
        goalhours = d1.split('.');
        var d2 = (sleep / 60 / 60).toString();
        sleephours = d2.split('.');
      }
    });
  }

  ///**************************FitBitData****************************************** */
  GetFitbitDailyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fitbitId = prefs.getString('userFitbit');
    token = prefs.getString('accessToken');
    print("FitBit UserId:" + fitbitId);
    Dio dio = Dio();
    Response response;
    FitBitActivity _fitbitActivity;
    FitBitFloors _fitbitFloors;
    FitBitSleep _fitbitSleep;
    FitBitGoalSleep _fitbitGoalSleep;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    response = await dio.get(
        "https://api.fitbit.com/1/user/$fitbitId/activities/date/$formattedDate.json",
        options: Options(headers: {
          'authorization': 'Bearer $token',
          'accept': 'application/json'
        }));
    if (response.statusCode == 200) {
      _fitbitActivity = FitBitActivity.fromJson(response.data);
    }

    response = await dio.get(
        "https://api.fitbit.com/1/user/$fitbitId/activities/floors/date/$formattedDate/$formattedDate.json",
        options: Options(headers: {
          'authorization': 'Bearer $token',
          'accept': 'application/json'
        }));
    if (response.statusCode == 200) {
      _fitbitFloors = FitBitFloors.fromJson(response.data);
    }
    response = await dio.get(
        "https://api.fitbit.com/1/user/$fitbitId/sleep/date/$formattedDate.json",
        options: Options(headers: {
          'authorization': 'Bearer $token',
          'accept': 'application/json'
        }));
    if (response.statusCode == 200) {
      _fitbitSleep = FitBitSleep.fromJson(response.data);
    }
    response = await dio.get(
        "https://api.fitbit.com/1/user/$fitbitId/sleep/goal.json",
        options: Options(headers: {
          'authorization': 'Bearer $token',
          'accept': 'application/json'
        }));
    if (response.statusCode == 200) {
      _fitbitGoalSleep = FitBitGoalSleep.fromJson(response.data);
    }

    setState(() {
      calories = _fitbitActivity.summary.caloriesBMR.toDouble();
      distance = _fitbitActivity.summary.distances[0].distance.toDouble();
      distance = distance * 0.62137;
      totalCalories = _fitbitActivity.goals.caloriesOut;
      caloriesLeft = _fitbitActivity.goals.caloriesOut;
      caloriesLeft = caloriesLeft - calories.toInt();
      stepCount = _fitbitActivity.summary.steps.toInt();
      floors = _fitbitFloors.activitiesFloors[0].value;
      minutes = _fitbitActivity.summary.veryActiveMinutes.toInt();
      sleep = _fitbitSleep.summary.totalMinutesAsleep;
      goalSleep = _fitbitGoalSleep.goal.minDuration;
      var d1 = (goalSleep / 60).toString();
      goalhours = d1.split('.');
      var d2 = (sleep / 60).toString();
      sleephours = d2.split('.');
    });
  }

  Future<bool> readFitKitPermissions() async {
    HealthFactory health = HealthFactory();

    // with coresponsing permissions

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    print('requested: $requested');
    if (requested) return true;
  }

  void FitKitData(int period) async {
    bool permissionsGiven = await readFitKitPermissions();
    HealthFactory health = HealthFactory();
    setState(() => _state = AppState.FETCHING_DATA);
    var results;
    if (permissionsGiven) {
      final now = DateTime.now();
      DateTime yesterday;
      if (period == 0) {
        yesterday = DateTime(now.year, now.month, now.day);
      } else if (period == 1) {
        yesterday = DateTime.now().subtract(Duration(days: 7));
      }

      try {
        // fetch health data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(yesterday, now, types);
        // save all the new data points (only the first 100)
        _healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      _healthDataList.forEach((x) {
        print(x.type);

        if (x.type == HealthDataType.DISTANCE_DELTA ||
            x.type == HealthDataType.DISTANCE_WALKING_RUNNING) {
          distance = distance + double.parse(x.value.toString());
        }
        if (x.type == HealthDataType.MOVE_MINUTES ||
            x.type == HealthDataType.EXERCISE_TIME) {
          minutes = minutes + int.parse(x.value.toString());
        }
        if (x.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
          calories = calories + double.parse(x.value.toString());
        }
      });
      setState(() {
        calories = calories * 1000;
        distance = distance / 10000 * 0.62137;
        minutes;
        print("Distance:" + distance.toString());
      });

      try {
        stepCount = await health.getTotalStepsInInterval(yesterday, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }
      print('Total number of steps: $stepCount');
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      setState(() {
        totalCalories = provider.dashboardModel.budgetVM.targetCalories;
        caloriesLeft = totalCalories.toInt() - calories.toInt();
        caloriesLeft < 0 ? caloriesLeft = 0 : caloriesLeft = caloriesLeft;
        stepCount = (stepCount == null) ? 0 : stepCount;
      });

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return liveTrackingBody();
  }

// ############################ BODY #################################

  Widget liveTrackingBody() {
    var mobile = Responsive1.isMobile(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: mobile
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(left: 150, right: 150),
          child: Card(
            elevation: mobile ? 0.8 : 2,
            margin: mobile
                ? EdgeInsets.only(
                    left: MySize.size10,
                    right: MySize.size10,
                    top: MySize.size32)
                : EdgeInsets.all(0),
            child: Column(
              children: [
                // ##############################  TODAY SECTION ################################################################
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: MySize.size14,
                      ),
                      onPressed: () {
                        setState(() {
                          counter++;
                          if (counter == 1) {
                            //  FitKitData(1);
                          }
                          if (counter > 2) {
                            counter = 0;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(MySize.size4),
                      child: DDText(
                        title: workList[counter],
                        size: MySize.size15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: MySize.size14,
                      ),
                      onPressed: () {
                        setState(() {
                          counter++;
                          if (counter == 1) {
                            //FitKitData(1);
                          }
                          if (counter > 2) {
                            counter = 0;
                          }
                        });
                      },
                    ),
                  ],
                ),
                // SizedBox(height: 40),
                // ############################## STEPS PROGRESS  ################################################################

                progressIndicatorView(),
                SizedBox(
                  height: MySize.size20,
                ),
                // ############################## FLOOR, MILES, CALS, MINS VIEW ################################################################

                floorMilesCalculationView(),
                Divider(
                  thickness: 1.5,
                ),
                /*
                Container(
                  padding: EdgeInsets.only(
                      bottom: MySize.size20, top: MySize.size24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: MySize.size40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: MySize.size10),
                                        child: Icon(MdiIcons.heart,
                                            color: Colors.red,
                                            size: MySize.size16)),
                                    DDText(
                                      title: "72",
                                      size: MySize.size20,
                                      weight: FontWeight.w400,
                                    ),
                                    DDText(
                                      title: "bpm",
                                      size: MySize.size13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: MySize.size20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DDText(
                                      title: "5bpm resting heart rate",
                                      size: MySize.size11,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Divider(
                  thickness: 1.5,
                ),
*/
                Container(
                  padding: EdgeInsets.only(
                      bottom: MySize.size20, top: MySize.size24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: MySize.size30),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MySize.size10,
                                          right: MySize.size10),
                                      child: Icon(FontAwesomeIcons.solidMoon,
                                          size: MySize.size16,
                                          color: Color(0xff8576F1)),
                                    ),
                                    DDText(
                                      title: watchType == "none"
                                          ? "0"
                                          : "${goalhours[0]}",
                                      size: MySize.size20,
                                      weight: FontWeight.w400,
                                    ),
                                    DDText(
                                      title: "hr",
                                      size: MySize.size13,
                                    ),
                                    DDText(
                                      title: " ${goalhours[1]}",
                                      size: MySize.size20,
                                      weight: FontWeight.w400,
                                    ),
                                    DDText(
                                      title: "mins",
                                      size: MySize.size13,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: MySize.size20),
                                      child: DDText(
                                          title:
                                              "${sleephours[0]}hr ${sleephours[1]}min sleep",
                                          size: MySize.size11),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(thickness: 1.5),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MySize.size26, top: MySize.size24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: MySize.size40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: MySize.size10),
                                        child: Icon(FontAwesomeIcons.fire,
                                            color: Colors.amber,
                                            size: MySize.size16)),
                                    DDText(
                                        title: "$totalCalories ",
                                        size: MySize.size20,
                                        weight: FontWeight.w400),
                                    DDText(
                                      title: "cals",
                                      size: MySize.size13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: MySize.size20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DDText(
                                        title: "$caloriesLeft calories left",
                                        size: MySize.size11),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (calories != 0 ||
                            sleephours[0] != 0 ||
                            sleephours[1] != 0) {
                          print(sleephours[1]);
                          saveWatchData('${sleephours[0]}:${sleephours[1]}')
                              .then((value) {
                            if (value)
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Watch data saved"),
                                backgroundColor: Colors.green,
                              ));
                          });
                          //print(totalCalories);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("There is no data to upload"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: DDText(
                        title: "Upload Watch Stats",
                        center: true,
                        color: Colors.white,
                        weight: FontWeight.w600,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Fitbit authorize
  /*
  Future<String> authorize(
      {BuildContext context,
      String clientID,
      String clientSecret,
      @required String redirectUri,
      @required String callbackUrlScheme}) async {
    // Instantiate Dio and its Response
    Dio dio = Dio();
    Response response;

    String userID;

    // Generate the fitbit url
    final fitbitAuthorizeFormUrl = FitbitAuthAPIURL.authorizeForm(
        userID: userID, redirectUri: redirectUri, clientID: clientID);

    // Perform authentication
    try {
      final result = await FlutterWebAuth.authenticate(
          url: fitbitAuthorizeFormUrl.url,
          callbackUrlScheme: callbackUrlScheme);
      //Get the auth code
      final code = Uri.parse(result).queryParameters['code'];

      // Generate the fitbit url
      final fitbitAuthorizeUrl = FitbitAuthAPIURL.authorize(
          userID: userID,
          redirectUri: redirectUri,
          code: code,
          clientID: clientID,
          clientSecret: clientSecret);

      response = await dio.post(
        fitbitAuthorizeUrl.url,
        data: fitbitAuthorizeUrl.data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': fitbitAuthorizeUrl.authorizationHeader,
          },
        ),
      );

      // Debugging
      final logger = Logger();
      logger.i('$response');

      // Save authorization tokens
      final accessToken = response.data['access_token'] as String;
      final refreshToken = response.data['refresh_token'] as String;
      print(accessToken);

      userID = response.data['user_id'] as String;
      await FitbitConnector.storage
          .write(key: 'fitbitAccessToken', value: accessToken);
      await FitbitConnector.storage
          .write(key: 'fitbitRefreshToken', value: refreshToken);

      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      print(formattedDate);
      response = await dio.get(
          "https://api.fitbit.com/1/user/$userID/activities/date/$formattedDate.json",
          options: Options(headers: {
            'authorization': 'Bearer $accessToken',
            'accept': 'application/json'
          }));
      cal1 = response.data['summary']['caloriesBMR'];
      distance1 = response.data['summary']['distances'][0]['distance'];
      steps1 = response.data['summary']['steps'];

      print("Cal $cal1  Distance $distance1  Steps $steps1");

      setState(() {
        calories = cal1.toDouble();
        dis = distance1.toDouble();
        step = steps1.toDouble();
      });

      print(response.data);
    } catch (e) {
      print(e);
    } // catch

    return userID;
  }
  */
// ############################ FLOOR, MILES, CALS, MINS #################################

  Row floorMilesCalculationView() {
    print(calories);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(MySize.size8),
          child: Column(
            children: [
              Countup(
                begin: 0,
                end: double.tryParse(floors) ?? 0,
                duration: Duration(seconds: 1),
                separator: ',',
                style: GoogleFonts.openSans(
                    color: Color(0xff4985ef),
                    fontSize: MySize.size15,
                    fontWeight: FontWeight.w400),
              ),
              DDText(
                  title: "Floors",
                  weight: FontWeight.w400,
                  size: MySize.size12),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              distance == 0 ? "0" : "${distance.toStringAsFixed(2)}",
              style: GoogleFonts.openSans(
                  color: Color(0xff4985ef),
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.w400),
            ),
            DDText(title: "Miles", weight: FontWeight.w400, size: MySize.size12)
          ],
        ),
        Column(
          children: [
            Countup(
              begin: 0,
              end: calories ?? 0,
              duration: Duration(seconds: 1),
              separator: ',',
              style: GoogleFonts.openSans(
                  color: Color(0xff4985ef),
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.w400),
            ),
            DDText(title: "Cals", weight: FontWeight.w400, size: MySize.size12),
          ],
        ),
        Column(
          children: [
            Countup(
              begin: 0,
              end: minutes.toDouble(),
              duration: Duration(seconds: 1),
              separator: ',',
              style: GoogleFonts.openSans(
                  color: Color(0xff4985ef),
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.w400),
            ),
            DDText(title: "Mins", weight: FontWeight.w400, size: MySize.size12),
          ],
        ),
      ],
    );
  }

// ############################  CIRCULAR PROGRESS    ###############################

  Widget progressIndicatorView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new CircularPercentIndicator(
          backgroundColor: Color(0xffdedede),
          radius: MySize.size180,
          lineWidth: MySize.size14,
          animation: true,
          percent: (stepCount / 10000) > 0.9 ? 0.9999 : stepCount / 10000,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Countup(
                begin: 0,
                end: stepCount.toDouble() ?? 0,
                duration: Duration(seconds: 1),
                separator: ',',
                style: GoogleFonts.openSans(
                    fontSize: MySize.size26, fontWeight: FontWeight.w600),
              ),
              DDText(
                title: "Steps",
                size: MySize.size19,
              )
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Color(0xff4985ef),
        ),
      ],
    );
  }
}
