import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/daily_log_model.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/notifications/notificationhelper.dart';
import 'package:weight_loser/screens/Daily%20Log/Mind_log.dart';
import 'package:weight_loser/screens/Daily%20Log/diet_log.dart';
import 'package:weight_loser/screens/Daily%20Log/exercise_log.dart';
import 'package:weight_loser/screens/Daily%20Log/helpers.dart';
import 'package:weight_loser/screens/Daily%20Log/water_log.dart';
import 'package:weight_loser/screens/SettingScreen/setting_screen.dart';
import 'package:weight_loser/screens/navigation_tabs/DiaryView.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../../Component/DDText.dart';
import '../../CustomWidgets/SizeConfig.dart';
import '../../Service/DashBord Api.dart';
import '../../Service/Responsive.dart';
import '../../models/DashboardModel.dart';
import '../NotificationScreen.dart';
import '../diet_plan_screens/tabs/FavouriteInnerTab.dart';
import '../food_screens/SearchFood.dart';
import 'daily_log_noti_provider.dart';

class DailyLog extends StatefulWidget {
  const DailyLog({Key key}) : super(key: key);

  @override
  State<DailyLog> createState() => _DailyLogState();
}

class _DailyLogState extends State<DailyLog> {
  Future<DailyLogModel> _data;
  DailyLogModel initialData;
  int _selectedIndexForTabBar = 0;
  bool isLoading = true;
  //TabController _tabController;
  int _selectTab = 0;
  TabController innerTabController;
  int selectedIndex = 0;
  DateTime now = DateTime.now();
  int _selectedValue = 0;
  double percent = 0.0;
  PageController pageController = PageController();
  DatePickerController _controller = DatePickerController();
  var _logProvider = getit<dailylognotiprovider>();

  DateTime _selectedDate;
  int value = 0;

  List<DateTime> lastWeektillToday = [];

  var datetime = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch,
      isUtc: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
    print(_selectedDate);

    _selectedValue = now.day - 1;

    //_logProvider?.addListener(UpdateLogDetails);
    super.initState();
    lastWeektillToday = List.generate(
            7, (index) => DateTime(now.year, now.month, now.day - index))
        .reversed
        .toList();

