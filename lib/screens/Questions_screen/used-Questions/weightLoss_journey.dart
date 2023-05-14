import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/sleep_time.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

class WeightLossJourney extends StatefulWidget {
  SignUpBody signUpBody;
  WeightLossJourney({this.signUpBody});

  @override
  State<WeightLossJourney> createState() => _WeightLossJourneyState();
}

class _WeightLossJourneyState extends State<WeightLossJourney> {
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
                    color: exBorder,
                  ),
                  SizedBox(height: height * .05),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Rest is an essential part\nof your weight loss journey!',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Container(
                      height: mobile ? 300 : 250,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.relaxing,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: height * .03,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tell us what might throw you off track or what weakens your\nyour determination to loose weight, no judgements.',
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
                          builder: (context) => SleepHours(
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
                                    child: SleepHours(
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
