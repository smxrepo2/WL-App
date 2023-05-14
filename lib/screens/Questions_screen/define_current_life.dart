import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/exMsg.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/cant_eat_food_for_any_reason.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'in_the_past.dart';
import 'loss_weight_while_eating_food.dart';

class DefineCurrentLife extends StatefulWidget {
  SignUpBody signUpBody;

  DefineCurrentLife({Key key, this.signUpBody}) : super(key: key);

  @override
  _DefineCurrentLifeState createState() => _DefineCurrentLifeState();
}

class _DefineCurrentLifeState extends State<DefineCurrentLife> {
  String gender = '';
  List<Data> currentLife = [
    Data('I focus on diet and exercise', ImagePath.diet),
    Data('I watch my diet, but I am not active', ImagePath.watchDiet),
    Data('I am active and do daily exercise,\nbut I cannot control my eating.',
        ImagePath.activeDiet),
    Data('I do not watch my diet, and I am\nnot active.', ImagePath.notDiet)
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
                      queNo: 14,
                      percent: .55,
                      color: exBorder,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    Container(
                        height: mobile ? Get.height * .83 : Get.height * .80,
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
                                    'How do you define your\ncurrent Lifestyle?',
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: currentLife.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                gender =
                                                    currentLife[index].text;
                                              });
                                            },
                                            child: Container(
                                              width: Get.width * .9,
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Image.asset(
                                                        currentLife[index]
                                                            .imageUrl),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    currentLife[index].text,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: gender ==
                                                          currentLife[index]
                                                              .text
                                                      ? exSelect
                                                      : Colors.white,
                                                  border: Border.all(
                                                    color: gender ==
                                                            currentLife[index]
                                                                .text
                                                        ? exBorder
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
                    if (gender != '') {
                      widget.signUpBody.dietQuestions.lifeStyle = gender;
                      print(widget.signUpBody.dietQuestions.lifeStyle);
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InThePast(
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
                                        child: InThePast(
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
