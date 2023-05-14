import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/do_you_know.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'no.dart';

class ICanDo7MinuteExercise extends StatefulWidget {
  SignUpBody signUpBody;

  ICanDo7MinuteExercise({Key key, this.signUpBody}) : super(key: key);

  @override
  _ICanDo7MinuteExerciseState createState() => _ICanDo7MinuteExerciseState();
}

class _ICanDo7MinuteExerciseState extends State<ICanDo7MinuteExercise> {
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
                  queNo: 12,
                  percent: .60,
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
                //           '23/$totalQuestion',
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
                //     percent: .54,
                //
                //     padding: EdgeInsets.all(0),
                //     backgroundColor: Colors.grey[300],
                //     progressColor: primaryColor,
                //   ),
                // ),
                SizedBox(height: height * .05),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'I can do a minimum of\n10 minutes of exercise:',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                const SizedBox(
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
                            selectedOption = 'Agree';
                          });
                        },
                        child: Container(
                          width: mobile ? Get.width * .350 : 200,
                          height: 150,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Agree',
                                style: listStyle,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: selectedOption == 'Agree'
                                  ? exSelect
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 'Agree'
                                    ? exBorder
                                    : Colors.grey,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = 'Disagree';
                          });
                        },
                        child: Container(
                          width: mobile ? Get.width * .350 : 200,
                          height: 150,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Disagree',
                                style: listStyle,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: selectedOption == 'Disagree'
                                  ? exSelect
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOption == 'Disagree'
                                    ? exBorder
                                    : Colors.grey,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {
                if (selectedOption == 'Disagree') {
                  widget.signUpBody.exerciseQuestions.minExercise =
                      selectedOption;
                  print(
                      "MinExcrcise ${widget.signUpBody.exerciseQuestions.minExercise}");
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisagreeMsg(
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
                                    child: DisagreeMsg(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                } else if (selectedOption == 'Agree') {
                  widget.signUpBody.exerciseQuestions.minExercise =
                      selectedOption;
                  print(
                      "MinExcrcise ${widget.signUpBody.exerciseQuestions.minExercise}");
                  widget.signUpBody.exerciseQuestions.bodyType = "";
                  print(
                      "BodyType:- ${widget.signUpBody.exerciseQuestions.bodyType}");
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoyouknowScreen(
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
                child: Container(
                    width: mobile ? Get.width * .6 : Get.width * .3,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: const Center(
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
}
