import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

class NotSupportForPregnantOptionScreen extends StatefulWidget {
  SignUpBody signUpBody;
  String text1, text2;
  NotSupportForPregnantOptionScreen(
      {Key key, this.signUpBody, this.text1, this.text2})
      : super(key: key);

  @override
  _NotSupportForPregnantOptionScreenState createState() =>
      _NotSupportForPregnantOptionScreenState();
}

class _NotSupportForPregnantOptionScreenState
    extends State<NotSupportForPregnantOptionScreen> {
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
                  questionHeaderSimple(percent: .99, color: primaryColor),
                  SizedBox(
                    height: height * .05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.text1,
                        //'Unfortunately,Weight loser is not currently designed to support those who are pregnant.',
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
                    height: height * .02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.text2,
                        // 'We recommend seeking the medical advice of a physician if you are interested in losing weight.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: "Book Antiqua",
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2B2B2B)),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
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
