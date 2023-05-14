import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';

import 'define_current_life.dart';
import 'used-Questions/diet _exercise_mind.dart';
import 'favorite_restaurants.dart';
import 'food_like_dislike.dart';

class HowMuchMoveInADAy extends StatefulWidget {
  SignUpBody signUpBody;
  HowMuchMoveInADAy({Key key, this.signUpBody}) : super(key: key);

  @override
  _HowMuchMoveInADAyState createState() => _HowMuchMoveInADAyState();
}

class _HowMuchMoveInADAyState extends State<HowMuchMoveInADAy> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    return Scaffold(
      body: SafeArea(
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
                    percent: .36,

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
                      'Now, lets gauge how much you move throughout the day',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: mobile ? 100 : 20,
                ),
                Container(

                    //width: Get.width * .5,
                    child: Image.asset(
                  'assets/images/Group 22672.png',
                  fit: BoxFit.contain,
                )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Let's see what level you are at your current stage.",
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
                        builder: (context) => DefineCurrentLife(
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
                                  child: DefineCurrentLife(
                                    signUpBody: widget.signUpBody,
                                  )),
                            )));
              },
              child: Padding(
                padding: mobile
                    ? const EdgeInsets.only(bottom: 60.0, left: 20)
                    : const EdgeInsets.only(bottom: 30.0, left: 20),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
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
    );
  }
}
