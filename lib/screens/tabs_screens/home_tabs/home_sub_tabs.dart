import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_loser/CoreApi/Urls.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/models/HomeScreenModel.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/circlechartwidget.dart';

class HomeSubTabs extends StatefulWidget {
  HomeSubTabs();

  @override
  _HomeSubTabsState createState() => _HomeSubTabsState();
}

class _HomeSubTabsState extends State<HomeSubTabs> {
  String tabBarText = 'Daily';
  bool loading = true;
  HomeScreenModel homeScreenModel;

  @override
  void initState() {
    getApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            height: Get.height * 0.7,
            width: Get.width * 0.9,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            width: Get.width * .82,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                      ),
                    ),
                    height: Get.height * .05,
                    width: Get.width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              tabBarText = 'Daily';
                            });
                          },
                          child: Container(
                              height: Get.height * .04,
                              width: Get.width * .2,
                              decoration: BoxDecoration(
                                  border: tabBarText == 'Daily'
                                      ? Border(
                                          bottom: BorderSide(
                                              width: 3, color: primaryColor))
                                      : Border()),
                              child: Text(
                                'Daily',
                                style: darkText14Px,
                                textAlign: TextAlign.center,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              tabBarText = 'Weekly';
                            });
                          },
                          child: Container(
                              height: Get.height * .04,
                              width: Get.width * .2,
                              decoration: BoxDecoration(
                                  border: tabBarText == 'Weekly'
                                      ? Border(
                                          bottom: BorderSide(
                                              width: 3, color: primaryColor))
                                      : Border()),
                              child: Text(
                                'Weekly',
                                style: darkText14Px,
                                textAlign: TextAlign.center,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              tabBarText = 'Monthly';
                            });
                          },
                          child: Container(
                              height: Get.height * .04,
                              width: Get.width * .2,
                              decoration: BoxDecoration(
                                  border: tabBarText == 'Monthly'
                                      ? Border(
                                          bottom: BorderSide(
                                              width: 3, color: primaryColor))
                                      : Border()),
                              child: Text(
                                'Monthly',
                                style: tabStyle,
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width * .72,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '<',
                            style: darkText16Px,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Today',
                              style: darkText16Px.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            '>',
                            style: darkText16Px,
                          )
                        ],
                      ),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: Stack(
                          children: [
                            Graph(0,0,0),
                            Positioned(
                                right: 0,
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      totalCalInCircleValue,
                                      style: style.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                          fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Cal',
                                      style: style.copyWith(fontSize: 14),
                                    ),
                                  ],
                                ))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                child: StepProgressIndicator(
                                  totalSteps: 100,
                                  direction: Axis.vertical,
                                  currentStep: 60,
                                  padding: 0,
                                  selectedColor: secondaryColor,
                                  unselectedColor: Colors.black12,
                                  progressDirection: TextDirection.rtl,
                                  //selectedSize: 10.0,
                                  // roundedEdges: Radius.elliptical(6, 30),
                                ),
                              ),
                              Text(
                                ' 11%',
                                style: bodyText,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${homeScreenModel.budgetVm.carbs}',
                                style: TextStyle(color: secondaryColor),
                              ),
                              Text(
                                'Carb',
                                style: bodyText,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                child: StepProgressIndicator(
                                  totalSteps: 100,
                                  direction: Axis.vertical,
                                  currentStep: 40,
                                  padding: 0,
                                  selectedColor: pinkColor,
                                  unselectedColor: Colors.black12,
                                  progressDirection: TextDirection.rtl,
                                  //selectedSize: 10.0,
                                  // roundedEdges: Radius.elliptical(6, 30),
                                ),
                              ),
                              Text(
                                ' 02%',
                                style: bodyText,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${homeScreenModel.budgetVm.fat}',
                                style: TextStyle(color: pinkColor),
                              ),
                              Text(
                                'Fat',
                                style: bodyText,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                child: StepProgressIndicator(
                                  totalSteps: 100,
                                  direction: Axis.vertical,
                                  currentStep: 90,
                                  padding: 0,
                                  selectedColor: purple,
                                  unselectedColor: Colors.black12,
                                  progressDirection: TextDirection.rtl,
                                  //selectedSize: 10.0,
                                  // roundedEdges: Radius.elliptical(6, 30),
                                ),
                              ),
                              Text(
                                ' 87%',
                                style: bodyText,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${homeScreenModel.budgetVm.protein}',
                                style: TextStyle(color: purple),
                              ),
                              Text(
                                'Protein',
                                style: bodyText,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: Get.width * .82,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'carbohydrates',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '167.24',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '193-300',
                                      style: bodyTextFez,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: LinearPercentIndicator(
                                width: Get.width * .76,
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 5.0,
                                percent: 0.8,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: Get.width * .82,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'carbohydrates',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '167.24',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '193-300',
                                      style: bodyTextred,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: LinearPercentIndicator(
                                width: Get.width * .76,
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 5.0,
                                percent: 0.8,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: pinkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: Get.width * .82,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width * .7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'carbohydrates',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '167.24',
                                      style: bodyText,
                                    ),
                                    Text(
                                      '193-300',
                                      style: bodyTextpurple,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            LinearPercentIndicator(
                              width: Get.width * .76,
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 5.0,
                              percent: 0.8,
                              linearStrokeCap: LinearStrokeCap.butt,
                              progressColor: purple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Future<void> getApiData() async {
    DateTime dateTime = DateTime.now();
    int days = daysInMonth(dateTime);

    var currentDate = intl.DateFormat("yyyy-MM-dd").format(dateTime);
    print("Current date: $currentDate  ---- days $days");

    String url = BASE_URL +
        "routine/getbyuser?userId=1&start_date=$currentDate&days=$days";

    var response = await http.get(Uri.parse(url));

    setState(() {
      loading = false;
    });

    print("Response code: ${response.statusCode} ---body: ${response.body}");

    if (response.statusCode == 200) {
      homeScreenModel = HomeScreenModel.fromJson(jsonDecode(response.body));
    }
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}
