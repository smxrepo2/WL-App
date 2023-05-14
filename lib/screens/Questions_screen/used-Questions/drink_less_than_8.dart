import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';

import '../../choose_your_plan.dart';

class DrinkLessThan8 extends StatefulWidget {
  SignUpBody signUpBody;

  DrinkLessThan8({Key key, this.signUpBody}) : super(key: key);

  @override
  _DrinkLessThan8State createState() => _DrinkLessThan8State();
}

class _DrinkLessThan8State extends State<DrinkLessThan8> {
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
        child: Column(
          children: [
            SizedBox(
                height: height * 0.1,
                width: width,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Biology',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Diet',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Excersie',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Mind',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sleep/Habit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              ///this is the stack container........
              height: height * 0.33,
              width: width,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.2,
                    decoration: const BoxDecoration(
                        color: Color(0xffE3C2F7),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Center(
                      child: Text(
                        'Let us understand your profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.025),
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.13,
                      left: height * 0.04,
                      child: Container(
                        height: height * 0.17,
                        width: width * 0.85,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Select your Daily normal daily \n water intake",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.04),
                                ),
                              )),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      )),
                ],
              ),
            ),

            ///this is the first two button which indicate the lbs adn kg
            SizedBox(
              height: height * 0.02,
            ),
            ListView.builder(
                itemCount: TextConstant.option.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              gender = TextConstant.option[index];
                            });
                          },
                          child: Container(
                            width: Get.width * .9,
                            height: 60,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  TextConstant.option[index],
                                  style: listStyle,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: gender == TextConstant.option[index]
                                    ? const Color(0xffE3C2F7)
                                    : Colors.white,
                                border: Border.all(
                                  color: gender == TextConstant.option[index]
                                      ? mindBorder
                                      : Colors.grey,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: height * .05,
            ),
            InkWell(
              onTap: () {
                get();
                if (gender != '') {
                  widget.signUpBody.mindQuestions.waterHabit = gender;
                  widget.signUpBody.mindQuestions.lateNightHabit =
                      "I don't know";
                  widget.signUpBody.dietQuestions.weightApps = "None";
                  widget.signUpBody.exerciseQuestions.exerciseType = "Running";
                  widget.signUpBody.exerciseQuestions.bodyType = 'Pear-shaped';
                  widget.signUpBody.exerciseQuestions.memberShip = "No";
                  widget.signUpBody.exerciseQuestions.routine = "1 day a week";
                  //widget.signUpBody.mindQuestions.freeTimeEating =
                  //  "I don\'t know";
                  widget.signUpBody.dietQuestions.duration = "";
                  widget.signUpBody.dietQuestions.noCuisine = "[]";
                  //widget.signUpBody.mindQuestions.largeEating = "";
                  widget.signUpBody.restaurants ??= [];
                  print("Water ${widget.signUpBody.mindQuestions.waterHabit}");
                  mobile
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChoosePlan(
                              signUpBody: widget.signUpBody,
                            ),
                          ),
                        )
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 430, right: 430, top: 30, bottom: 30),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child:  
                                  ChoosePlan(
                                    signUpBody: widget.signUpBody,
                                  )

                                  ),
                            ),
                          ),
                        );
                } else {
                  AltDialog(context, 'Please select options.');
                }
              },
              child: Container(
                  width: mobile ? Get.width * .6 : Get.width * .3,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: buttonStyle,
                    ),
                  )),
            ),
            SizedBox(
              height: height * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.01,
                  width: width / 2,
                  child: LinearProgressIndicator(
                    minHeight: height * 0.02,
                    color: Colors.black,
                    backgroundColor: Colors.black38,
                    value: 0.1,
                  ),
                ),
                const Text('03 % Completed'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
