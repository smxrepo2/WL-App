import 'dart:convert';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/models/stats_model.dart';
import 'package:weight_loser/screens/dashboardRevised/dashboard_revised.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/exercise_screens/WeightDetails.dart';
import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/nutrition_tab_view.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CircleButton.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/floating_action_button_widget.dart';

class NutritionScreenView extends StatefulWidget {
  @override
  _NutritionScreenViewState createState() => _NutritionScreenViewState();
}

class _NutritionScreenViewState extends State<NutritionScreenView>
    with TickerProviderStateMixin {
  TabController _tabBarController;
  TabController innerTabController;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind')
  ];

  var _indexOfTab = 0;

  @override
  void initState() {
    _tabBarController = new TabController(vsync: this, length: myTabs.length);
    innerTabController = new TabController(vsync: this, length: 2);

    print(_tabBarController.length);
    // print(DefaultTabController.of(context).index);
    super.initState();
    getTotal(dropvalue);
  }

  var dropvalue = "Daily";
  Map<String, double> dataMap;

  List<Color> colorList = [
    Color(0xff0ABFC8),
    Color(0xffA954B1),
    Color(0xffE55864),
  ];

  ChartType _chartType = ChartType.disc;

  double _ringStrokeWidth = 50;
  double _chartLegendSpacing = 32;

  bool _showChartValueBackground = false;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  int key = 0;
  var workList = ["Today", "Week", "Month"];
  int counter = 0;

  var quotation =
      "As they say it\'s all in the mind. the better the mind state more likely you succeed";
  int indexOfTab = 0;
  int userid;
  Future<StatsModel> fetchStats(String duration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse(
          '$apiUrl/api/history/foodbycal?userId=$userid&duration=${duration.toLowerCase()}'),
    );

    if (response.statusCode == 200) {
      return StatsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  double carbs, fat, protein;
  int totalFats = 0, totalProtein = 0, totalCarbs = 0;
  double proteinPercent = 0, carbPercent = 0, fatPercent = 0;

  getTotal(String duration) async {
    print(duration);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse(
          '$apiUrl/api/history/foodbycal?userId=$userid&duration=${duration.toLowerCase()}'),
    );

    if (response.statusCode == 200) {
      print("Hi");
      StatsModel _stats = StatsModel.fromJson(jsonDecode(response.body));

      _stats.foodSum.forEach((element) {
        print(element.fat.toInt());
        setState(() {
          totalFats += element.fat.toInt();
          totalProtein += element.protein.toInt();
          totalCarbs += element.carbs.toInt();
          print("Well$totalCarbs");
        });
      });
      setState(() {
        if (totalCarbs == 0 && totalProtein == 0 && totalFats == 0) {
          print("null total nutrients");
        } else {
          print("c:-$totalCarbs  f:-$totalFats  p:-$totalProtein");
          var total = totalCarbs + totalFats + totalProtein;
          print("Total  $total");
          proteinPercent = totalProtein / total;
          carbPercent = totalCarbs / total;
          fatPercent = totalFats / total;
          print(
              "p${proteinPercent * 100}  f${fatPercent * 100} c${carbPercent * 100}");
          protein = proteinPercent * 100;
          fat = fatPercent * 100;
          carbs = carbPercent * 100;
          print("p${protein.round()}  f${fat.round()} c${carbs.round()}");

          //ToDo old logic
          /* proteinPercent = totalProtein / (totalCarbs + totalFats + totalProtein);
          carbPercent = totalCarbs / (totalCarbs + totalFats + totalProtein);
          fatPercent = totalFats / (totalCarbs + totalFats + totalProtein);*/

          print("Hello$proteinPercent");
        }

        print(" p$proteinPercent f$fatPercent c$carbPercent");
      });
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: TabBar(
            controller: innerTabController,
            indicatorColor: Color(0xff4885ED),
            labelColor: Color(0xff4885ED),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black87,
            labelPadding: EdgeInsets.only(right: 4),
            labelStyle: TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontFamily: "Open Sans",
              fontWeight: FontWeight.w400,
            ),
            tabs: [
              Tab(text: "User Stats"),
              Tab(text: "Weight Stats"),
            ],
          ),
        ),
        Expanded(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: MySize.size22),
            child: TabBarView(
              controller: innerTabController,
              children: <Widget>[
                //NutritionTabView(),
                DashboardRevised(),
                WeightDetails(),
              ],
            ),
          ),
        )
      ],
    );
    // return DefaultTabController(
    //   length: 4,
    //   child: Scaffold(
    //       drawer: CustomDrawer(),
    //       appBar: customAppBar(
    //         context,
    //         elevation: 0.5,
    //         tabBar: TabBar(
    //             onTap: (index) {
    //               setState(() {
    //                 _indexOfTab = index;
    //               });
    //               print(indexOfTab);
    //             },
    //             controller: _tabBarController,
    //             labelPadding: EdgeInsets.only(left: MySize.size4),
    //             indicatorColor: _indexOfTab == 0
    //                 ? Colors.transparent
    //                 : _indexOfTab == 1
    //                     ? Colors.blue
    //                     : Colors.blue,
    //             labelColor: _indexOfTab == 0 ? Colors.black : Color(0xff4885ED),
    //             indicatorSize: TabBarIndicatorSize.label,
    //             unselectedLabelColor: Colors.black87,
    //             tabs: myTabs),
    //       ),
    //       backgroundColor: Colors.white,
    //       body: Column(
    //         children: [
    //           Expanded(
    //             child: TabBarView(
    //               controller: _tabBarController,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Container(
    //                       height: 40,
    //                       child: TabBar(
    //                         controller: innerTabController,
    //                         indicatorColor: Color(0xff4885ED),
    //                         labelColor: Color(0xff4885ED),
    //                         indicatorSize: TabBarIndicatorSize.label,
    //                         unselectedLabelColor: Colors.black87,
    //                         labelPadding: EdgeInsets.only(right: 4),
    //                         labelStyle: TextStyle(
    //                           fontSize: 11,
    //                           color: Colors.black54,
    //                           fontFamily: "Open Sans",
    //                           fontWeight: FontWeight.w400,
    //                         ),
    //                         tabs: [
    //                           Tab(text: "Nutrition"),
    //                           Tab(text: "Weight Stats"),
    //                         ],
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Container(
    //                         // padding: EdgeInsets.symmetric(horizontal: MySize.size22),
    //                         child: TabBarView(
    //                           controller: innerTabController,
    //                           children: <Widget>[
    //                             NutritionTabView(),
    //                             WeightDetails(),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 DietTabView(),
    //                 RunningTabView(),
    //                 MindTabView(),
    //               ],
    //             ),
    //           )
    //         ],
    //       )),
    // );
  }

  Widget nutritionTab() {
    return FutureBuilder<StatsModel>(
      future: fetchStats(dropvalue),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Color(0xffF8F8FA),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  headerSection(),
                  pieChartSection(context, snapshot.data),
                  foodDetailsSection(snapshot.data.foodByCal)
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('No Internet Connectivity'),
          );
        }

        // By default, show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget foodDetailsSection(List<FoodByCal> items) {
    items.sort((a, b) => a.consCalories.compareTo(b.consCalories));
    return Container(
      margin: EdgeInsets.only(
          left: MySize.size10, right: MySize.size10, bottom: MySize.size20),
      child: Card(
          elevation: 0.5,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: dataRowView("Highest in Calories", 0, titleBold: true),
                ),
                if (items.length > 0) Divider(),
                if (items.length > 0)
                  dataRowView(items[0].fName, items[0].consCalories),
                if (items.length > 1) Divider(),
                if (items.length > 1)
                  dataRowView(items[1].fName, items[1].consCalories),
                if (items.length > 2) Divider(),
                if (items.length > 2)
                  dataRowView(items[2].fName, items[2].consCalories),
                Divider(
                  height: 10,
                  color: Colors.transparent,
                )
              ],
            ),
          )),
    );
  }

  Container pieChartSection(BuildContext context, StatsModel stats) {
    print(dataMap);
    dataMap = {
      "Carbs": carbPercent * 100,
      "Fats": fatPercent * 100,
      "Protein": proteinPercent * 100,
    };

    if (stats != null) {
      return Container(
        // padding: EdgeInsets.only(bottom: MySize.size10),
        margin: EdgeInsets.only(left: MySize.size10, right: MySize.size10),
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              PieChart(
                key: ValueKey(key),
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: _chartLegendSpacing,
                chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 3.2,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: _chartType,
                legendOptions: LegendOptions(
                  showLegends: false,
                  legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: _showChartValueBackground,
                  showChartValues: _showChartValues,
                  decimalPlaces: 0,
                  chartValueStyle: GoogleFonts.openSans(
                      backgroundColor: Colors.transparent, color: Colors.white),
                  showChartValuesInPercentage: _showChartValuesInPercentage,
                  showChartValuesOutside: _showChartValuesOutside,
                ),
                ringStrokeWidth: _ringStrokeWidth,
                emptyColor: Colors.grey,
                emptyColorGradient: [
                  Color(0xff6c5ce7),
                  Colors.blue,
                ],
              ),
              SizedBox(height: MySize.size30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: MySize.size16),
                        child: Column(
                          children: [
                            CircleButton(
                              color: colorList[0],
                              onTap: () => print("Cool"),
                              iconData: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySize.size10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Carbs",
                              size: MySize.size12,
                            ),
                            DDText(
                              title: "${totalCarbs.toStringAsFixed(1)} g",
                              //title: "${carbs.round()}% (${totalCarbs.toStringAsFixed(1)} g)",
                              //title: "${carbPercent.toStringAsFixed(1)}% (${totalCarbs.toStringAsFixed(1)} g)",
                              size: MySize.size12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MySize.size60,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: MySize.size16),
                        child: Column(
                          children: [
                            CircleButton(
                              color: colorList[1],
                              onTap: () => print("Cool"),
                              iconData: null,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySize.size10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Fat",
                              size: MySize.size12,
                            ),
                            DDText(
                              title: "${totalFats.toStringAsFixed(1)} g",
                              // title: "${fat.round()}% (${totalFats.toStringAsFixed(1)} g)",
                              // title: "${fatPercent.toStringAsFixed(1)}% (${totalFats.toStringAsFixed(1)} g)",
                              size: MySize.size12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MySize.size30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: MySize.size40),
                            padding: EdgeInsets.only(bottom: MySize.size10),
                            child: CircleButton(
                              color: colorList[2],
                              onTap: () => print("Cool"),
                              iconData: null,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySize.size10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DDText(
                              title: "Protein",
                              size: MySize.size12,
                            ),
                            DDText(
                              title: "${totalProtein.toStringAsFixed(1)} g",
                              // title: "${protein.round()}% (${totalProtein.toStringAsFixed(1)} g)",
                              // title: "${proteinPercent.toStringAsFixed(1)}% (${totalProtein.toStringAsFixed(1)} g)",
                              size: MySize.size12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MySize.size60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MySize.size32),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: MySize.size16),
                              child: CircleButton(
                                color: Colors.blue,
                                onTap: () => print("Cool"),
                                iconData: null,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MySize.size10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DDText(
                                title: "Other",
                                size: MySize.size12,
                              ),
                              DDText(
                                title: "0% (0 g)",
                                size: MySize.size12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MySize.size10,
              ),
              Divider(),
              dataRowView(
                  "Total Calories",
                  stats.targetConsumeCal.length > 0
                      ? stats.targetConsumeCal[0].consCal
                      : 0),
              Divider(),
              dataRowView(
                  "Net Calories",
                  stats.targetConsumeCal.length > 0
                      ? stats.targetConsumeCal[0].consCal
                      : 0),
              Divider(),
              dataRowView(
                  "Goal",
                  stats.targetConsumeCal.length > 0
                      ? stats.targetConsumeCal[0].targetCal
                      : 0),
              Divider(
                height: 10,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Container headerSection() {
    return workList.length > 0
        ? Container(
            padding: EdgeInsets.only(bottom: MySize.size20, top: MySize.size20),
            color: Colors.white,
            // color: Colors.red,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(left: MySize.size26),
                  child: DDText(
                      title: workList[counter],
                      size: MySize.size15,
                      color: Color(0xff2B2B2B),
                      weight: FontWeight.w300),
                ),
                Expanded(flex: 1, child: Container()),
                DropdownButton<String>(
                  isDense: true,
                  underline: SizedBox(),
                  // isExpanded: true,
                  value: dropvalue,
                  items: <String>[
                    'Daily',
                    'Weekly',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: DDText(
                        title: value,
                        weight: FontWeight.w300,
                        size: MySize.size15,
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      dropvalue = value;
                    });
                  },
                ),
              ],
            ),
          )
        : Container();
  }

  Widget dataRowView(title, int calories, {titleBold}) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size15,
        right: MySize.size15,
        bottom: MySize.size15,
        top: MySize.size15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DDText(
            title: title,
            size: MySize.size12,
            weight: titleBold == true ? FontWeight.bold : FontWeight.normal,
          ),
          DDText(
            title: calories.toString(),
            size: MySize.size12,
          )
        ],
      ),
    );
  }

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
}
