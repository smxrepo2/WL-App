import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'last_goal_weight.dart';

class GoalMsg extends StatefulWidget {
  SignUpBody signUpBody;
  GoalMsg({Key key, this.signUpBody}) : super(key: key);

  @override
  State<GoalMsg> createState() => _GoalMsgState();
}

class _GoalMsgState extends State<GoalMsg> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                const SizedBox(height: 25),
                questionHeaderSimple(
                  percent: .99,
                  color: primaryColor,
                ),
              ],
            ),
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
                "\"Having a realistic weight goal \nis important! Think of that\nfeeling you’ll get when\nyou’ve reached your\ngoal weight.",
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
                        builder: (context) => LastGoalWeight(
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
                                  child: LastGoalWeight(
                                      signUpBody: widget.signUpBody)),
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: Get.width * .6,
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
          )
        ],
      ),
    ));
  }
}
