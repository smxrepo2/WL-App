import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'gender_quistion_screen.dart';
import 'dislike_food.dart';
import 'used-Questions/i_eat_more_than_normal_when_i_am_stressed.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'how_much_move_day.dart';

class CraveFollowingFoods extends StatefulWidget {
  SignUpBody signUpBody;

  CraveFollowingFoods({Key key, this.signUpBody}) : super(key: key);

  @override
  _CraveFollowingFoodsState createState() => _CraveFollowingFoodsState();
}

class _CraveFollowingFoodsState extends State<CraveFollowingFoods> {
  String gender = '';
  List selectedOptions = [];
  List<Data> craveFood = [
    Data('Pizza', ImagePath.pizza),
    Data('Burger', ImagePath.burger),
    Data('Soda', ImagePath.soda),
    Data('Coffee', ImagePath.coffee),
    Data('Alcohol', ImagePath.alcohol),
    Data('Buttered PopCorn', ImagePath.butteredPopcorn),
    Data('Chocolate', ImagePath.chocolate),
    Data('Steak', ImagePath.steak),
    Data('Sweet Candy', ImagePath.sweetCandy),
    Data('Cheese', ImagePath.cheese),
    Data('French Fries', ImagePath.frenchFries),
    Data('Ice-Cream', ImagePath.iceCream),
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
                    questionHeader(queNo: 30, percent: .82, color: mindBorder),
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
                    //           '29/$totalQuestion',
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
                    //     percent: .75,
                    //
                    //     padding: EdgeInsets.all(0),
                    //     backgroundColor: Colors.grey[300],
                    //     progressColor: primaryColor,
                    //   ),
                    // ),
                    Container(
                        height: mobile ? Get.height * .84 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * .01,
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'I Crave for the following\n foods',
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Choose as many as you like:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: craveFood.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (selectedOptions.contains(
                                                    craveFood[index].text)) {
                                                  selectedOptions.remove(
                                                      craveFood[index].text);
                                                } else {
                                                  selectedOptions.add(
                                                      craveFood[index].text);
                                                }
                                                gender = craveFood[index].text;
                                              });
                                            },
                                            child: Container(
                                              width: Get.width * .9,
                                              height: 60,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Image.asset(
                                                        craveFood[index]
                                                            .imageUrl),
                                                  ),
                                                  Text(
                                                    craveFood[index].text,
                                                    style: listStyle,
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color:
                                                      selectedOptions.contains(
                                                              craveFood[index]
                                                                  .text)
                                                          ? mindSelect
                                                          : Colors.white,
                                                  border: Border.all(
                                                    color: selectedOptions
                                                            .contains(
                                                                craveFood[index]
                                                                    .text)
                                                        ? mindBorder
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
                      widget.signUpBody.mindQuestions.craveFoods =
                          selectedOptions.toString();

                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  IEatMoreThanNormalWhenIAmStressed(
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
                                        child:
                                            IEatMoreThanNormalWhenIAmStressed(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    } else {
                      AltDialog(context, 'Please select options.');
                    }
                  },
                  child: Padding(
                    padding: mobile
                        ? const EdgeInsets.only(bottom: 20.0, left: 20)
                        : const EdgeInsets.only(bottom: 30.0, left: 20),
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
                                style: TextStyle(color: Colors.white),
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
