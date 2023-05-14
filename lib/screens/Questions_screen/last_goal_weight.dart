import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/select_your_date_age.dart';

class LastGoalWeight extends StatefulWidget {
  SignUpBody signUpBody;
  LastGoalWeight({Key key, this.signUpBody}) : super(key: key);

  @override
  State<LastGoalWeight> createState() => _LastGoalWeightState();
}

class _LastGoalWeightState extends State<LastGoalWeight> {
  String answer = '';
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
                  queNo: 5,
                  percent: .25,
                  color: primaryColor,
                ),
                SizedBox(
                  height: height * .05,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'When were you at your goal weight last time?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      answer = '1 years ago';
                    });
                  },
                  child: Container(
                    width: Get.width * .9,
                    height: 60,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '1 years ago',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: answer == '1 years ago'
                              ? buttonColor
                              : Colors.grey,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      answer = '2 years ago';
                    });
                  },
                  child: Container(
                    width: Get.width * .9,
                    height: 60,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '2 years ago',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: answer == '2 years ago'
                              ? buttonColor
                              : Colors.grey,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      answer = '3 years ago';
                    });
                  },
                  child: Container(
                    width: Get.width * .9,
                    height: 60,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '3 years ago',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: answer == '3 years ago'
                              ? buttonColor
                              : Colors.grey,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      answer = '4 years ago';
                    });
                  },
                  child: Container(
                    width: Get.width * .9,
                    height: 60,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '4 years ago',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: answer == '4 years ago'
                              ? buttonColor
                              : Colors.grey,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Responsive1.isMobile(context)
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  SelectYourAge(
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
                                       SelectYourAge(signUpBody: widget.signUpBody)),
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
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
          ],
        ),
      ),
    );
  }
}
