import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/notifications/notificationhelper.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../models/daily_log_model.dart';
import '../../notifications/getit.dart';
import 'daily_log_noti_provider.dart';

class DietLog extends StatefulWidget {
  DietLog({Key key, @required this.data}) : super(key: key);
  DailyLogModel data;
  @override
  State<DietLog> createState() => _DietLogState();
}

class _DietLogState extends State<DietLog> {
  double percent = 0.0;
  DailyLogModel _data;

  @override
  void initState() {
    // var _logProvider = getit<dailylognotiprovider>();
    //_data = _logProvider.getDailyLogsData();
    _data = widget.data;
    percent = _data.budgetVM.consCalories / _data.budgetVM.targetCalories;
    if (percent > 1) percent = 0.99999;

    print("percent:" + percent.toString());
    print("percent:" + percent.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Calories Consumed",
            //   style: labelStyle(11, regular, queColor),
            // ),
            // const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       _data!.budgetVM!.consCalories.toString(),
            //       style: labelStyle(15, semiBold, queColor),
            //     ),
            //     Text(
            //         "out of ${_data!.budgetVM!.targetCalories.toString()} cal assigned",
            //         style: labelStyle(13, light, queColor)),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Container(
            //   width: double.infinity,
            //   height: 7,
            //   color: Colors.grey[300],
            //   child: LinearPercentIndicator(
            //     // width: double.infinity,
            //     lineHeight: 5.0,
            //     percent: percent,
            //     padding: const EdgeInsets.all(0),
            //     backgroundColor: Colors.grey[300],
            //     progressColor: const Color(0xFFF7D4A6),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     progressComponent('assets/icons/meat (1).png', "proteins",
            //         "${_data!.budgetVM!.protein} g"),
            //     progressComponent('assets/icons/meat (1).png', "Carbs",
            //         "${_data!.budgetVM!.carbs} g"),
            //     progressComponent('assets/icons/meat (1).png', "Fat",
            //         "${_data!.budgetVM!.fat} g"),
            //     progressComponent('assets/icons/meat (1).png', "Other", "0 g")
            //   ],
            // ),
            // const SizedBox(height: 20),
            Text("BreakFast", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.breakfastList.length, data: _data.breakfastList),
            const SizedBox(height: 20),
            Text("Snack",
                style: labelStyle(
                  11,
                  regular,
                  queColor,
                )),
            const SizedBox(height: 20),
            FoodItemData(value: _data.snackList.length, data: _data.snackList),
            const SizedBox(height: 20),
            Text("Lunch", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.luncheList.length, data: _data.luncheList),
            Text("Dinner", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.dinnerList.length, data: _data.dinnerList),
          ],
        ),
      ),
    );
  }
}

class FoodItemData extends StatefulWidget {
  FoodItemData({Key key, this.value, this.data}) : super(key: key);
  final int value;
  var data;
  @override
  State<FoodItemData> createState() => _FoodItemDataState();
}

class _FoodItemDataState extends State<FoodItemData> {
  @override
  Widget build(BuildContext context) {
    int value = widget.value;
    var data = widget.data;
    return Column(
      children: [
        value == 0
            ? Center(
                child: Container(child: Text("No Data Available")),
              )
            : ListView.builder(
                itemCount: value,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(data[index]
                                                .imageFile !=
                                            null
                                        ? '$imageBaseUrl${data[index].imageFile}'
                                        : 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=600'),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 95,
                                        child: Text("${data[index].fName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: labelStyle(
                                                15, light, queColor)),
                                      ),
                                      Text("250 grams",
                                          style: labelStyle(
                                              11, regular, lightGrey))
                                    ],
                                  ),
                                ],
                              ),
                              Text("${data[index].consCalories} Cal",
                                  style: labelStyle(15, light, queColor))
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: 35.0,
                        child: Container(
                          height: 30,
                          width: 1.0,
                          color: const Color(0xFfF7D4A6),
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        left: 23.0,
                        child: Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            height: 5.0,
                            width: 10.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF7D4A6)),
                                shape: BoxShape.circle,
                                color: const Color(0xFFFFF1DF)),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
      ],
    );
  }
}

class TodayDietLog extends StatefulWidget {
  const TodayDietLog({Key key}) : super(key: key);

  @override
  State<TodayDietLog> createState() => _TodayDietLogState();
}

class _TodayDietLogState extends State<TodayDietLog> {
  double percent = 0.0;
  DailyLogModel _data;
  @override
  void initState() {
    super.initState();
    var _logProvider = getit<todaylognotiprovider>();
    _data = _logProvider.getDailyLogsData();
    percent = _data.budgetVM.consCalories / _data.budgetVM.targetCalories;

    print("percent:" + percent.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calories Consumed",
              style: labelStyle(11, light, queColor),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _data.budgetVM.consCalories.toString(),
                  style: labelStyle(15, semiBold, queColor),
                ),
                Text(
                    "out of ${_data.budgetVM.targetCalories.toString()} cal assigned",
                    style: labelStyle(13, light, queColor)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 7,
              color: Colors.grey[300],
              child: LinearPercentIndicator(
                // width: double.infinity,
                lineHeight: 5.0,
                percent: percent,
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.grey[300],
                progressColor: const Color(0xFFF7D4A6),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressComponent('assets/icons/meat (1).png', "proteins",
                    "${_data.budgetVM.protein} g"),
                progressComponent('assets/icons/meat (1).png', "Carbs",
                    "${_data.budgetVM.carbs} g"),
                progressComponent('assets/icons/meat (1).png', "Fat",
                    "${_data.budgetVM.fat} g"),
                progressComponent('assets/icons/meat (1).png', "Other", "0 g")
              ],
            ),
            const SizedBox(height: 30),
            Text("BreakFast", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.breakfastList.length, data: _data.breakfastList),
            const SizedBox(height: 20),
            Text("Snack",
                style: labelStyle(
                  11,
                  regular,
                  queColor,
                )),
            const SizedBox(height: 20),
            FoodItemData(value: _data.snackList.length, data: _data.snackList),
            const SizedBox(height: 20),
            Text("Lunch", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.luncheList.length, data: _data.luncheList),
            Text("Dinner", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            FoodItemData(
                value: _data.dinnerList.length, data: _data.dinnerList),
          ],
        ),
      ),
    );
  }
}

Widget progressComponent(
  String image,
  String title,
  String subtitle,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Image.asset(image),
      ),
      const SizedBox(width: 5),
      Column(
        children: [
          Text(title, style: labelStyle(11, light, queColor)),
          Text(subtitle, style: labelStyle(11, light, lightGrey))
        ],
      )
    ],
  );
}
