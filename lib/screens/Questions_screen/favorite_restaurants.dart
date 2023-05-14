import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/rest_id.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/screens/food_screens/NewAddFood.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/widget/question_Header.dart';

import 'used-Questions/cant_eat_food_for_any_reason.dart';
import 'used-Questions/consider_yourself.dart';
import 'used-Questions/goal_weight_screen.dart';
import 'loss_weight_while_eating_food.dart';

class FavoriteRestaurants extends StatefulWidget {
  SignUpBody signUpBody;

  FavoriteRestaurants({Key key, this.signUpBody}) : super(key: key);

  @override
  _FavoriteRestaurantsState createState() => _FavoriteRestaurantsState();
}

class _FavoriteRestaurantsState extends State<FavoriteRestaurants> {
  String gender = '';
  int genderid;
  List selectedOptions = [];
  List<RestId> restId = [];
  List<dynamic> allMovies = [];
  bool loading = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getRestuarants();
  }

  Future<dynamic> getRestuarants() async {
    var client = http.Client();
    try {
      var url = Uri.parse('https://weightchoper.somee.com/api/restaurant');
      var response = await client.get(url, headers: {
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
        'User-Agent': 'PostmanRuntime/7.28.4',
      });
      if (response != null && response.statusCode == 200) {
        print("Restaurants ${response.body}");
        setState(() {
          allMovies = json.decode(response.body)['restaurants'];
          loading = false;
        });
        print(allMovies.length);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                questionHeader(
                  queNo: 11,
                  percent: .50,
                  color: selectBorderColor,
                ),
                SizedBox(
                  height: height * .05,
                ),
                // Row(
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
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             '12/$totalQuestion',
                //             style: TextStyle(color: Colors.black),
                //           )
                //         ],
                //       ),
                //     )
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
                //     percent: .26,
                //
                //     padding: EdgeInsets.all(0),
                //     backgroundColor: Colors.grey[300],
                //     progressColor: primaryColor,
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tell us about your favorite restaurants :',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Container(
                  height: Get.height * .77,
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.blue,
                        ))
                      : allMovies.length == 0
                          ? Center(
                              child: Text("No Restaurants Available"),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedOptions
                                          .contains(allMovies[index]['Name'])) {
                                        selectedOptions
                                            .remove(allMovies[index]['Name']);
                                        restId.remove(RestId(
                                            RestuarantId: allMovies[index]
                                                ['Id']));
                                      } else {
                                        selectedOptions
                                            .add(allMovies[index]['Name']);
                                        restId.add(RestId(
                                            RestuarantId: allMovies[index]
                                                ['Id']));
                                      }
                                      gender = allMovies[index]['Name'];
                                      genderid = allMovies[index]['Id'];
                                      print(gender);
                                      print(genderid);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Padding(
                                          //   padding:
                                          //   const EdgeInsets.all(16.0),
                                          //   child: Image.asset(
                                          //     'assets/images/58429d58a6515b1e0ad75ae8.png',
                                          //     width: 30,
                                          //     height: 30,
                                          //   ),
                                          // ),
                                          Center(
                                            child: Text(
                                              '${allMovies[index]['Name']}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '$imageBaseUrl${allMovies[index]['Image']}'),
                                              fit: BoxFit.cover),
                                          color: selectedOptions.contains(
                                                  allMovies[index]['Name'])
                                              ? selectColor
                                              : Colors.white,
                                          border: Border.all(
                                            color: selectedOptions.contains(
                                                    allMovies[index]['Name'])
                                                ? selectBorderColor
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ),
                                );
                              },
                              itemCount: allMovies.length,
                            ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: mobile ? Get.width * .15 : 25,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () async {
                    if (selectedOptions.isNotEmpty) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setInt('restId', genderid);
                      pref.setString('restname', gender);
                      widget.signUpBody.dietQuestions.favRestuarant =
                          selectedOptions.toString();
                      widget.signUpBody.restaurants = restId;
                      print(selectedOptions.toString());
                      print(widget.signUpBody.dietQuestions.favRestuarant
                          .toString());
                      print(widget.signUpBody.restaurants);

                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CantEatFoodForAnyReason(
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
                                        child: CantEatFoodForAnyReason(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    } else {
                      widget.signUpBody.restaurants = restId;
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CantEatFoodForAnyReason(
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
                                        child: CantEatFoodForAnyReason(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                      //AltDialog(context, 'Please select options.');
                    }
                  },
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
      )),
    );
  }
}

class restaurant {
  final String name;
  final String url;
  restaurant({this.name, this.url});
}

final restaurants = [
  restaurant(name: "hello", url: " assets/images/584298bca6515b1e0ad75adc.png"),
  restaurant(name: "Hi", url: " assets/images/584298bca6515b1e0ad75adc.png"),
  restaurant(name: "Johan", url: " assets/images/584298bca6515b1e0ad75adc.png"),
  restaurant(name: "Jaki", url: " assets/images/584298bca6515b1e0ad75adc.png"),
];

class Rest extends StatefulWidget {
  SignUpBody signUpBody;

  Rest({Key key, this.signUpBody}) : super(key: key);

  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest> {
  final List<restaurant> _categories = restaurants;
  String gender = '';
  List selectedOptions = [];
  @override
  Widget build(BuildContext context) {
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
                        Row(
                          children: [
                            Text(
                              '13/$totalQuestion',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
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
                        percent: .26,

                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.grey[300],
                        progressColor: primaryColor,
                      ),
                    ),
                    Container(
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
                                  'Tell us about your favorite restaurants:',
                                  textAlign: TextAlign.center,
                                  style: questionText30Px,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: _categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (selectedOptions.contains(
                                          _categories[index].name,
                                        )) {
                                          selectedOptions
                                              .remove(_categories[index].name);
                                        } else {
                                          selectedOptions.add(
                                            _categories[index].name,
                                          );
                                        }
                                        gender = _categories[index].name;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Image.asset(
                                                _categories[index].url,
                                                // 'assets/images/58429d58a6515b1e0ad75ae8.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Text(
                                              _categories[index].name,
                                              // 'Wendy\'s',
                                              style: TextStyle(fontSize: 15),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: selectedOptions.contains(
                                                _categories[index].name,
                                              )
                                                  ? primaryColor
                                                  : Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 5,
              left: Get.width * .15,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: InkWell(
                    onTap: () {
                      if (selectedOptions.isNotEmpty) {
                        widget.signUpBody.dietQuestions.favRestuarant =
                            selectedOptions.toString();
                        print(selectedOptions.toString());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CantEatFoodForAnyReason(
                                  signUpBody: widget.signUpBody,
                                )));
                      } else {
                        AltDialog(context, 'Please select options.');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
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
