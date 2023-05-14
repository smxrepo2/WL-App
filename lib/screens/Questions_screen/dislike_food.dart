import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/througout_msg.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/goal_weight_screen.dart';
import 'lose_weightmsg.dart';
import 'loss_weight_while_eating_food.dart';

class DislikeFoodChoice extends StatefulWidget {
  SignUpBody signUpBody;
  DislikeFoodChoice({Key key, this.signUpBody}) : super(key: key);

  @override
  _DislikeFoodChoiceState createState() => _DislikeFoodChoiceState();
}

class _DislikeFoodChoiceState extends State<DislikeFoodChoice> {
  String gender = '';
  List selectedOptions = [];
  List<dynamic> allCuisines = [];
  Future<dynamic> getCuisines() async {
    final response = await get(Uri.parse("$apiUrl/api/cuisine"));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        allCuisines = json.decode(response.body);
      });
      // return json.decode(response.body);
    } else {
      throw Exception('Failed to load Cuisines');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCuisines();
    print("Fav ${widget.signUpBody.dietQuestions.favCuisine}");
  }

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
                      queNo: 10,
                      percent: .47,
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
                    //           '11/$totalQuestion',
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
                    //     percent: .22,
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
                                    'Cuisines you absolutely\n DO NOT want to try:',
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
                                    'Choose as many as you like :',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              allCuisines.length == 0
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: allCuisines.length,
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
                                                        .contains(allCuisines[
                                                                index]
                                                            ['CuisineName'])) {
                                                      selectedOptions.remove(
                                                          allCuisines[index]
                                                              ['CuisineName']);
                                                    } else {
                                                      selectedOptions.add(
                                                          allCuisines[index]
                                                              ['CuisineName']);
                                                    }
                                                    gender = allCuisines[index]
                                                        ['CuisineName'];
                                                  });
                                                  print(selectedOptions.length);
                                                },
                                                child: Container(
                                                  width: Get.width * .9,
                                                  height: 60,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Image.asset(
                                                            'assets/images/spaguetti.png'),
                                                      ),
                                                      Text(
                                                        allCuisines[index]
                                                            ['CuisineName'],
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: selectedOptions
                                                              .contains(allCuisines[
                                                                      index][
                                                                  'CuisineName'])
                                                          ? selectColor
                                                          : Colors.white,
                                                      border: Border.all(
                                                        color: selectedOptions
                                                                .contains(allCuisines[
                                                                        index][
                                                                    'CuisineName'])
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
                                height: 10,
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
                      widget.signUpBody.dietQuestions.noCuisine =
                          selectedOptions.toString();
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
                      widget.signUpBody.dietQuestions.noCuisine = "Nothing";
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoseWeightMsg(
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
                                        child: LoseWeightMsg(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                      // AltDialog(context, 'Please select options.');
                    }
                    print(widget.signUpBody.dietQuestions.noCuisine);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
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
