import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/diet _exercise_mind.dart';
import 'used-Questions/how_often_do_you_walk.dart';
import 'used-Questions/not_support_pregnant.dart';

class RegularRoutinePhysicalExercise extends StatefulWidget {
  SignUpBody signUpBody;
  RegularRoutinePhysicalExercise({Key key, this.signUpBody}) : super(key: key);

  @override
  _RegularRoutinePhysicalExerciseState createState() =>
      _RegularRoutinePhysicalExerciseState();
}

class _RegularRoutinePhysicalExerciseState
    extends State<RegularRoutinePhysicalExercise> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                questionHeader(queNo: 16, percent: .16),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Do you follow a Regular routine of physical exercise?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
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
                          width: mobile ? Get.width * .350 : 200,
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
                          width: mobile ? Get.width * .350 : 200,
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
                if (selectedOption == "") {
                  AltDialog(context, 'Please select options.');
                } else {
                  widget.signUpBody.exerciseQuestions.routine = selectedOption;
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HowOftenDoYouWalk(
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
                                    child: HowOftenDoYouWalk(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                }
              },
              child: Padding(
                padding: mobile
                    ? const EdgeInsets.only(bottom: 60.0, left: 20)
                    : const EdgeInsets.only(bottom: 30.0, left: 20),
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
