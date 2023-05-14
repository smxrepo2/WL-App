import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/diet _exercise_mind.dart';
import 'favorite_restaurants.dart';
import 'food_like_dislike.dart';

class LossWeightWhileEatingFood extends StatefulWidget {
  SignUpBody signUpBody;
  LossWeightWhileEatingFood({Key key, this.signUpBody}) : super(key: key);

  @override
  _LossWeightWhileEatingFoodState createState() =>
      _LossWeightWhileEatingFoodState();
}

class _LossWeightWhileEatingFoodState extends State<LossWeightWhileEatingFood> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  questionHeader(queNo: 9, percent: .09),
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
                  //     // Row(
                  //     //   children: [
                  //     //     Text(
                  //     //       '12/$totalQuestion',
                  //     //       style: TextStyle(color: Colors.black),
                  //     //     )
                  //     //   ],
                  //     // ),
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
                  //     percent: .24,
                  //
                  //     padding: EdgeInsets.all(0),
                  //     backgroundColor: Colors.grey[300],
                  //     progressColor: primaryColor,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'You can still lose weight while eating your\nfavorite restaurant food.',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      //width: Get.width * .5,
                      child: Image.asset(
                        'assets/images/pngwing.com (6).png',
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ' Weight loser app reviews every meal in the menu of 10s of thousands of restaurants and recommends appropriate dishes for you based upon your plan.',
                        textAlign: TextAlign.center,
                        style: darkText12Px,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavoriteRestaurants(
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
                                    child: FavoriteRestaurants(
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
