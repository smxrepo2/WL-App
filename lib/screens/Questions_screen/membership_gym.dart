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
import 'how_often_go_gym.dart';
import 'used-Questions/not_support_pregnant.dart';

class MembershipOfGym extends StatefulWidget {
  SignUpBody signUpBody;
  MembershipOfGym({Key key, this.signUpBody}) : super(key: key);

  @override
  _MembershipOfGymState createState() => _MembershipOfGymState();
}

class _MembershipOfGymState extends State<MembershipOfGym> {
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
                  queNo: 19,
                  percent: .66,
                  color: exBorder,
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
                //     percent: .46,
                //
                //     padding: EdgeInsets.all(0),
                //     backgroundColor: Colors.grey[300],
                //     progressColor: primaryColor,
                //   ),
                // ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Do you have a membership to Gym?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
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
                                style: listStyle,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: selectedOption == 'Yes'
                                  ? exSelect
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 'Yes'
                                    ? exBorder
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
                                style: listStyle,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: selectedOption == 'No'
                                  ? exSelect
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 'No'
                                    ? exBorder
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
                  widget.signUpBody.exerciseQuestions.memberShip =
                      selectedOption;
                  print(
                      "membership:- ${widget.signUpBody.exerciseQuestions.memberShip}");
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HowOftenGoGym(
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
                                    child: HowOftenGoGym(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 20),
                child: Container(
                    width: mobile ? Get.width * .6 : Get.width * .3,
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
