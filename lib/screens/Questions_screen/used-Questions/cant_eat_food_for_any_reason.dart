import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/dislike_food.dart';
import 'package:weight_loser/screens/Questions_screen/overweight_sg.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/througout_msg.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'do_you_know.dart';

class CantEatFoodForAnyReason extends StatefulWidget {
  SignUpBody signUpBody;

  CantEatFoodForAnyReason({Key key, this.signUpBody}) : super(key: key);

  @override
  _CantEatFoodForAnyReasonState createState() =>
      _CantEatFoodForAnyReasonState();
}

class _CantEatFoodForAnyReasonState extends State<CantEatFoodForAnyReason> {
  String gender = '';
  List selectedOptions = [];
  List item = [
    'Pork',
    'Beef',
    'Chicken',
    'Turkey',
    'Lamb',
    'Goat',
    'Diary',
    'Eggs',
    'Soy',
    'Breads',
    'Nuts',
    'Fruits',
    'Non-starchy',
    'Pasta',
    'Beans',
    'Starchy Vegetables',
    'Seafood',
    'Rice',
    'Dairy ( Milk, Cheese Butter)'
  ];

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    questionHeader(
                      queNo: 9,
                      percent: .45,
                      color: selectBorderColor,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         print("tapped");
                    //       },
                    //       child: Container(
                    //         child: Icon(
                    //           Icons.arrow_back,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Text(
                    //           '14/$totalQuestion',
                    //           style: TextStyle(color: Colors.black),
                    //         )
                    //       ],
                    //     ),
                    //     Container()
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 5,
                    //   color: Colors.grey[300],
                    //   child: LinearPercentIndicator(
                    //     // width: double.infinity,
                    //     lineHeight: 5.0,
                    //     percent: .30,
                    //
                    //     padding: EdgeInsets.all(0),
                    //     backgroundColor: Colors.grey[300],
                    //     progressColor: primaryColor,
                    //   ),
                    // ),
                    Container(
                        height: mobile ? Get.height * .83 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tell us which foods you cannot eat for any reason',
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 25),
                                  child: Text(
                                    'Allergies, religious reasons, enzyme,deficiency, don’t like.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: item.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (selectedOptions
                                                    .contains(item[index])) {
                                                  selectedOptions
                                                      .remove(item[index]);
                                                } else {
                                                  selectedOptions
                                                      .add(item[index]);
                                                }
                                                gender = item[index];
                                              });
                                            },
                                            child: Container(
                                              width: Get.width * .9,
                                              height: 60,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(item[index],
                                                      style: listStyle)
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: selectedOptions
                                                          .contains(item[index])
                                                      ? selectColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                    color: selectedOptions
                                                            .contains(
                                                                item[index])
                                                        ? selectBorderColor
                                                        : Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: mobile ? Get.width * .15 : 25,
              child: Container(
                child: InkWell(
                  onTap: () {
                    if (selectedOptions.isNotEmpty) {
                      widget.signUpBody.dietQuestions.restrictedFood =
                          selectedOptions.toString();
                      print(widget.signUpBody.dietQuestions.restrictedFood);
                      widget.signUpBody.dietQuestions.allergies =
                          selectedOptions.toString();
                      widget.signUpBody.dietQuestions.noCuisine = "";
                      print(widget.signUpBody.dietQuestions.noCuisine);
                      Responsive1.isMobile(context)
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ThroughOutMsg(
                                    signUpBody: widget.signUpBody,
                                  )))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 430,
                                        right: 430,
                                        top: 30,
                                        bottom: 30),
                                    child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ThroughOutMsg(
                                            signUpBody: widget.signUpBody)),
                                  )));
                    } else {
                      AltDialog(context, 'Please select options.');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: mobile ? Get.width * .6 : Get.width * .3,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
