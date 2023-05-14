import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/gender_screen.dart';

class WeightMsg extends StatefulWidget {
  SignUpBody signUpBody;
  WeightMsg({this.signUpBody});

  @override
  State<WeightMsg> createState() => _WeightMsgState();
}

class _WeightMsgState extends State<WeightMsg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(height: 25),
              questionHeaderSimple(
                percent: .99,
                color: primaryColor,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImagePath.msg,
              height: 290,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "\"Weight Loss doesn’t begin in \nthe gym with a dumbbell;\nit starts in your head\nwith a decision.\" \n\n– Toni Sorenson",
                style: msgStyle,
                textAlign: TextAlign.center,
              )),
          Positioned(
            bottom: 10,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                Responsive1.isMobile(context)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GenderScreen(
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
                                  child: GenderScreen(
                                      signUpBody: widget.signUpBody)),
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
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
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
