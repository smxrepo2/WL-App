import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/water_model.dart';
import 'package:weight_loser/screens/Daily%20Log/daily_log_noti_provider.dart';

import '../../models/daily_log_model.dart';
import '../../notifications/getit.dart';

class WaterLog extends StatefulWidget {
  WaterLog({Key key, @required this.data}) : super(key: key);
  DailyLogModel data;
  @override
  State<WaterLog> createState() => _WaterLogState();
}

class _WaterLogState extends State<WaterLog> {
  DailyLogModel _data;
  int totalcups = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //var _logProvider = getit<dailylognotiprovider>();

    //_data = _logProvider.getDailyLogsData();
    _data = widget.data;
    _data.waterList.forEach((element) {
      totalcups += element.serving;
    });
    print("water:" + totalcups.toString());

    //setState(() {
    //totalcups;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Water Intake", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text("${totalcups == 0 ? 0 : totalcups}",
                      style: labelStyle(20, semiBold, queColor)),
                  const SizedBox(height: 10),
                  Text(
                      //"Out of ${totalcups == 0 ? 0 + 2 : totalcups + 2} cups of water",
                      "Out of 8 cups of water",
                      style: labelStyle(15, light, queColor)),
                  const SizedBox(height: 30),
                  Image.asset("assets/icons/water-glass.png"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Timeline", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            waterItemData(
              value: _data.waterList.length,
              data: _data.waterList,
              //title: "1 cup at 7:00 am",
            )
          ],
        ),
      ),
    );
  }
}

class TodayWaterLog extends StatefulWidget {
  const TodayWaterLog({Key key}) : super(key: key);

  @override
  State<TodayWaterLog> createState() => _TodayWaterLogState();
}

class _TodayWaterLogState extends State<TodayWaterLog> {
  DailyLogModel _data;
  int totalcups = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _logProvider = getit<todaylognotiprovider>();
    _data = _logProvider.getDailyLogsData();
    _data.waterList.forEach((element) {
      totalcups += element.serving;
    });
    setState(() {
      totalcups;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Water Intake", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text("${totalcups == 0 ? 0 : totalcups}",
                      style: labelStyle(20, semiBold, queColor)),
                  const SizedBox(height: 10),
                  Text(
                      "Out of ${totalcups == 0 ? 0 + 2 : totalcups + 2} cups of water",
                      style: labelStyle(15, light, queColor)),
                  const SizedBox(height: 30),
                  Image.asset("assets/icons/water-glass.png"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Timeline", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            waterItemData(
              value: _data.waterList.length,
              data: _data.waterList,
              //title: "1 cup at 7:00 am",
            )
          ],
        ),
      ),
    );
  }
}

class waterItemData extends StatelessWidget {
  final int value;
  final List<WaterModel> data;
  waterItemData({this.value, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        value == 0
            ? Center(
                child: Text("No Data Available"),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  DateTime date = DateTime.parse(data[index].date);
                  int hours = date.hour;
                  int minutes = date.minute;
                  String timeap = "am";
                  if (hours > 12) timeap = "pm";
                  String time = "$hours:$minutes";
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${data[index].serving} cup at $time $timeap",
                                            style: labelStyle(
                                                15, light, queColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text("${data[index].calories} Cal",
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
                          height: 20,
                          width: 1.0,
                          color: const Color(0xFfF7D4A6),
                        ),
                      ),
                      Positioned(
                        top: 40.0,
                        left: 23.0,
                        child: Container(
                          height: 20.0,
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
                itemCount: value,
              ),
      ],
    );
  }
}
