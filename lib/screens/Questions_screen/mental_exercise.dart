import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/do_you_have_any_of_the_following_medical_conditions.dart';
import 'used-Questions/i_cant_control_myself.dart';

class MentalExercise extends StatefulWidget {
  SignUpBody signUpBody;
  MentalExercise({Key key, this.signUpBody}) : super(key: key);

  @override
  _MentalExerciseState createState() => _MentalExerciseState();
}

class _MentalExerciseState extends State<MentalExercise> {
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
                questionHeader(queNo: 23, percent: .23),
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
                //     percent: .62,
                //
                //     padding: EdgeInsets.all(0),
                //     backgroundColor: Colors.grey[300],
                //     progressColor: primaryColor,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mental exercise is an integral part for weight-loss',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                    height: mobile ? 300 : 280,
                    //width: Get.width * .5,
                    child: Image.asset(
                      'assets/images/Mask Group 48.png',
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tell us what might throw you off track or what weakens your determination to loose weight, no judgements",
                      textAlign: TextAlign.center,
                      style: darkText12Px,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                mobile
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ICantControlMySelf(
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
                                  child: ICantControlMySelf(
                                    signUpBody: widget.signUpBody,
                                  )),
                            )));
              },
              child: Padding(
                padding: mobile
                    ? const EdgeInsets.only(bottom: 60.0, left: 20)
                    : const EdgeInsets.only(bottom: 30.0, left: 20),
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
