import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/do_you_have_any_of_the_following_medical_conditions.dart';
import 'used-Questions/i_cant_control_myself.dart';

class AgreeStatment extends StatefulWidget {
  final Function() ontap;
  AgreeStatment({this.ontap});

  @override
  _AgreeStatmentState createState() => _AgreeStatmentState();
}

class _AgreeStatmentState extends State<AgreeStatment> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                SizedBox(height: 25),
                questionHeaderSimple(
                  percent: .99,
                  color: mindBorder,
                ),
                SizedBox(height: 35),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImagePath.mindmsg,
              height: 290,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "What you eat in private eventually\nis what you wear in public.\nEat clean, look lean.",
                style: msgStyle,
                textAlign: TextAlign.center,
              )),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: widget.ontap,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
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
