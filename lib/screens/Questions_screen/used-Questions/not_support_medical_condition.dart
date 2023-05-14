import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';

class NotSupportMedicalCondition extends StatefulWidget {
  SignUpBody signUpBody;

  NotSupportMedicalCondition({Key key, this.signUpBody}) : super(key: key);

  @override
  _NotSupportMedicalConditionState createState() =>
      _NotSupportMedicalConditionState();
}

class _NotSupportMedicalConditionState
    extends State<NotSupportMedicalCondition> {
  String selectedOption = '';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          print("tapped");
                        },
                        child: Container(
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       '8/$totalQuestion',
                      //       style: TextStyle(color: Colors.black),
                      //     )
                      //   ],
                      // ),
                      Container()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.grey[300],
                    child: LinearPercentIndicator(
                      // width: double.infinity,
                      lineHeight: 5.0,
                      percent: .16,

                      padding: const EdgeInsets.all(0),
                      backgroundColor: Colors.grey[300],
                      progressColor: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Unfortunately, Weightloser\n is not currently designed to\n support this disorder',
                        textAlign: TextAlign.center,
                        style: notSupport,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Container(

                      //width: Get.width * .5,
                      child: Image.asset(
                    ImagePath.notSupport,
                    fit: BoxFit.contain,
                  )),
                  SizedBox(
                    height: height * .03,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'We recommend seeking the medical advice\nof a physician if you are interested in\nlosing weight.',
                        textAlign: TextAlign.center,
                        style: subNotSupport,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  //exit(0);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                      width: Get.width * .6,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      child: const Center(
                        child: Text(
                          "Go Back",
                          style: TextStyle(color: Colors.white),
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
