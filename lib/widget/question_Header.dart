import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/constants/constant.dart';
class questionHeader extends StatelessWidget {
  int queNo;
  double percent;
  Color color;
  questionHeader({this.queNo,this.percent,this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                print("tapped");
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '$queNo/$totalQuestion',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Container()
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 5,
          color: Colors.grey[300],
          child: LinearPercentIndicator(
            // width: double.infinity,
            lineHeight: 5.0,
            percent: percent,

            padding: EdgeInsets.all(0),
            backgroundColor: Colors.grey[300],
            progressColor:color,
          ),
        ),
      ],
    );
  }
}

class questionHeaderSimple extends StatelessWidget {
  double percent;
  Color color;
  questionHeaderSimple({this.percent,this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                print("tapped");
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 5,
          color: Colors.grey[300],
          child: LinearPercentIndicator(
            // width: double.infinity,
            lineHeight: 5.0,
            percent: percent,

            padding: EdgeInsets.all(0),
            backgroundColor: Colors.grey[300],
            progressColor: color,
          ),
        ),
      ],
    );
  }
}


class SettingHeader extends StatelessWidget {
  String title;
  SettingHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                print("tapped");
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '$title',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Container()
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
