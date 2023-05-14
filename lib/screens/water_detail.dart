import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import '../Service/Responsive.dart';
import '../widget/AppBarView.dart';
import 'NotificationScreen.dart';

class WaterDetail extends StatefulWidget {
  const WaterDetail({Key key}) : super(key: key);

  @override
  State<WaterDetail> createState() => _WaterDetailState();
}

class _WaterDetailState extends State<WaterDetail> {
  int selectedValue = 1;
  TextEditingController water = TextEditingController();
  int counter = 0;

  var volumeType = ['Cup', 'Bottle'];
  String dropDownValue = 'Cup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? customAppBar(
                context,
                elevation: 0.5,
              )
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Water Intake",
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF23233C)),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: selectedValue,
                            items: [
                              DropdownMenuItem(
                                child: Text("Today"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Week"),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    children: [
                      Text(
                        "$counter",
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF23233C)),
                      ),
                      Text(
                        " out of 10 ${dropDownValue.toLowerCase()}s of water",
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF23233C)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: double.infinity,
                    height: 7,
                    color: Colors.grey[300],
                    child: LinearPercentIndicator(
                      // width: double.infinity,
                      lineHeight: 5.0,
                      percent: counter / 10,
                      padding: EdgeInsets.all(0),
                      backgroundColor: Colors.grey[300],
                      progressColor: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (counter > 0) {
                            setState(() {
                              counter--;
                            });
                          } else {
                            setState(() {
                              counter = 0;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff797A7A),
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text(
                              "-1 ${dropDownValue.toLowerCase()}",
                              style: TextStyle(
                                  fontFamily: "LEMON MILK",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF2B2B2B)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          //margin: EdgeInsets.only(right: 20),
                          child: SizedBox(
                              height: 125,
                              width: 125,
                              child: LiquidCircularProgressIndicator(
                                  value: counter / 10,
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.lightBlue[200]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.blueAccent,
                                  borderWidth: 5.0,
                                  direction: Axis.vertical,
                                  center: SizedBox(
                                    height: 90,
                                    child: dropDownValue == 'Cup'
                                        ? Image.asset(
                                            'assets/icons/water-glass.png')
                                        : Image.asset(
                                            'assets/images/plastic-bottle.png',
                                            width: 60,
                                            height: 60,
                                          ),
                                  )))),
                      // Image.asset('assets/icons/water-glass.png'),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (counter < 10) {
                            setState(() {
                              counter++;
                            });
                          } else {
                            setState(() {
                              counter = 10;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff797A7A),
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text(
                              "+1 ${dropDownValue.toLowerCase()}",
                              style: TextStyle(
                                  fontFamily: "LEMON MILK",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF2B2B2B)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    // selecti volumt type
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Volume Type",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF23233C)),
                      ),
                      SizedBox(width: 20),
                      DropdownButton(
                        // Initial Value
                        value: dropDownValue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: volumeType.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: TextStyle(
                                    fontFamily: "LEMON MILK",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF2B2B2B))),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String newValue) {
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                      "1 ${dropDownValue.toLowerCase()} in ${dropDownValue == "Cup" ? "250 ml" : "1 litre"}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var w = "0.${water.text}";
                      var wa = double.tryParse(w);

                      print("water:" + water.text);
                      if (water.text.isNotEmpty && water.text.trim() != '0') {
                        int servingSize = 0;
                        if (dropDownValue == "Cup") {
                          servingSize = int.parse(water.text);
                        } else {
                          servingSize = int.parse(water.text) * 4;
                        }
                        print("serving size:$servingSize");
                        addWater(servingSize, context);
                      } else if (counter != 0) {
                        int servingSize = 0;
                        if (dropDownValue == "Cup") {
                          servingSize = counter;
                        } else {
                          servingSize = counter * 4;
                        }
                        print("serving size:$servingSize");
                        addWater(servingSize, context);
                      } else {
                        final snackBar = SnackBar(
                            content: Text('Water count is empty',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int userid;
addWater(int waterServing, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  await post(
    Uri.parse('$apiUrl/api/diary'),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, dynamic>{
      "userId": userid,
      "F_type_id": 6,
      "WaterServing": waterServing
    }),
  ).then((value) {
    print(value.statusCode);
    if (value.statusCode == 200) {
      //Navigator.pop(context,true);

      print("Water ${waterServing}");
      final snackBar = SnackBar(
          content: Text('Water Added', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.lightGreen);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          content: Text("Unable to add water",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }).onError((error, stackTrace) {
    final snackBar = SnackBar(
        content: Text(error.toString(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
