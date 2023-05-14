import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/exercise_item_model.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../models/daily_log_model.dart';
import '../../notifications/getit.dart';
import 'daily_log_noti_provider.dart';
import 'diet_log.dart';

class ExerciseLog extends StatefulWidget {
  ExerciseLog({Key key, @required this.data}) : super(key: key);
  DailyLogModel data;
  @override
  State<ExerciseLog> createState() => _ExerciseLogState();
}

class _ExerciseLogState extends State<ExerciseLog> {
  DailyLogModel _data;
  double burncalories = 0;
  double percent = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //var _logProvider = getit<dailylognotiprovider>();
    //_data = _logProvider.getDailyLogsData();
    _data = widget.data;
    //_data.userExcerciseList.forEach((element) {
    //burncalories += element.burnCalories;
    //});
    burncalories = double.parse(_data.budgetVM.burnCalories.toString());
    percent = burncalories / _data.budgetVM.targetCalories;
    if (percent > 1) percent = 0.999999;
    print("Percent:" + percent.toString());

    //setState(() {
    //burncalories;
    //percent = burncalories / _data.budgetVM.targetCalories;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Calories Burnt", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${burncalories == 0 ? 0 : burncalories.toStringAsFixed(0)} cal",
                    style: labelStyle(15, semiBold, queColor)),
                Text("out of ${_data.budgetVM.targetCalories} cal assigned",
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
                progressColor: const Color(0xFFCBECE5),
              ),
            ),
            /*
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressComponent(
                    'assets/icons/cardio.png', "Cardio", "210 cal"),
                progressComponent(
                    'assets/icons/incline-push-up.png', "Aerobic", "147 cal"),
                progressComponent(
                    'assets/icons/weights.png', "Weights", "80 cal"),
                progressComponent('assets/icons/more.png', "Other", "120 cal")
              ],
            ),
            */
            const SizedBox(height: 30),
            Text("Morning", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            ExItemData(
                value: _data.userExcerciseList.length,
                data: _data.userExcerciseList),
          ],
        ),
      ),
    );
  }
}

class TodayExerciseLog extends StatefulWidget {
  const TodayExerciseLog({Key key}) : super(key: key);

  @override
  State<TodayExerciseLog> createState() => _TodayExerciseLogState();
}

class _TodayExerciseLogState extends State<TodayExerciseLog> {
  DailyLogModel _data;
  double burncalories = 0;
  double percent = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _logProvider = getit<todaylognotiprovider>();
    _data = _logProvider.getDailyLogsData();
    //_data.userExcerciseList.forEach((element) {
    //burncalories += element.burnCalories;
    //});
    burncalories = double.parse(_data.budgetVM.burnCalories.toString());
    percent = burncalories / _data.budgetVM.targetCalories;
    if (percent > 1) percent = 0.999999;
    //percent = burncalories / _data.budgetVM.targetCalories;
    //setState(() {
    //burncalories;
    //percent = burncalories / _data.budgetVM.targetCalories;
    //});
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
            Text("Calories Burnt", style: labelStyle(11, light, queColor)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${burncalories == 0.0 ? 0 : burncalories.toStringAsFixed(0)} cal",
                    style: labelStyle(15, semiBold, queColor)),
                Text("out of ${_data.budgetVM.targetCalories} cal assigned",
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
                progressColor: const Color(0xFFCBECE5),
              ),
            ),
            /*
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressComponent(
                    'assets/icons/cardio.png', "Cardio", "210 cal"),
                progressComponent(
                    'assets/icons/incline-push-up.png', "Aerobic", "147 cal"),
                progressComponent(
                    'assets/icons/weights.png', "Weights", "80 cal"),
                progressComponent('assets/icons/more.png', "Other", "120 cal")
              ],
            ),
            */
            const SizedBox(height: 30),
            Text("Morning", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            ExItemData(
                value: _data.userExcerciseList.length,
                data: _data.userExcerciseList),
          ],
        ),
      ),
    );
  }
}

class ExItemData extends StatelessWidget {
  final int value;
  List<ExceriseModel> data;

  ExItemData({this.value, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        value == 0
            ? Center(
                child: Text("No Data is Available"),
              )
            : ListView.builder(
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
                                  // const CircleAvatar(
                                  //   radius: 40,
                                  //   backgroundImage:
                                  //       AssetImage(ImagePath.runTab),
                                  // ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${data[index].exName}",
                                          style:
                                              labelStyle(15, light, queColor)),
                                      Text("${data[index].duration} mins",
                                          style: labelStyle(
                                              11, regular, lightGrey))
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Calories Burned",
                                      style: labelStyle(11, regular, queColor)),
                                  Text("${data[index].burnCalories} Cal",
                                      style: labelStyle(11, light, queColor))
                                ],
                              )
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
                          color: const Color(0xFfCBECE5),
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
                                    Border.all(color: const Color(0xFFCBECE5)),
                                shape: BoxShape.circle,
                                color: const Color(0xFFF6FDFC)),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: value,
              ),
      ],
    );
  }
}
