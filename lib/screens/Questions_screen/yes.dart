import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/sleepMsg.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/do_you_have_any_of_the_following_medical_conditions.dart';
import 'mental_exercise.dart';

class AgreeMsg extends StatefulWidget {
  SignUpBody signUpBody;
  AgreeMsg({Key key, this.signUpBody}) : super(key: key);

  @override
  _AgreeMsgState createState() => _AgreeMsgState();
}

class _AgreeMsgState extends State<AgreeMsg> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  color: exBorder,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Text(
                  "Agree!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Book Antiqua'),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImagePath.exMsg,
              height: 290,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "Everything doing now \nwill pay off in the future.",
                style: msgStyle,
                textAlign: TextAlign.center,
              )),
          Positioned(
            bottom: 20,
            child: InkWell(
              onTap: () {
                Responsive1.isMobile(context)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SleepMsg(
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
                                  child:
                                      SleepMsg(signUpBody: widget.signUpBody)),
                            )));
              },
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
