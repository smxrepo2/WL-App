import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/everday_mobality.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'how_often_do_you_walk.dart';

class ThroughOutMsg extends StatefulWidget {
  SignUpBody signUpBody;
  ThroughOutMsg({this.signUpBody});

  @override
  State<ThroughOutMsg> createState() => _ThroughOutMsgState();
}

class _ThroughOutMsgState extends State<ThroughOutMsg> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  questionHeaderSimple(percent: .99, color: exBorder),
                  SizedBox(height: height * .05),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        children: [
                          Text(
                            'Now, let\'s gauge how much\nyou move throughout the\nday!',
                            textAlign: TextAlign.center,
                            style: questionText28Px,
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Container(
                      height: Responsive1.isMobile(context) ? 350 : 270,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.throughOut,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: height * .03),
                ],
              ),
              InkWell(
                onTap: () {
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EveryDayMobility(
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
                                    child: EveryDayMobility(
                                        signUpBody: widget.signUpBody)),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
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
                          style: buttonStyle,
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
