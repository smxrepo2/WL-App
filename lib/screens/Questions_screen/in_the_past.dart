import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/exMsg.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/how_often_do_you_walk.dart';
import 'package:weight_loser/screens/Questions_screen/regular_routine_physical_exercise.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/do_you_know.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'loss_weight_while_eating_food.dart';

class InThePast extends StatefulWidget {
  SignUpBody signUpBody;

  InThePast({Key key, this.signUpBody}) : super(key: key);

  @override
  _InThePastState createState() => _InThePastState();
}

class _InThePastState extends State<InThePast> {
  String gender = '';
  List selectedOptions = [];
  List weightLoss = [
    "Paid meal plan",
    "Prescription membership",
    "Activity group",
    "Hypnosis",
    "Noom",
    "Weight Watchers",
    "Daily Calorie tracking",
    "Jenny Craig Diet",
    "Other",
    "None"
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
                      queNo: 15,
                      percent: .56,
                      color: exBorder,
                    ),
                    SizedBox(height: height * .05),
                    Container(
                        height: mobile ? Get.height * .83 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: height * .01),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'In the past, have you used any of the following for  weight loss? ',
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 25),
                                  child: Text(
                                    'Please pick as many:',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              ListView.builder(
                                  itemCount: weightLoss.length,
                                  physics: NeverScrollableScrollPhysics(),
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
                                                if (selectedOptions.contains(
                                                    weightLoss[index])) {
                                                  selectedOptions.remove(
                                                      weightLoss[index]);
                                                } else {
                                                  selectedOptions
                                                      .add(weightLoss[index]);
                                                }
                                                gender = weightLoss[index];
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
                                                    weightLoss[index],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color:
                                                      selectedOptions.contains(
                                                              weightLoss[index])
                                                          ? exSelect
                                                          : Colors.white,
                                                  border: Border.all(
                                                    color: selectedOptions
                                                            .contains(
                                                                weightLoss[
                                                                    index])
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
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 40,
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
                    if (selectedOptions.isNotEmpty) {
                      widget.signUpBody.dietQuestions.weightApps =
                          selectedOptions.toString();
                      Responsive1.isMobile(context)
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HowOftenDoYouWalk(
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
                                        child: HowOftenDoYouWalk(
                                            signUpBody: widget.signUpBody)),
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
