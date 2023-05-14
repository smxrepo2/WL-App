import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/regular_routine_physical_exercise.dart';
import 'package:weight_loser/screens/Questions_screen/type_of_exercise.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/do_you_know.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'loss_weight_while_eating_food.dart';
import 'membership_gym.dart';

class HowOftenGoGym extends StatefulWidget {
  SignUpBody signUpBody;
  HowOftenGoGym({Key key, this.signUpBody}) : super(key: key);

  @override
  _HowOftenGoGymState createState() => _HowOftenGoGymState();
}

class _HowOftenGoGymState extends State<HowOftenGoGym> {
  String gender = '';
  List activity = [
    'Never',
    'Every day',
    '4–6 days a week',
    '2–3 days a week',
    '1 day a week',
    'Less than 1 day a week'
  ];
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    questionHeader(
                      queNo: 20,
                      percent: .65,
                      color: exBorder,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
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
                    //     Row(
                    //       children: [
                    //         Text(
                    //           '20/$totalQuestion',
                    //           style: TextStyle(color: Colors.black),
                    //         )
                    //       ],
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
                    //     percent: .48,
                    //
                    //     padding: EdgeInsets.all(0),
                    //     backgroundColor: Colors.grey[300],
                    //     progressColor: primaryColor,
                    //   ),
                    // ),
                    Container(
                        height: mobile ? Get.height * .84 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * .01,
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "How often do you go to the gym?",
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * .03),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: activity.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                gender = activity[index];
                                                // print("Activity $gender");
                                              });
                                            },
                                            child: Container(
                                              width: Get.width * .9,
                                              height: 60,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    activity[index],
                                                    style: listStyle,
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color:
                                                      gender == activity[index]
                                                          ? exSelect
                                                          : Colors.white,
                                                  border: Border.all(
                                                    color: gender ==
                                                            activity[index]
                                                        ? exBorder
                                                        : Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: mobile ? Get.width * .15 : 25,
              child: Container(
                child: InkWell(
                  onTap: () {
                    if (gender != '') {
                      widget.signUpBody.exerciseQuestions.routine = gender;
                      print(
                          "Routine:- ${widget.signUpBody.exerciseQuestions.routine}");
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoyouknowScreen(
                                    signUpBody: widget.signUpBody,
                                  )))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 430,
                                        right: 430,
                                        top: 30,
                                        bottom: 30),
                                    child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DoyouknowScreen(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    } else {
                      AltDialog(context, 'Please select options.');
                    }
                  },
                  child: Padding(
                    padding: mobile
                        ? const EdgeInsets.only(bottom: 20.0, left: 20)
                        : const EdgeInsets.only(bottom: 30.0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: mobile ? Get.width * .6 : Get.width * .3,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
