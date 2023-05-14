import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/graph_model.dart';
import 'package:weight_loser/models/stats_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/CircleButton.dart';
import 'package:weight_loser/widget/floating_action_button_widget.dart';

class NutritionTabView extends StatefulWidget {
  const NutritionTabView({Key key}) : super(key: key);

  @override
  NutritionTabViewState createState() => NutritionTabViewState();
}

class NutritionTabViewState extends State<NutritionTabView>
    with AutomaticKeepAliveClientMixin<NutritionTabView> {
  @override
  bool get wantKeepAlive => true;

  var dropvalue = "Daily";
  int key = 0;
  var workList = ["Today", "Week", "Month"];
  int counter = 0;

  var quotation =
      "As they say it\'s all in the mind. the better the mind state more likely you succeed";
  int indexOfTab = 0;
  int userid;
  Map<String, double> dataMap;
  int totalFats = 0, totalProtein = 0, totalCarbs = 0;
  double proteinPercent = 0, carbPercent = 0, fatPercent = 0;
  ChartType _chartType = ChartType.disc;

  double _ringStrokeWidth = 50;
  double _chartLegendSpacing = 32;

  bool _showChartValueBackground = false;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  List<Color> colorList = [
    Color(0xff0ABFC8),
    Color(0xffA954B1),
    Color(0xffE55864),
  ];

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
          proteinPercent =
              totalProtein / (totalCarbs + totalFats + totalProtein);
          carbPercent = totalCarbs / (totalCarbs + totalFats + totalProtein);
          fatPercent = totalFats / (totalCarbs + totalFats + totalProtein);
          print("Hello$proteinPercent");
        }

        print(" p$proteinPercent f$fatPercent c$carbPercent");
      });
    }
  }

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

  @override
  void initState() {
    super.initState();
    getTotal(dropvalue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButtonWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<StatsModel>(
            future: fetchStats(dropvalue),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Not ${snapshot.data.targetConsumeCal[0].consCal}");
                return Container(
                  color: Color(0xffF8F8FA),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        headerSection(),
                        pieChartSection(
                          context,
                          snapshot.data,
                        ),
                        if (snapshot.data.foodByCal.isNotEmpty)
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
              return loadingView();
            },
          ),
        ));
  }

  Container headerSection() {
    print("WorkList:" + workList.toString());
    return workList.isNotEmpty
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

  Container pieChartSection(BuildContext context, StatsModel stats) {
    print("cal ${stats.targetConsumeCal}");
    dataMap = {
      "Carbs": carbPercent * 100,
      "Fats": fatPercent * 100,
      "Protein": proteinPercent * 100,
    };
    print("Data Map ${dataMap}");
    return stats != null
        ? Container(
            // padding: EdgeInsets.only(bottom: MySize.size10),
            margin: EdgeInsets.only(left: MySize.size10, right: MySize.size10),
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: MySize.size20,
                  ),
                  Responsive1.isMobile(context)
                      ? PieChart(
                          key: ValueKey(key),
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: _chartLegendSpacing,
                          chartRadius:
                              MediaQuery.of(context).size.width / 3.2 > 500
                                  ? 300
                                  : MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: _chartType,
                          legendOptions: LegendOptions(
                            showLegends: false,
                            legendTextStyle:
                                TextStyle(fontWeight: FontWeight.bold),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: _showChartValueBackground,
                            showChartValues: _showChartValues,
                            decimalPlaces: 0,
                            chartValueStyle: GoogleFonts.openSans(
                                backgroundColor: Colors.transparent,
                                color: Colors.white),
                            showChartValuesInPercentage:
                                _showChartValuesInPercentage,
                            showChartValuesOutside: _showChartValuesOutside,
                          ),
                          ringStrokeWidth: _ringStrokeWidth,
                          emptyColor: Color(0xffE4ECAF),
                          emptyColorGradient: [Colors.green, Colors.red],
                        )
                      : Row(
                          children: [
                            PieChart(
                              key: ValueKey(key),
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: _chartLegendSpacing,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2 > 300
                                      ? 150
                                      : MediaQuery.of(context).size.width / 3.2,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: _chartType,
                              legendOptions: LegendOptions(
                                showLegends: false,
                                legendTextStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground:
                                    _showChartValueBackground,
                                showChartValues: _showChartValues,
                                decimalPlaces: 0,
                                chartValueStyle: GoogleFonts.openSans(
                                    backgroundColor: Colors.transparent,
                                    color: Colors.white),
                                showChartValuesInPercentage:
                                    _showChartValuesInPercentage,
                                showChartValuesOutside: _showChartValuesOutside,
                              ),
                              ringStrokeWidth: _ringStrokeWidth,
                              emptyColor: Color(0xffE4ECAF),
                              emptyColorGradient: [Colors.green, Colors.red],
                            ),
                            SizedBox(width: 100),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    linerprogress(
                                        "Carbs", 0.0, 0, secondaryColor),
                                    SizedBox(width: 20),
                                    linerprogress("Fat", 0.0, 0, purple),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    linerprogress("Protein", 0.0, 0, redColor),
                                    SizedBox(width: 20),
                                    linerprogress(
                                        "Other", 0.0, 0, primaryColor),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                  SizedBox(height: MySize.size30),

                  Visibility(
                    visible: Responsive1.isMobile(context),
                    child: Row(
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
                                    title:
                                        "${(carbPercent * 100).toStringAsFixed(0)}% (${totalCarbs.toStringAsFixed(1)} g)",
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
                                    title:
                                        "${(fatPercent * 100).toStringAsFixed(0)}% (${totalFats.toStringAsFixed(1)} g)",
                                    size: MySize.size12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MySize.size30),
                  Visibility(
                    visible: Responsive1.isMobile(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(bottom: MySize.size16),
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
                                    title:
                                        "${(proteinPercent * 100).toStringAsFixed(0)}% (${totalProtein.toStringAsFixed(1)} g)",
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
                                    padding:
                                        EdgeInsets.only(bottom: MySize.size16),
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
                  ),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  Divider(),
                  dataRowView(
                      "Total Calories",
                      stats.foodSum.length > 0
                          ? stats.foodSum[0].consCalories
                          : 0),
                  // Divider(),
                  // dataRowView(
                  //     "Net Calories",
                  //     stats.targetConsumeCal.length > 0
                  //         ? stats.targetConsumeCal[0].consCal
                  //         : 0),
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
          )
        : Container();
  }

  Column linerprogress(title, percent, total, color) {
    print('$percent + $total +$title');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DDText(
          title: title,
          size: MySize.size15,
          weight: FontWeight.bold,
        ),
        DDText(
          title:
              "${(percent * 100).toStringAsFixed(0)}% (${total.toStringAsFixed(1)} g)",
          size: MySize.size16,
        ),
        LinearPercentIndicator(
          width: 250.0,
          lineHeight: 8.0,
          percent: percent,
          animation: true,
          // percent: _food.carbs /
          //     (_food.carbs + _food.fat + _food.protein),
          linearStrokeCap: LinearStrokeCap.roundAll,
          backgroundColor: Colors.grey[300],
          progressColor: color,
        ),
      ],
    );
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
                  child: dataRowView("Highest in Calories",
                      items[items.length - 1].consCalories,
                      titleBold: true),
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

  Widget loadingView() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: true,
          child: Container(
            padding: EdgeInsets.only(bottom: MySize.size20, top: MySize.size20),
            // color: Colors.red,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(left: MySize.size26),
                  child: DDText(
                      title: workList[counter],
                      size: MySize.size15,
                      weight: FontWeight.w300),
                ),
                Expanded(flex: 1, child: Container()),
                DropdownButton<String>(
                  isDense: true,
                  underline: SizedBox(),
                  // isExpanded: true,
                  value: null,
                  items: <String>[].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: DDText(
                        title: value,
                        weight: FontWeight.w300,
                        size: MySize.size15,
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {},
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  // color: Colors.red,
                  height: 240,
                ),
                Container(
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
                        title: 'Highest in Calories',
                        size: MySize.size12,
                        weight: FontWeight.bold,
                      ),
                      DDText(
                        title: '0',
                        size: MySize.size12,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
