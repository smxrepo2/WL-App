import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'sleep_less_than_7.dart';
import '../food_like_dislike.dart';

class SleepHours extends StatefulWidget {
  SignUpBody signUpBody;

  SleepHours({Key key, this.signUpBody}) : super(key: key);
  @override
  _SleepHoursState createState() => _SleepHoursState();
}

class _SleepHoursState extends State<SleepHours> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * .01,
                ),
                questionHeader(
                  queNo: 13,
                  percent: .65,
                  color: exBorder,
                ),
                SizedBox(height: height * .05),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What are your sleep hours?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildTimePick("Start", true, startTime, (x) {
                                  setState(() {
                                    startTime = x;
                                    print("The picked time is: $x");
                                  });
                                }),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildTimePick("End", true, endTime, (x) {
                                  setState(() {
                                    endTime = x;
                                    print("The picked time is: $x");
                                  });
                                }),
                              ])),
                      SizedBox(height: height * .04),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'We understand you need ample rest after a hectic day.\nWe will make sure not to disturb your sleep with updates\nand notifications.',
                            textAlign: TextAlign.center,
                            style: darkText12Px,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                double _doubleStartTime = startTime.hour.toDouble() +
                    (startTime.minute.toDouble() / 60);
                double _doubleEndTime =
                    endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);
                double _timeDiff = _doubleEndTime - _doubleStartTime;
                int _hr = _timeDiff.truncate();
                double _minute = (_timeDiff - _timeDiff.truncate()) * 60;
                print(_timeDiff);
                print(_hr.abs());
                if (_hr == 0) {
                  AltDialog(context, "Please Select your sleep hours");
                } else {
                  widget.signUpBody.dietQuestions.sleepTime = _hr;
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SleepLessThan7(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SleepLessThan7(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Next",
                        style: buttonStyle,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (_pickedTime != null) {
      onTimePicked(_pickedTime);
    }
  }

  Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
      Function(TimeOfDay) onTimePicked) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: Text(
              currentTime.format(context),
            ),
            onTap: () {
              selectedTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        ),
      ],
    );
  }
}
