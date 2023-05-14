import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';

import 'used-Questions/diet _exercise_mind.dart';

class WhenLastTimeGoalWeight extends StatefulWidget {
  SignUpBody signUpBody;
  WhenLastTimeGoalWeight({Key key, this.signUpBody}) : super(key: key);

  @override
  _WhenLastTimeGoalWeightState createState() => _WhenLastTimeGoalWeightState();
}

class _WhenLastTimeGoalWeightState extends State<WhenLastTimeGoalWeight> {
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          print("tapped");
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '5/$totalQuestion',
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
                      percent: .10,

                      padding: EdgeInsets.all(0),
                      backgroundColor: Colors.grey[300],
                      progressColor: primaryColor,
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'When was the last time you were at your goal weight?',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  // SizedBox(height: 30,),
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      answer = '1 years ago';
                                    });
                                  },
                                  child: Container(
                                    width: Get.width * .55,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '1 years ago',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: answer == '1 years ago'
                                              ? primaryColor
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      answer = '2 years ago';
                                    });
                                  },
                                  child: Container(
                                    width: Get.width * .55,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '2 years ago',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: answer == '2 years ago'
                                              ? primaryColor
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      answer = '3 years ago';
                                    });
                                  },
                                  child: Container(
                                    width: Get.width * .55,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '3 years ago',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: answer == '3 years ago'
                                              ? primaryColor
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      answer = '4 years ago';
                                    });
                                  },
                                  child: Container(
                                    width: Get.width * .55,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '4 years ago',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: answer == '4 years ago'
                                              ? primaryColor
                                              : Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 400,
                                //width: Get.width * .5,
                                child: Image.asset(
                                  'assets/images/Mask Group 31.png',
                                  fit: BoxFit.contain,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (answer != "") {
                    widget.signUpBody.dietQuestions.duration = answer;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DietExerciseMindScreen(
                              signUpBody: widget.signUpBody,
                            )));
                  } else {
                    AltDialog(context, 'Please select options.');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                      width: Get.width * .6,
                      height: 40,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
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
      ),
    );
  }
}