    _data = fetchPreviousDairy(datetime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // drawer: const CustomDrawer(),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       print("Notification Key:" + context.widget.key.toString());
        //       //if (context.widget.key != NotificationScreen().key)
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return FavouriteTabInnerPage();
        //       }));
        //     },
        //     child: Padding(
        //         padding: const EdgeInsets.only(right: 15.0),
        //         child: Image.asset(
        //           ImagePath.heart,
        //           color: Colors.red,
        //         )),
        //   ),
        // ],

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          var datetime;
                          if (value < 6) {
                            value++;
                          }
                          setState(() {
                            print(value);
                            setState(() {
                              _selectedDate = lastWeektillToday[
                                  lastWeektillToday.length - value];
                            });
                            datetime = DateTime.fromMillisecondsSinceEpoch(
                                _selectedDate.millisecondsSinceEpoch,
                                isUtc: true);
                            _selectedDate = datetime;
                            print(
                                "selected Date:" + datetime.toIso8601String());
                            _data = fetchPreviousDairy(datetime);
                          });
                        },
                        child: Container(
                          width: 15,
                          height: 20,
                          child: Center(
                            child: Text(
                              '< ',
                              style: labelStyle(
                                  12, FontWeight.w600, Colors.black38),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${DateFormat('EEEE, dd').format(_selectedDate)}',
                        style: labelStyle(11, FontWeight.w600, Colors.black38),
                      ),
                      GestureDetector(
                        onTap: () {
                          var datetime;
                          if (value > 0) {
                            value--;
                          }
                          setState(() {
                            print(value);
                            setState(() {
                              _selectedDate = lastWeektillToday[
                                  lastWeektillToday.length - value];
                            });
                            datetime = DateTime.fromMillisecondsSinceEpoch(
                                _selectedDate.millisecondsSinceEpoch,
                                isUtc: true);
                            _selectedDate = datetime;
                            print(
                                "selected Date:" + datetime.toIso8601String());
                            _data = fetchPreviousDairy(datetime);
                          });
                        },
                        child: Container(
                          width: 15,
                          height: 20,
                          child: Center(
                            child: Text(
                              ' >',
                              style: labelStyle(
                                  12, FontWeight.w600, Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              /*
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: .15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => SearchFood(false));
                              },
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 1,
                                enabled: false,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: 'Search for any food',
                                  prefixIconConstraints:
                                      BoxConstraints(maxWidth: 40),
                                  isDense: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: .4),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: .4),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey.shade400,
                                      size: 20,
                                    ),
                                  ),
                                  //suffixIcon: Image.asset(
                                  //  'assets/images/camera.png')),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(
                        // width: 10,
                        //),
                        // Image.asset('assets/images/Group 17568.png'),
                      ],
                    ),
                  ),
                ),
              ),
              */
              FutureBuilder<DailyLogModel>(
                future: _data,
                initialData: initialData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      break;
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasError)
                        return Text("No Internet Connectivity");
                      else if (snapshot.hasData) {
                        percent = snapshot.data.budgetVM.consCalories /
                            snapshot.data.budgetVM.targetCalories;
                        return Container(
                          color: Colors.white,
                          child: DefaultTabController(
                            length: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text(
                                    "Budget",
                                    style: labelStyle(
                                        11, FontWeight.w400, Color(0xff23233C)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                goalFoodExerciseCaloriesView(
                                    snapshot.data, 4.0, 26.0, context),
                                diaryPart(context, snapshot.data),
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 25,
                                  child: TabBar(
                                    isScrollable: true,
                                    indicator: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.transparent),
                                        insets: EdgeInsets.symmetric(
                                            horizontal: 30.0)),
                                    indicatorColor: Colors.transparent,
                                    // indicatorSize: TabBarIndicatorSize.values,
                                    //controller: innerTabController,
                                    labelColor: Color(0xffF7D4A6),
                                    labelStyle:
                                        labelStyle(12, regular, lightGrey),
                                    unselectedLabelColor: Color(0xFFAFAFAF),
                                    tabs: <Widget>[
                                      Tab(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/icons/food-cover.png',
                                                color: _selectTab == 0
                                                    ? Color(0xffF7D4A6)
                                                    : Color(0xFFAFAFAF)),
                                            SizedBox(width: 5),
                                            Text("Diet")
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/icons/water-glass (1).png',
                                                color: _selectTab == 0
                                                    ? Color(0xffF7D4A6)
                                                    : Color(0xFFAFAFAF)),
                                            SizedBox(width: 5),
                                            Text("Water")
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/icons/dumbbell.png',
                                                color: _selectTab == 0
                                                    ? Color(0xffF7D4A6)
                                                    : Color(0xFFAFAFAF)),
                                            SizedBox(width: 5),
                                            Text("Exercise")
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/icons/Page-1.png',
                                                color: _selectTab == 0
                                                    ? Color(0xffF7D4A6)
                                                    : Color(0xFFAFAFAF)),
                                            SizedBox(width: 5),
                                            Text("Mind")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  height: 300,
                                  child: TabBarView(
                                    //controller: innerTabController,
                                    children: [
                                      DietLog(
                                        data: snapshot.data,
                                      ),
                                      WaterLog(data: snapshot.data),
                                      ExerciseLog(data: snapshot.data),
                                      MindLog(data: snapshot.data),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else
                        Center(child: Text("No Data Available"));
                  }
                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ));
  }
}

// ############################# Diary View #############################
GestureDetector diaryPart(BuildContext context, DailyLogModel dlm) {
  int water = 0;

  if (dlm.waterList.length > 0) {
    dlm.waterList.forEach((element) {
      water += element.serving;
    });
    water = 250 * water;
  } else
    water = 0;
  return GestureDetector(
    onTap: () {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return SummaryScreen();
      // }));
    },
    child: Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      height: MediaQuery.of(context).size.height * 0.33,
      width: Responsive1.isMobile(context)
          ? MediaQuery.of(context).size.width
          : 400,
      decoration: BoxDecoration(
        color: const Color(0xFFF7D4A6),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/dairy2.jpeg",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(children: [
          diaryItemRow(context, "Calories", '${dlm.budgetVM.consCalories}cal',
              "Water", '$water ml', Icons.local_drink, Icons.water_drop),
          SizedBox(height: 5),
          diaryItemRow(
              context,
              "Proteins",
              '${dlm.budgetVM.protein}g',
              "Exercise",
              '${dlm.budgetVM.burnCalories}cal',
              Icons.egg,
              Icons.sports_gymnastics),
          SizedBox(height: 5),
          diaryItemRow(context, "Carbs", '${dlm.budgetVM.carbs}g', "Mind",
              '0min', Icons.food_bank_sharp, Icons.psychology),
          SizedBox(height: 5),
          diaryItemRow(context, "Fat", '${dlm.budgetVM.fat}g', "Others", "0cal",
              Icons.local_pizza, Icons.more)
        ]),
      ),
    ),
  );
}

Widget diaryItemRow(context, title, val, title2, val2, icon, icon2) {
  return Container(
    padding: EdgeInsets.only(left: 8, top: 14, bottom: 14, right: 8),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DDText(
                  title: title,
                  size: MySize.size15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DDText(
                    title: val,
                    size: MySize.size15,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: 40,
          child: Text(""),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DDText(
                    title: title2,
                    size: MySize.size15,
                  ),
                ),
                DDText(
                  title: val2,
                  size: MySize.size15,
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget goalFoodExerciseCaloriesView(
  DailyLogModel _dbm,
  left,
  right,
  context,
) {
  var mobile = Responsive1.isMobile(context);
  /*
  var carbgauge = _dbm.budgetVM.carbs / _dbm.goalCarbCount;
  var proteingauge = _dbm.budgetVM.protein / _dbm.goalProteinCount;
  var fatgauge = _dbm.budgetVM.fat / _dbm.goalFatCount;
  if (carbgauge > 1) carbgauge = 0.9;
  if (proteingauge > 1) proteingauge = 0.9;
  if (fatgauge > 1) fatgauge = 0.9;
  */
  return Container(
    height: 60,
    margin: EdgeInsets.only(
      left: 20,
    ),
    padding: EdgeInsets.only(
      left: 4,
      right: right,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => BottomBarNew(3)));
        //   },
        //   child: circularProgress("Carbs", const Color(0xffDFBB9D),
        //       _dbm.budgetVM!.carbs!, _dbm.goalCarbCount,context),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => BottomBarNew(3)));
        //   },
        //   child: circularProgress("Fat", const Color(0xffFFD36E),
        //       _dbm.budgetVM!.fat!, _dbm.goalFatCount,context),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => BottomBarNew(3)));
        //   },
        //   child: circularProgress("Protein", const Color(0xffFF8C8C),
        //       _dbm.budgetVM!.protein!, _dbm.goalProteinCount,context),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => BottomBarNew(3)));
        //   },
        //   child: circularProgress("Calories", Colors.blue,
        //       _dbm.budgetVM!.consCalories!, _dbm.budgetVM!.targetCalories!,context),
        // ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DDText(
                  title: "Goal",
                  color: Color(0xff2B2B2B),
                  size: mobile ? 13 : 20,
                  weight: FontWeight.w400,
                ),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Countup(
                      begin: 0,
                      end: _dbm.budgetVM.targetCalories.toDouble(),
                      duration: Duration(seconds: 1),
                      separator: ',',
                      style: GoogleFonts.openSans(
                          fontSize: mobile ? 13 : 18,
                          color: Color(0xff2B2B2B),
                          fontWeight: FontWeight.w300),
                    ),

                    // DDText(
                    //   title: "11,00",
                    //   size: MySize.size15,
                    //   weight:
                    //       FontWeight.w300,
                    // ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  // margin: EdgeInsets.only(left: MySize.size20),
                  width: 34,
                  child: StepProgressIndicator(
                    totalSteps: 100,
                    direction: Axis.horizontal,
                    currentStep: 100,
                    padding: 0,
                    selectedColor: primaryColor,
                    unselectedColor: Colors.black12,
                    // progressDirection: TextDirection.LTR,
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
                  padding: EdgeInsets.only(top: 8, left: 2, right: 0),
                  child: Image.asset("assets/icons/minus.png"),
                ),
                Text("")
              ],
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DDText(
                    title: "Food",
                    color: Color(0xff2B2B2B),
                    size: mobile ? 13 : 20,
                    weight: FontWeight.w400,
                  ),
                  Countup(
                    begin: 0,
                    end: _dbm.budgetVM.consCalories.toDouble(),
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: mobile ? 13 : 18,
                        color: Color(0xff2B2B2B),
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // margin: EdgeInsets.only(left: MySize.size20),
                    width: 36,
                    child: StepProgressIndicator(
                      //totalSteps: 100,
                      totalSteps: _dbm.budgetVM.targetCalories.toInt() == 0
                          ? 10
                          : _dbm.budgetVM.targetCalories.toInt(),
                      direction: Axis.horizontal,
                      currentStep: _dbm.budgetVM.consCalories.toInt() >
                              _dbm.budgetVM.targetCalories.toInt()
                          ? _dbm.budgetVM.targetCalories.toInt()
                          : _dbm.budgetVM.consCalories.toInt(),
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      // progressDirection: TextDirection.LTR,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
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
                  padding:
                      EdgeInsets.only(top: 3, bottom: 10, left: 2, right: 8),
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
                  color: Color(0xff2B2B2B),
                  size: mobile ? 13 : 20,
                  weight: FontWeight.w400,
                ),
                Countup(
                  begin: 0,
                  end: _dbm.budgetVM.burnCalories.toDouble(),
                  duration: Duration(seconds: 1),
                  separator: ',',
                  style: GoogleFonts.openSans(
                      fontSize: mobile ? 13 : 18,
                      color: Color(0xff2B2B2B),
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 10),
                Container(
                  width: 56,
                  child: StepProgressIndicator(
                    // totalSteps: 100,
                    totalSteps: _dbm.budgetVM.targetCalories.toInt() == 0
                        ? 10
                        : _dbm.budgetVM.targetCalories.toInt(),
                    direction: Axis.horizontal,
                    currentStep: _dbm.budgetVM.burnCalories.toInt() >
                            _dbm.budgetVM.targetCalories.toInt()
                        ? _dbm.budgetVM.targetCalories.toInt()
                        : _dbm.budgetVM.burnCalories.toInt(),
                    padding: 0,
                    selectedColor: primaryColor,
                    unselectedColor: Colors.black12,
                    // progressDirection: TextDirection.LTR,
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
                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 6),
                  child: DDText(
                    title: "=",
                    size: 18,
                    color: Colors.grey.shade500,
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
                  color: Color(0xff2B2B2B),
                  size: mobile ? 13 : 20,
                  weight: FontWeight.w400,
                ),
                Countup(
                  begin: 0,
                  end: _dbm.budgetVM.targetCalories.toDouble() != 0
                      ? (_dbm.budgetVM.targetCalories.toDouble() -
                                  (_dbm.budgetVM.consCalories.toDouble() +
                                      _dbm.budgetVM.burnCalories.toDouble())) <
                              0
                          ? 0
                          : (_dbm.budgetVM.targetCalories.toDouble() -
                              (_dbm.budgetVM.consCalories.toDouble() +
                                  _dbm.budgetVM.burnCalories.toDouble()))
                      : 0,
                  duration: Duration(seconds: 1),
                  separator: ',',
                  style: GoogleFonts.openSans(
                      fontSize: mobile ? 13 : 18,
                      color: Color(0xff2B2B2B),
                      fontWeight: FontWeight.w300),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 84,
                      child: StepProgressIndicator(
                        // totalSteps: 100,
                        totalSteps: _dbm.budgetVM.targetCalories.toInt() == 0
                            ? 10
                            : _dbm.budgetVM.targetCalories.toInt(),
                        direction: Axis.horizontal,
                        currentStep: (_dbm.budgetVM.consCalories.toDouble() +
                                        _dbm.budgetVM.burnCalories.toDouble())
                                    .toInt() >
                                _dbm.budgetVM.targetCalories.toInt()
                            ? _dbm.budgetVM.targetCalories.toInt()
                            : (_dbm.budgetVM.consCalories.toDouble() +
                                    _dbm.budgetVM.burnCalories.toDouble())
                                .toInt(),
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        // progressDirection: TextDirection.LTR,
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

class GoalShimmer extends StatelessWidget {
  const GoalShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            top: MySize.size6,
            left: MySize.size4,
            right: MySize.size26,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            duration: Duration(seconds: 1),
                            separator: ',',
                            style: GoogleFonts.openSans(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(height: MySize.size10),
                      SizedBox(
                        width: MySize.size34,
                        child: const StepProgressIndicator(
                          totalSteps: 100,
                          direction: Axis.horizontal,
                          currentStep: 100,
                          padding: 0,
                          selectedColor: primaryColor,
                          unselectedColor: Colors.black12,
                          //progressDirection: TextDirection.ltr,
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
                  Padding(
                    padding: EdgeInsets.only(left: MySize.size20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DDText(
                          title: "Food",
                          size: 15,
                        ),
                        Countup(
                          begin: 0,
                          end: 100,
                          duration: Duration(seconds: 1),
                          separator: ',',
                          style: GoogleFonts.openSans(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: MySize.size10),
                        SizedBox(
                          width: MySize.size36,
                          child: const StepProgressIndicator(
                            totalSteps: 10,
                            direction: Axis.horizontal,
                            currentStep: 2,
                            padding: 0,
                            selectedColor: primaryColor,
                            unselectedColor: Colors.black12,
                            //progressDirection: TextDirection.ltr,
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
                        size: 15,
                      ),
                      Countup(
                        begin: 0,
                        end: 0,
                        duration: Duration(seconds: 1),
                        separator: ',',
                        style: GoogleFonts.openSans(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: MySize.size10),
                      SizedBox(
                        width: MySize.size56,
                        child: const StepProgressIndicator(
                          totalSteps: 10,
                          direction: Axis.horizontal,
                          currentStep: 2,
                          padding: 0,
                          selectedColor: primaryColor,
                          unselectedColor: Colors.black12,
                          //progressDirection: TextDirection.ltr,
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
                          SizedBox(
                            width: MySize.size84,
                            child: const StepProgressIndicator(
                              totalSteps: 10,
                              direction: Axis.horizontal,
                              currentStep: 0,
                              padding: 0,
                              selectedColor: primaryColor,
                              unselectedColor: Colors.black12,
                              //progressDirection: TextDirection.ltr,
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
        ));
  }
}
