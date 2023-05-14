import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/Choice%20Chip%20Dialog.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';
import '../Questions_screen/newQuestions/constant.dart';
import 'components.dart';

class PersonalSetting extends StatefulWidget {
  const PersonalSetting({Key key}) : super(key: key);

  @override
  _PersonalSettingState createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  int HeightmeasureUnit = 0;
  int weightGoalMeasureUnit = 0;
  int weightCurrentMeasureUnit = 0;
  int _currentValue;
  int selectedGenderOption;
  int yearsOld = 0;
  Future _getPersonalSettingFuture = getPersonalDetail();
  double feet;
  int inch;
  double cm;
  double kg;
  double lbs;
  double sliderValue;
  double currentKg;
  double currentLbs;
  double userHeight;
  double currentSliderValue;
  var height;

  final sleepController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List medical = [
    "High blood pressure",
    "Heart disease or stroke",
    "Diabetes",
    "Kidney diseases",
    "High cholesterol",
    "Severe Arthritis",
    "Liver disease",
    "Depression",
    "Chronic back pain",
    "Eating disorders",
    "Normal"
  ];
  List<Map<String, dynamic>> genderInfo = [
    {
      "gender": "Male",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/male-sign-microsoft.png',
    },
    {
      "gender": "Female",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/female-sign-microsoft.png',
    },
    {
      "gender": "Non Binary",
      "icon": 'https://images.emojiterra.com/google/android-11/512px/26a7.png',
    },
  ];
  List medicalCondition;
  static double checkDouble(dynamic value) {
    if (value is int) {
      return double.parse(value.toString());
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    print("tapped");
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Personal',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            FutureBuilder<DashboardModel>(
              future: fetchDashboardData(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      listTileComponentInt(
                          context: context,
                          title: 'Age',
                          subtitle: snapshot.data.profileVM.age,
                          image: 'assets/svg_icons/age_svg.svg',
                          oNTap: () {
                            showToast(
                                text: 'Change from Date of Birth',
                                context: context);
                            // showDialog(
                            //     context: context,
                            //     builder: (_) {
                            //       return AlertDialog(
                            //         insetPadding: EdgeInsets.all(0),
                            //         content: Container(
                            //           height: 250,
                            //           child: Column(
                            //             children: [
                            //               const SizedBox(height: 15),
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceEvenly,
                            //                 children: const [
                            //                   Text(
                            //                     'Month',
                            //                     style: TextStyle(
                            //                       fontFamily: 'Open Sans',
                            //                       fontSize: 15,
                            //                       color: Color(0xff86aef3),
                            //                       letterSpacing:
                            //                           -0.44999999999999996,
                            //                       fontWeight: FontWeight.w700,
                            //                     ),
                            //                     textAlign: TextAlign.center,
                            //                     softWrap: false,
                            //                   ),
                            //                   Text(
                            //                     'Day ',
                            //                     style: TextStyle(
                            //                       fontFamily: 'Open Sans',
                            //                       fontSize: 15,
                            //                       color: Color(0xff86aef3),
                            //                       letterSpacing:
                            //                           -0.44999999999999996,
                            //                       fontWeight: FontWeight.w700,
                            //                     ),
                            //                     textAlign: TextAlign.center,
                            //                     softWrap: false,
                            //                   ),
                            //                   Text(
                            //                     'Year',
                            //                     style: TextStyle(
                            //                       fontFamily: 'Open Sans',
                            //                       fontSize: 15,
                            //                       color: Color(0xff86aef3),
                            //                       letterSpacing:
                            //                           -0.44999999999999996,
                            //                       fontWeight: FontWeight.w700,
                            //                     ),
                            //                     textAlign: TextAlign.center,
                            //                     softWrap: false,
                            //                   )
                            //                 ],
                            //               ),
                            //               Container(
                            //                 width: 300,
                            //                 height: 200,
                            //                 child: ScrollDatePicker(
                            //                   selectedDate: _selectedDate,
                            //                   minimumDate: DateTime(1922),
                            //                   locale: const Locale('en'),
                            //                   onDateTimeChanged:
                            //                       (DateTime value) {
                            //                     setState(() {
                            //                       _selectedDate = value;
                            //                       yearsOld =
                            //                           DateTime.now().year -
                            //                               _selectedDate.year;
                            //                       print('years old $yearsOld');
                            //                     });
                            //                   },
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         actions: [
                            //           TextButton(
                            //             child: Text("Cancel"),
                            //             onPressed: () {
                            //               Navigator.pop(context);
                            //             },
                            //           ),
                            //           TextButton(
                            //             child: Text("Update"),
                            //             onPressed: () {
                            //               updateAge(yearsOld).then((value) {
                            //                 setState(() {});
                            //                 Navigator.pop(context, true);
                            //               });
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     });
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('unable to load data'),
                  );
                }
                // By default, show a loading spinner.
                return const Center();
              },
            ),
            FutureBuilder(
              future: _getPersonalSettingFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  print('snapshot here ${snapshot.data}');
                  medicalCondition = snapshot.data['MedicalCondition']
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll(" ", "")
                      .split(',');
                  medicalCondition = medicalCondition.toSet().toList();
                  print(medicalCondition.toString());
                  var p = Provider.of<UserDataProvider>(context, listen: false);
                  p.updateHeight(checkDouble(snapshot.data['Height']) ?? "-");
                  p.updateGender(snapshot.data['Gender'] ?? "-");
                  p.updateSleepingHours(snapshot.data['SleepTime'] ?? "-");
                  p.updateWeightGoal(snapshot.data['GoalWeight'] ?? "-");
                  p.updateCurrentWeight(snapshot.data['CurrentWeight'] ?? "-");
                  p.updateMedicalCondition(medicalCondition);
                  double h = checkDouble(snapshot.data['Height']);
                  String weightUnit = snapshot.data['WeightUnit'];
                  if (weightUnit == 'Kg') {
                    int val = snapshot.data['CurrentWeight'];
                    int val2 = snapshot.data['GoalWeight'];
                    currentKg = val.toDouble();
                    currentLbs = currentKg * 2.205;
                    kg = val2.toDouble();
                    lbs = kg * 2.205;
                    currentSliderValue = currentLbs;
                    sliderValue = lbs;
                  } else {
                    int val = snapshot.data['CurrentWeight'];
                    int val2 = snapshot.data['GoalWeight'];
                    currentLbs = val.toDouble();
                    currentKg = currentLbs / 2.205;
                    lbs = val2.toDouble();
                    kg = lbs / 2.205;
                    currentSliderValue = currentKg;
                    sliderValue = kg;
                  }
                  feet = double.parse(h.toString().split('.')[0]);
                  inch = int.parse(h.toString().split('.')[1]);
                  cm = h * 30;
                  String first = h.toString().split('.')[0];
                  String second = h.toString().split('.')[1];
                  String third = '$first$second';
                  String selectedGender = snapshot.data['Gender'];
                  if (selectedGender == 'Male') {
                    selectedGenderOption = 0;
                  } else if (selectedGender == 'Female') {
                    selectedGenderOption = 1;
                  } else {
                    selectedGenderOption = 2;
                  }
                  _currentValue = int.parse(third);
                  if (_currentValue > 84) {
                    String temp = _currentValue.toString().substring(0, 2);
                    _currentValue = int.parse(temp);
                  }
                  return Consumer<UserDataProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return Column(
                        children: [
                          listTileComponent(
                              context: context,
                              title: 'Height',
                              subtitle: value.height.toString(),
                              image: 'assets/svg_icons/height_svg.svg',
                              oNTap: () {
                                showDialog<bool>(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: StatefulBuilder(
                                            builder: (context, setState) {
                                          return Container(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          HeightmeasureUnit = 0;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HeightmeasureUnit ==
                                                                  0
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Ft',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: HeightmeasureUnit ==
                                                                      0
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          HeightmeasureUnit = 1;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HeightmeasureUnit ==
                                                                  1
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Cm',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: HeightmeasureUnit ==
                                                                      1
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    HeightmeasureUnit == 1
                                                        ? Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 140,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        30,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xffffffff),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Color(
                                                                      0x20000000),
                                                                  offset:
                                                                      Offset(
                                                                          0, 3),
                                                                  blurRadius: 6,
                                                                ),
                                                              ],
                                                            ),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: '$cm'
                                                                        .split(
                                                                            '.')[0],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          30,
                                                                      color: Color(
                                                                          0xc423233c),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text: 'cm',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xc4797a7a),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        30,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xffffffff),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Color(
                                                                      0x20000000),
                                                                  offset:
                                                                      Offset(
                                                                          0, 3),
                                                                  blurRadius: 6,
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                IntrinsicHeight(
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '$feet'.split('.')[0],
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 30,
                                                                              color: Color(0xc423233c),
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const TextSpan(
                                                                            text:
                                                                                'ft',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 15,
                                                                              color: Color(0xc4797a7a),
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const VerticalDivider(
                                                                      thickness:
                                                                          0.75,
                                                                      color: Color(
                                                                          0xff707070),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '$inch',
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 30,
                                                                              color: Color(0xc423233c),
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          const TextSpan(
                                                                            text:
                                                                                'in',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 15,
                                                                              color: Color(0xc4797a7a),
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      child: NumberPicker(
                                                        textMapper:
                                                            (numberText) {
                                                          int value = int.parse(
                                                              numberText);
                                                          if (value == 84) {
                                                            return '';
                                                          }
                                                          return value % 12 == 0
                                                              ? '_____'
                                                              : '___';
                                                        },
                                                        value: _currentValue,
                                                        minValue: 0,
                                                        maxValue: 84,
                                                        itemCount: 12,
                                                        itemWidth: 70,
                                                        selectedTextStyle:
                                                            const TextStyle(
                                                                color: Color(
                                                                    0xff707070),
                                                                fontSize: 20),
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Color(
                                                                    0xff707070),
                                                                fontSize: 20),
                                                        itemHeight: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xff6C9DF0)),
                                                        ),
                                                        onChanged: (value) =>
                                                            setState(() {
                                                          _currentValue = value;
                                                          feet = _currentValue /
                                                              12;
                                                          inch = _currentValue %
                                                              12;
                                                          cm = _currentValue *
                                                              2.54;
                                                        }),
                                                        haptics: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              if (HeightmeasureUnit == 0) {
                                                if (feet < 3) {
                                                  showToast(
                                                      text:
                                                          'Enter Genuine Height',
                                                      context: context);
                                                } else {
                                                  height = double.parse(
                                                      '${feet.toInt()}.${inch}');
                                                  value.updateHeight(height);
                                                  updateHeight(height);
                                                  Navigator.pop(context, true);
                                                }
                                              } else {
                                                if (cm < 30.0) {
                                                  showToast(
                                                      text:
                                                          'Enter Genuine Height',
                                                      context: context);
                                                } else {
                                                  height = double.parse('$cm');
                                                  value.updateHeight(height);
                                                  updateHeight(height);
                                                  Navigator.pop(context, true);
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponent(
                              context: context,
                              title: 'Gender',
                              subtitle: value.gender,
                              image: 'assets/svg_icons/gender_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: genderInfo.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedGenderOption =
                                                              index;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: selectedGenderOption ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width:
                                                                  selectedGenderOption ==
                                                                          index
                                                                      ? 2
                                                                      : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        leading:
                                                            Transform.translate(
                                                          offset: const Offset(
                                                              0, 3),
                                                          child: Image.network(
                                                              '${genderInfo[index]['icon']}',
                                                              width: 15,
                                                              height: 15),
                                                        ),
                                                        title: Text(
                                                          genderInfo[index]
                                                              ['gender'],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff23233c),
                                                            letterSpacing:
                                                                -0.44999999999999996,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          softWrap: false,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                if (selectedGenderOption !=
                                                    -1) {
                                                  updateGender(genderInfo[
                                                          selectedGenderOption]
                                                      ['gender']);
                                                  value.updateGender(genderInfo[
                                                          selectedGenderOption]
                                                      ['gender']);
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponentInt(
                              context: context,
                              title: 'Weight Goal',
                              subtitle: value.weightGoal,
                              image: 'assets/svg_icons/weight_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 300,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          weightGoalMeasureUnit =
                                                              0;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: weightGoalMeasureUnit ==
                                                                  0
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Kg',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: weightGoalMeasureUnit ==
                                                                      0
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          weightGoalMeasureUnit =
                                                              1;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: weightGoalMeasureUnit ==
                                                                  1
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Lbs',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: weightGoalMeasureUnit ==
                                                                      1
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05),
                                                Container(
                                                  width: 127,
                                                  height: 127,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffffffff),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.elliptical(
                                                                9999.0,
                                                                9999.0)),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: const Color(
                                                            0xff707070)),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x29000000),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              weightGoalMeasureUnit ==
                                                                      0
                                                                  ? '$kg'.split(
                                                                      '.')[0]
                                                                  : '$lbs'.split(
                                                                      '.')[0],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 30,
                                                            color: Color(
                                                                0xff23233c),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              weightGoalMeasureUnit ==
                                                                      0
                                                                  ? ' Kg'
                                                                  : ' Lbs',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff23233c),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Slider(
                                                      value: sliderValue,
                                                      min: 0,
                                                      max: 400,
                                                      activeColor: const Color(
                                                          0xff4885ED),
                                                      inactiveColor:
                                                          const Color(
                                                              0xffEBEBEB),
                                                      thumbColor: const Color(
                                                          0xffE87D21),
                                                      onChanged: (onChanged) {
                                                        setState(() {
                                                          sliderValue =
                                                              onChanged;
                                                          lbs = onChanged;
                                                          kg = lbs / 2.205;
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                if (weightGoalMeasureUnit ==
                                                    0) {
                                                  if (kg > 30) {
                                                    var goalWeight = kg.toInt();
                                                    updateGoalWeight(
                                                        goalWeight);
                                                    value.updateWeightGoal(
                                                        goalWeight);
                                                  } else {
                                                    showToast(
                                                        text:
                                                            'Enter Genuine Weight',
                                                        context: context);
                                                  }
                                                } else {
                                                  if (lbs > 60) {
                                                    var goalWeight =
                                                        lbs.toInt();
                                                    updateGoalWeight(
                                                        goalWeight);
                                                    value.updateWeightGoal(
                                                        goalWeight);
                                                  } else {
                                                    showToast(
                                                        text:
                                                            'Enter Genuine Weight',
                                                        context: context);
                                                  }
                                                }
                                                setState(() {
                                                  getPersonalDetail();
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponentInt(
                              context: context,
                              title: 'Current Weight',
                              subtitle: value.currentWeight,
                              image: 'assets/svg_icons/weight_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 300,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          weightCurrentMeasureUnit =
                                                              0;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: weightCurrentMeasureUnit ==
                                                                  0
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Kg',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: weightCurrentMeasureUnit ==
                                                                      0
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          weightCurrentMeasureUnit =
                                                              1;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: weightCurrentMeasureUnit ==
                                                                  1
                                                              ? const Color(
                                                                  0xff4885ED)
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff4885ed)),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 74.5,
                                                          height: 31,
                                                          child: Text(
                                                            'Lbs',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: weightCurrentMeasureUnit ==
                                                                      1
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0xff2b2b2b),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05),
                                                Container(
                                                  width: 127,
                                                  height: 127,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffffffff),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.elliptical(
                                                                9999.0,
                                                                9999.0)),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: const Color(
                                                            0xff707070)),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x29000000),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: weightCurrentMeasureUnit ==
                                                                  0
                                                              ? '$currentKg'
                                                                  .split('.')[0]
                                                              : '$currentLbs'
                                                                  .split(
                                                                      '.')[0],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 30,
                                                            color: Color(
                                                                0xff23233c),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              weightCurrentMeasureUnit ==
                                                                      0
                                                                  ? ' Kg'
                                                                  : ' Lbs',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff23233c),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Slider(
                                                      value: currentSliderValue,
                                                      min: 0,
                                                      max: 400,
                                                      activeColor: const Color(
                                                          0xff4885ED),
                                                      inactiveColor:
                                                          const Color(
                                                              0xffEBEBEB),
                                                      thumbColor: const Color(
                                                          0xffE87D21),
                                                      onChanged: (onChanged) {
                                                        setState(() {
                                                          currentSliderValue =
                                                              onChanged;
                                                          currentLbs =
                                                              onChanged;
                                                          currentKg =
                                                              currentLbs /
                                                                  2.205;
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                if (weightCurrentMeasureUnit ==
                                                    0) {
                                                  if (currentKg > 30) {
                                                    var currentWeight =
                                                        currentKg.toInt();
                                                    value.updateCurrentWeight(
                                                        currentWeight);
                                                    updateCurrentWeight(
                                                        currentWeight);
                                                  } else {
                                                    showToast(
                                                        text:
                                                            'Enter Genuine Weight',
                                                        context: context);
                                                  }
                                                } else {
                                                  if (currentLbs > 30) {
                                                    var currentWeight =
                                                        currentLbs.toInt();
                                                    value.updateCurrentWeight(
                                                        currentWeight);
                                                    updateCurrentWeight(
                                                        currentWeight);
                                                  } else {
                                                    showToast(
                                                        text:
                                                            'Enter Genuine Weight',
                                                        context: context);
                                                  }
                                                }
                                                setState(() {
                                                  getPersonalDetail();
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponent(
                              context: context,
                              title: 'Date Of Birth',
                              subtitle:
                                  snapshot.data['DOB'].substring(0, 10) ?? "-",
                              image: 'assets/svg_icons/birthday_svg.svg',
                              oNTap: () {
                                _selectDate(context);
                                // updateDob(selectedDate.toString());
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponentInt(
                              context: context,
                              title: 'Sleeping Hours',
                              subtitle: value.sleepingHours,
                              image: 'assets/svg_icons/sleepinghours_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.all(0),
                                        content: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: sleepController,
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  cursorColor: Colors.grey,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: false),
                                                  decoration: InputDecoration(
                                                    hintText: value
                                                        .sleepingHours
                                                        .toString(),
                                                    isDense: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: .3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: .3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              if (sleepController
                                                      .text.isNotEmpty &&
                                                  sleepController.text.trim() !=
                                                      '0') {
                                                value.updateSleepingHours(
                                                    int.parse(
                                                        sleepController.text));
                                                updateSleepGoal(int.parse(
                                                    sleepController.text));
                                                Navigator.pop(context);
                                              } else {
                                                showToast(
                                                    context: context,
                                                    text:
                                                        'Enter positive Value');
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          listTileComponent(
                              context: context,
                              title: 'Medical Condition',
                              subtitle: value.medicalCondition
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '') ??
                                  "-",
                              image: 'assets/svg_icons/medical_svg.svg',
                              oNTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height: 500,
                                            width: 400,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: medical.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (!medicalCondition
                                                              .contains(medical[
                                                                  index])) {
                                                            medicalCondition
                                                                .add(medical[
                                                                    index]);
                                                          } else {
                                                            medicalCondition
                                                                .remove(medical[
                                                                    index]);
                                                          }
                                                        });
                                                      },
                                                      child: ListTile(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: medicalCondition
                                                                      .contains(
                                                                          medical[
                                                                              index])
                                                                  ? const Color(
                                                                      0xff4885ED)
                                                                  : const Color(
                                                                      0xffdfdfdf),
                                                              width: medicalCondition
                                                                      .contains(
                                                                          medical[
                                                                              index])
                                                                  ? 2
                                                                  : 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        minLeadingWidth: 0,
                                                        // leading: Transform.translate(
                                                        //   offset: const Offset(0, 3),
                                                        //   child: Image.network(data[index],
                                                        //       width: 15, height: 15),
                                                        // ),
                                                        title: Text(
                                                          medical[index],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff23233c),
                                                            letterSpacing:
                                                                -0.44999999999999996,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          softWrap: false,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                if (medicalCondition
                                                    .isNotEmpty) {
                                                  value.updateMedicalCondition(
                                                      medicalCondition);
                                                  updateMedical(medicalCondition
                                                      .toString());
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    });
                              }),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text('unable to load data'),
                  );
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
        updateDob(DateFormat('yyyy-MM-dd').format(selectedDate));
      });
    }
  }
}
