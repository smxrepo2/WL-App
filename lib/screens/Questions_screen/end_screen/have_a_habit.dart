import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/Questions_screen/disagree-msg.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/screens/choose_your_plan.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import '../I dont know_msg.dart';
import '../mind_q_screen.dart';
import 'i_eat_more_when_i_see.dart';

class HaveAHabit extends StatefulWidget {
  SignUpBody signUpBody;

  HaveAHabit({Key key, this.signUpBody}) : super(key: key);

  @override
  _HaveAHabitState createState() => _HaveAHabitState();
}

class _HaveAHabitState extends State<HaveAHabit> {
  String gender = '';

  void get() {
    var mindCount = 0;
    var emoCount = 0;
    var poorCount = 0;
    List poorSelf = [
      widget.signUpBody.mindQuestions.control,
      widget.signUpBody.mindQuestions.preoccupied,
      widget.signUpBody.mindQuestions.freeFood,
      widget.signUpBody.mindQuestions.eatingRound
    ];
    for (int i = 0; i < poorSelf.length; i++) {
      if (poorSelf[i] == "Agree") {
        poorCount++;
      }
    }
    print("Poor self $poorCount");

    List mind = [
      widget.signUpBody.mindQuestions.dailyEating,
      // widget.signUpBody.mindQuestions.sevenSleeping,
      widget.signUpBody.mindQuestions.largeEating,
      widget.signUpBody.mindQuestions.watchingEating,
      widget.signUpBody.mindQuestions.freeTimeEating,
      //widget.signUpBody.mindQuestions.waterHabit,
      widget.signUpBody.mindQuestions.lateNightHabit
    ];
    for (int i = 0; i < mind.length; i++) {
      if (mind[i] == "Agree") {
        mindCount += 1;
      }
    }
    print("Mind $mindCount");

    List emotional = [
      widget.signUpBody.mindQuestions.stressedEating,
      widget.signUpBody.mindQuestions.sadEating,
      widget.signUpBody.mindQuestions.lonelyEating,
      widget.signUpBody.mindQuestions.boredEating
    ];
    for (int i = 0; i < emotional.length; i++) {
      if (emotional[i] == "Agree") {
        emoCount += 1;
      }
    }
    print("Emotional type $emoCount");

    var C = [mindCount, emoCount, poorCount].reduce(max);
    print(C);
    if (C == mindCount) {
      print("MindFull ness");
      widget.signUpBody.mindQuestions.category = "Mindful Ness";
    } else if (C == emoCount) {
      widget.signUpBody.mindQuestions.category = "Defensive eater type";
      print("Defensive eater type");
    } else if (C == poorCount) {
      widget.signUpBody.mindQuestions.category = "Poor self control type";
      print("Poor self control type");
    }
  }

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
                    questionHeader(queNo: 40, percent: .93, color: mindBorder),
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
                    //           '40/$totalQuestion',
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
                    //     percent: .60,
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
                                    "I have a habit of late-night  munching",
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              ListView.builder(
                                  itemCount: TextConstant.option.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                gender =
                                                    TextConstant.option[index];
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
                                                    TextConstant.option[index],
                                                    style: listStyle,
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: gender ==
                                                          TextConstant
                                                              .option[index]
                                                      ? mindSelect
                                                      : Colors.white,
                                                  border: Border.all(
                                                    color: gender ==
                                                            TextConstant
                                                                .option[index]
                                                        ? mindBorder
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
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  }),
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
                    // var user = FirebaseAuth.instance.currentUser;
                    if (gender == "Agree") {
                      widget.signUpBody.mindQuestions.lateNightHabit = gender;
                      print(
                          "LatNight ${widget.signUpBody.mindQuestions.lateNightHabit}");
                      get();
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AgreeStatment(
                                    ontap: () {
                                      get();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ChoosePlan(
                                                    signUpBody:
                                                        widget.signUpBody,
                                                  )));
                                      // SignUpScreen(signUpBody: widget.signUpBody,)));
                                    },
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
                                      child: AgreeStatment(
                                        ontap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 430,
                                                                right: 430,
                                                                top: 30,
                                                                bottom: 30),
                                                        child: Card(
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: ChoosePlan(
                                                              signUpBody: widget
                                                                  .signUpBody,
                                                            )),
                                                      )));
                                        },
                                      ),
                                    ),
                                  )));
                    } else if (gender == 'Disagree') {
                      widget.signUpBody.mindQuestions.lateNightHabit = gender;
                      print(
                          "LatNight ${widget.signUpBody.mindQuestions.lateNightHabit}");
                      get();
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DisAgree(
                                    ontap: () {
                                      get();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ChoosePlan(
                                                    signUpBody:
                                                        widget.signUpBody,
                                                  )));
                                      // SignUpScreen(signUpBody: widget.signUpBody,)));
                                    },
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
                                      child: DisAgree(
                                        ontap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 430,
                                                                right: 430,
                                                                top: 30,
                                                                bottom: 30),
                                                        child: Card(
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: ChoosePlan(
                                                              signUpBody: widget
                                                                  .signUpBody,
                                                            )),
                                                      )));
                                        },
                                      ),
                                    ),
                                  )));
                    } else if (gender == 'I don\'t know') {
                      widget.signUpBody.mindQuestions.lateNightHabit = gender;
                      print(
                          "LatNight ${widget.signUpBody.mindQuestions.lateNightHabit}");
                      get();
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoNotKnow(
                                    ontap: () {
                                      get();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ChoosePlan(
                                                    signUpBody:
                                                        widget.signUpBody,
                                                  )));
                                      // SignUpScreen(signUpBody: widget.signUpBody,)));
                                    },
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
                                      child: DoNotKnow(
                                        ontap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 430,
                                                                right: 430,
                                                                top: 30,
                                                                bottom: 30),
                                                        child: Card(
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: ChoosePlan(
                                                              signUpBody: widget
                                                                  .signUpBody,
                                                            )),
                                                      )));
                                        },
                                      ),
                                    ),
                                  )));
                    } else {
                      AltDialog(context, 'Please select options.');
                    }
                    // if (gender == 'Agree') {
                    //   widget.signUpBody.mindQuestions.lateNightHabit = gender;
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => AgreeStatment(
                    //             text1: 'You need to change this habit',
                    //             text2:
                    //                 'Nighttime eating can cause you to eat more calories than you need, which can lead to weight gain. ',
                    //             ontap: () {
                    //               // widget.signUpBody.mindQuestions.lateNightHabit = gender;
                    //               // widget.signUpBody.customerPackages.amount = 10;
                    //               // widget.signUpBody.customerPackages.name = 'basic';
                    //               // widget.signUpBody.customerPackages.duration = 1;
                    //               // widget.signUpBody.customerPackages.status = 'unPaid';
                    //               // widget.signUpBody.dietQuestions.dOB = DateTime.now();
                    //               // widget.signUpBody.exerciseQuestions.activityLevel = 9;
                    //               // widget.signUpBody.dietQuestions.weightApps = 'weightApps';
                    //               // widget.signUpBody.dietQuestions.favFoods = 'favFoods';
                    //               Navigator.of(context).push(MaterialPageRoute(
                    //                   builder: (context) => ChoosePlan(
                    //                         signUpBody: widget.signUpBody,
                    //                       )));
                    //               // SignUpScreen(signUpBody: widget.signUpBody,)));
                    //             },
                    //           )));
                    // } else if (gender == 'Disagree' ||
                    //     gender == 'I don\'t know') {
                    //   widget.signUpBody.mindQuestions.lateNightHabit = gender;
                    //   widget.signUpBody.customerPackages.amount = 10;
                    //   widget.signUpBody.customerPackages.name = 'basic';
                    //   widget.signUpBody.customerPackages.duration = 1;
                    //   widget.signUpBody.customerPackages.status = 'unPaid';
                    //   //widget.signUpBody.dietQuestions.dOB = ;
                    //   widget.signUpBody.exerciseQuestions.activityLevel = 9;
                    //   widget.signUpBody.dietQuestions.weightApps = 'weightApps';
                    //   widget.signUpBody.dietQuestions.favFoods = 'favFoods';
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => SignUpScreen(
                    //             signUpBody: widget.signUpBody,
                    //           )));
                    // } else {
                    //   AltDialog(context, 'Please select options.');
                    // }
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
                                style: buttonStyle,
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
