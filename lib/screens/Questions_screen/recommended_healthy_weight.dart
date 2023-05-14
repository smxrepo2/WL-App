import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/screens/Questions_screen/when_goal_weight_last_time.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/diet _exercise_mind.dart';
import 'used-Questions/gender_screen.dart';

class RecommendedHealthyWeight extends StatefulWidget {
  SignUpBody signUpBody;

  RecommendedHealthyWeight({Key key, this.signUpBody}) : super(key: key);

  @override
  _RecommendedHealthyWeightState createState() =>
      _RecommendedHealthyWeightState();
}

class _RecommendedHealthyWeightState extends State<RecommendedHealthyWeight> {
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentKGValue = 50;

  // int _currentCmValue = 173;
  String mode = 'KG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                questionHeader(queNo: 3, percent: .04),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.pop(context);
                //         print("tapped");
                //       },
                //       child: Container(
                //         child: Icon(
                //           Icons.arrow_back,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //     Container()
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   width: double.infinity,
                //   height: 5,
                //   color: Colors.grey[300],
                //   child: LinearPercentIndicator(
                //     // width: double.infinity,
                //     lineHeight: 5.0,
                //     percent: .08,
                //
                //     padding: EdgeInsets.all(0),
                //     backgroundColor: Colors.grey[300],
                //     progressColor: primaryColor,
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recommended Healthy Weight',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                Container(
                    width: Get.width * .32,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              mode = 'lbs';
                              _currentKGValue = 132;
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'lbs'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40.0),
                                      topLeft: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'lbs',
                                style: TextStyle(
                                    color: mode == 'lbs'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              mode = 'KG';
                              _currentKGValue = 60;
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'KG'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'KG',
                                style: TextStyle(
                                    color: mode == 'KG'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 80,
                ),
                mode == 'lbs'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            '$_currentKGValue',
                            style: TextStyle(fontSize: 25),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Center(
                              child: Text(
                                'lbs',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            '$_currentKGValue',
                            style: TextStyle(fontSize: 25),
                          ),
                          // NumberPicker(
                          //   value: _currentKGValue,
                          //   itemWidth: 60,
                          //   selectedTextStyle:
                          //   TextStyle(color: Colors.black, fontSize: 20),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(1),
                          //     border: Border.all(color: Colors.black26),
                          //   ),
                          //   minValue: 0,
                          //   maxValue: 10000,
                          //   onChanged: (value) =>
                          //       setState(() => _currentKGValue = value),
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Center(
                              child: Text(
                                'KG',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            InkWell(
              onTap: () {
                Responsive1.isMobile(context)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DietExerciseMindScreen(
                              signUpBody: widget.signUpBody,
                            )))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 430, right: 430, top: 30, bottom: 30),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DietExerciseMindScreen(
                                      signUpBody: widget.signUpBody)),
                            )));
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
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
