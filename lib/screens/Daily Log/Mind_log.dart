import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import '../../models/daily_log_model.dart';
import 'diet_log.dart';

class MindLog extends StatefulWidget {
  MindLog({Key key, @required this.data}) : super(key: key);
  DailyLogModel data;
  @override
  State<MindLog> createState() => _MindLogState();
}

class _MindLogState extends State<MindLog> {
  DailyLogModel _data;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            Text("Sleep", style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("7h 8min", style: labelStyle(15, semiBold, queColor)),
                Text("out of 8 hours of sleep",
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
                percent: 0.50,
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.grey[300],
                progressColor: const Color(0xFFCBECE5),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressComponent(
                    'assets/icons/sleeping.png', "Deep Sleep", "1h 2min"),
                progressComponent('assets/icons/Layer_x0020_1.png',
                    "Light Sleep", "5h 47min"),
                progressComponent(
                    'assets/icons/charge.png', "Naps", "1h 18min"),
              ],
            ),
            */
            const SizedBox(height: 30),
            Text("Mind Relaxing Exercise",
                style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            MindItemData(value: _data.userMindVideos.length, data: _data)
          ],
        ),
      ),
    );
  }
}

class TodayMindLog extends StatefulWidget {
  const TodayMindLog({Key key}) : super(key: key);

  @override
  State<TodayMindLog> createState() => _TodayMindLogState();
}

class _TodayMindLogState extends State<TodayMindLog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sleep", style: labelStyle(11, light, queColor)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("7h 8min", style: labelStyle(15, semiBold, queColor)),
                Text("out of 8 hours of sleep",
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
                percent: 0.50,
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.grey[300],
                progressColor: const Color(0xFFCBECE5),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressComponent(
                    'assets/icons/sleeping.png', "Deep Sleep", "1h 2min"),
                progressComponent('assets/icons/Layer_x0020_1.png',
                    "Light Sleep", "5h 47min"),
                progressComponent(
                    'assets/icons/charge.png', "Naps", "1h 18min"),
              ],
            ),
            const SizedBox(height: 30),
            Text("Mind Relaxing Exercise",
                style: labelStyle(11, regular, queColor)),
            const SizedBox(height: 20),
            MindItemData(
              value: 2,
            )
          ],
        ),
      ),
    );
  }
}

class MindItemData extends StatelessWidget {
  final int value;
  final DailyLogModel data;

  MindItemData({this.value, this.data});

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
                                    backgroundImage: NetworkImage(
                                        '$imageBaseUrl${data.userMindVideos[index].imageFile}'),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          data.userMindVideos[index].title ??
                                              "No Title",
                                          style:
                                              labelStyle(15, light, queColor)),
                                      Text(
                                          "${data.userMindVideos[index].duration} min",
                                          style: labelStyle(
                                              11, regular, lightGrey))
                                    ],
                                  ),
                                ],
                              ),
                              //Text("Redo", style: labelStyle(11, light, primaryColor))
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
