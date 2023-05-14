import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'love_food.dart';

class DietExerciseMindScreen extends StatefulWidget {
  SignUpBody signUpBody;
  DietExerciseMindScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _DietExerciseMindScreenState createState() => _DietExerciseMindScreenState();
}

class _DietExerciseMindScreenState extends State<DietExerciseMindScreen> {
  final int _currentIntValue = 10;
  final double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  final int _currentKGValue = 50;
  final int _currentCmValue = 173;
  String mode = 'KG';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: width*.03),
          child: Column(
            children: [
              questionHeaderSimple(
                percent: .98,
                color: primaryColor,
              ),
               SizedBox(height: height*.04),
              FittedBox(
                child: Text(
                  'Weightloser provides you with\nfully customized diet based\nupon your answers!',
                  textAlign: TextAlign.center,
                  style: questionText28Px,
                ),
              ),
               SizedBox(height: height*.06),
              const FittedBox(
                child: Text(
                  'Weight loss dose not resolve around diet only.\nIt\'s a combination of:',
                  textAlign: TextAlign.center,
                  style: subNotSupport,
                ),
              ),
                SizedBox(height: height*.04),
              const Text(
                'Diet + Exercise + Mental Strength',
                textAlign: TextAlign.center,
                style: subNotSupport,
              ),
              SizedBox(height: height * .03),
              Expanded(
                  child: Image.asset(
                ImagePath.dietMind,
                fit: BoxFit.contain,
              )),
              InkWell(
                onTap: () {
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoveFood(
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
                                        LoveFood(signUpBody: widget.signUpBody)),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                      width: Get.width * .6,
                      height: height*.057,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
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
