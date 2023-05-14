import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';

import 'used-Questions/diet _exercise_mind.dart';
import 'used-Questions/food_favorite_choice.dart';

class FoodLikeDislikeScreen extends StatefulWidget {
  SignUpBody signUpBody;
  FoodLikeDislikeScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _FoodLikeDislikeScreenState createState() => _FoodLikeDislikeScreenState();
}

class _FoodLikeDislikeScreenState extends State<FoodLikeDislikeScreen> {
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          print("tapped");
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       '9/$totalQuestion',
                      //       style: TextStyle(color: Colors.black),
                      //     )
                      //   ],
                      // ),
                      Container()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.grey[300],
                    child: LinearPercentIndicator(
                      // width: double.infinity,
                      lineHeight: 5.0,
                      percent: .18,

                      padding: EdgeInsets.all(0),
                      backgroundColor: Colors.grey[300],
                      progressColor: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Let\'s talk food,tell us what you like and dislike',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: mobile ? 300 : 250,
                      //width: Get.width * .5,
                      child: Image.asset(
                        'assets/images/Image 45.png',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tell us about what you like to eat that might set you off course or what you do not like to eat so do not suggest you to eat, we do not judge.',
                        textAlign: TextAlign.center,
                        style: questionText30Px.copyWith(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FoodFavoriteChoice(
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
                                    child: FoodFavoriteChoice(
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
