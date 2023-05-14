import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'food_favorite_choice.dart';

class ConsiderYourself extends StatefulWidget {
  SignUpBody signUpBody;
  ConsiderYourself({Key key, this.signUpBody}) : super(key: key);

  @override
  _ConsiderYourselfState createState() => _ConsiderYourselfState();
}

class _ConsiderYourselfState extends State<ConsiderYourself> {
  String answer = '';
  List<dynamic> allCategory = [];
  bool loading = true;
  Future<dynamic> getFoodCategories() async {
    final response = await get(
      Uri.parse('$apiUrl/api/category/food'),
    );
    print("response ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        allCategory = json.decode(response.body);
        loading = false;
      });
    } else {
      throw Exception('Unable to Load');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFoodCategories();
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
                      queNo: 7,
                      percent: .35,
                      color: primaryColor,
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
                    //           '13/$totalQuestion',
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
                    //     percent: .28,
                    //
                    //     padding: EdgeInsets.all(0),
                    //     backgroundColor: Colors.grey[300],
                    //     progressColor: primaryColor,
                    //   ),
                    // ),

                    SizedBox(
                        height: mobile ? Get.height * .80 : Get.height * .80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'What are your food\n preferences?',
                                    textAlign: TextAlign.center,
                                    style: questionText30Px,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: allCategory.length,
                                      itemBuilder: (context, index) {
                                        print(allCategory.length);
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: mobile
                                                  ? const EdgeInsets.only(
                                                      left: 25, right: 25)
                                                  : const EdgeInsets.only(
                                                      left: 8, right: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    answer = allCategory[index]
                                                        ['Name'];
                                                  });
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
                                                            'assets/images/chicken-leg.png'),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            allCategory[index]
                                                                ['Name'],
                                                            style: const TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            allCategory[index]
                                                                ['Description'],
                                                            style: const TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: answer ==
                                                              allCategory[index]
                                                                  ['Name']
                                                          ? Colors.white
                                                          : Colors.white,
                                                      border: Border.all(
                                                        color: answer ==
                                                                allCategory[
                                                                        index]
                                                                    ['Name']
                                                            ? primaryColor
                                                            : Colors.grey,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      }),
                              const SizedBox(
                                height: 15,
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
                    //widget.signUpBody.dietQuestions.c=answer;
                    if (answer == "") {
                      AltDialog(context, 'Please select options.');
                    } else {
                      widget.signUpBody.dietQuestions.foodType = answer;
                      print(widget.signUpBody.dietQuestions.foodType);
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FoodFavoriteChoice(
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
                                        child: FoodFavoriteChoice(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
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
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: const Center(
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
