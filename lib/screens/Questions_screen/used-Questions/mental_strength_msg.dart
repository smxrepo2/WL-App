import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'i_cant_control_myself.dart';

class MentalStrength extends StatefulWidget {
  SignUpBody signUpBody;
  MentalStrength({this.signUpBody});

  @override
  State<MentalStrength> createState() => _MentalStrengthState();
}

class _MentalStrengthState extends State<MentalStrength> {
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                  questionHeaderSimple(
                    percent: .99,
                    color: mindBorder,
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Mental strength is central\nto your weight loss!',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                      height: mobile ? 300 : 250,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.mentalStrength,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tell us what throws you off or may weaken your determination\nto lose weight. So, we may bring some hope to you!',
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ICantControlMySelf(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
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
