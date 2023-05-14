import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'date_of_birth.dart';
import 'used-Questions/diet _exercise_mind.dart';
import 'food_like_dislike.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'used-Questions/not_support_pregnant.dart';

class PregnantOptionScreen extends StatefulWidget {
  SignUpBody signUpBody;
  PregnantOptionScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _PregnantOptionScreenState createState() => _PregnantOptionScreenState();
}

class _PregnantOptionScreenState extends State<PregnantOptionScreen> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                  queNo: 3,
                  percent: .15,
                  color: primaryColor,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Are you pregnant?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: mobile ? 150 : 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = 'Yes';
                          });
                        },
                        child: Container(
                          width: mobile ? Get.width * .350 : Get.width * .100,
                          height: 150,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Yes',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: selectedOption == 'Yes'
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = 'No';
                          });
                        },
                        child: Container(
                          width: mobile ? Get.width * .350 : Get.width * .100,
                          height: 150,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: selectedOption == 'No'
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {
                if (selectedOption == 'Yes') {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NotSupportForPregnantOptionScreen(
                                  signUpBody: widget.signUpBody,
                                  text1: TextConstant.pregnantText1,
                                  text2: TextConstant.pregnantText2)))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: NotSupportForPregnantOptionScreen(
                                        signUpBody: widget.signUpBody,
                                        text1: TextConstant.pregnantText1,
                                        text2: TextConstant.pregnantText2)),
                              )));
                } else if (selectedOption == "") {
                  AltDialog(context, 'Please select options.');
                } else {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              GoalWeightScreen(signUpBody: widget.signUpBody)))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: GoalWeightScreen(
                                        signUpBody: widget.signUpBody)),
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
