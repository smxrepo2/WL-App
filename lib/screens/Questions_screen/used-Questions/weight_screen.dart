import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';

import 'goal_weight_screen.dart';

class WeightScreen extends StatefulWidget {
  SignUpBody signUpBody;

  WeightScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final int _currentIntValue = 10;
  final double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentKGValue = 50;

  int _currentLbsValue = 173;
  String mode = 'KG';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: height * 0.1,
                width: width,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Biology',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Diet',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Excersie',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Mind',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sleep/Habit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.01,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: height * 0.3,
              width: width,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.2,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(227, 194, 247, 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Center(
                      child: Text(
                        'Let us understand your Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.02),
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.13,
                      left: height * 0.04,
                      child: Container(
                        height: height * 0.15,
                        width: width * 0.85,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                  child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "Select your current height",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.03),
                                ),
                              )),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Container(
                width: Get.width * .4,
                height: height * .057,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          mode = 'lbs';
                        });
                      },
                      child: Container(
                          width: Get.width * .2,
                          height: height * .056,
                          decoration: BoxDecoration(
                            color: mode == 'lbs' ? primaryColor : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'lbs',
                            style: TextStyle(
                                color: mode == 'lbs'
                                    ? Colors.white
                                    : Colors.black),
                          ))),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          mode = 'KG';
                        });
                      },
                      child: Container(
                          width: Get.width * .18,
                          height: height * .056,
                          decoration: BoxDecoration(
                            color: mode == 'KG' ? primaryColor : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'KG',
                            style: TextStyle(
                                color:
                                    mode == 'KG' ? Colors.white : Colors.black),
                          ))),
                    ),
                  ],
                )),
            SizedBox(
              height: height * .05,
            ),
            Container(
              height: height * .18,
              width: width * .6,
              decoration: const BoxDecoration(color: Color(0xffD7E2F1)),
              child: mode == 'lbs'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberPicker(
                          value: _currentLbsValue,
                          itemWidth: 60,
                          selectedTextStyle: selectedStyle,
                          minValue: 0,
                          maxValue: 10000,
                          onChanged: (value) =>
                              setState(() => _currentLbsValue = value),
                        ),
                        const SizedBox(
                          height: 150,
                          child: Center(
                            child: Text(
                              'lbs',
                              style: wordStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 1.5,
                            height: 150,
                            color: Colors.grey[300],
                          ),
                        ),
                        NumberPicker(
                          value: _currentKGValue,
                          itemWidth: 60,
                          selectedTextStyle: selectedStyle,
                          minValue: 0,
                          maxValue: 10000,
                          onChanged: (value) =>
                              setState(() => _currentKGValue = value),
                        ),
                        const SizedBox(
                          height: 150,
                          child: Center(
                            child: Text('KG', style: wordStyle),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: height * .04,
            ),
            InkWell(
              onTap: () {
                if (mode == 'KG') {
                  widget.signUpBody.dietQuestions.currentWeight =
                      _currentKGValue;
                  widget.signUpBody.dietQuestions.weightUnit = 'kg';
                  print('$_currentKGValue KG');

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoalWeightScreen(
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
                                    child: GoalWeightScreen(
                                        signUpBody: widget.signUpBody)),
                              )));
                } else if (mode == 'lbs') {
                  widget.signUpBody.dietQuestions.currentWeight =
                      _currentLbsValue;
                  widget.signUpBody.dietQuestions.weightUnit = 'lbs';
                  print('$_currentLbsValue Lbs');

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoalWeightScreen(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 430, right: 430, top: 30, bottom: 30),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GoalWeightScreen(
                                    signUpBody: widget.signUpBody),
                              ),
                            ),
                          ),
                        );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: buttonStyle,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.01,
                  width: width / 2,
                  child: LinearProgressIndicator(
                    minHeight: height * 0.02,
                    color: Colors.black,
                    value: 1.6,
                  ),
                ),
                const Text('60 % Completed'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
