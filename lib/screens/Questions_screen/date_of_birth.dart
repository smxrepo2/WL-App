import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/sleep_time.dart';
import 'package:weight_loser/screens/SettingScreen/components.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';
// import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'used-Questions/diet _exercise_mind.dart';
import 'used-Questions/food_favorite_choice.dart';
import 'food_like_dislike.dart';
import 'used-Questions/not_support_pregnant.dart';

class DateOfBirth extends StatefulWidget {
  SignUpBody signUpBody;

  DateOfBirth({Key key, this.signUpBody}) : super(key: key);

  @override
  _DateOfBirthState createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  String month, day, year;
  List<String> daysList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  List<String> monthsList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> yearsList = [];
  TextEditingController _ageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setYearsList();
    super.initState();
  }

  void setYearsList() {
    DateTime date = DateTime.now();

    for (int i = date.year; i >= 1900; i--) {
      yearsList.add(i.toString());
    }

    year = yearsList[0];
    month = date.month.toString();
    day = date.day.toString();
  }

  DateTime _selectedDate = DateTime.now();
  TextEditingController date = TextEditingController();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        print(_selectedDate);
        date.text = DateFormat('MM-dd-yyyy').format(_selectedDate).toString();
        // updateDob( DateFormat('yyyy-MM-dd').format(_selectedDate));
      });
  }

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
                  questionHeader(queNo: 5, percent: .05),
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
                  //           '8/$totalQuestion',
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
                  //     percent: .18,
                  //
                  //     padding: EdgeInsets.all(0),
                  //     backgroundColor: Colors.grey[300],
                  //     progressColor: primaryColor,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'What is your date of birth?',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 15, bottom: 15),
                    child: TextFormField(
                      controller: date,
                      decoration: InputDecoration(
                          hintText: "select your Birth date",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Icon(Icons.calendar_today))),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //   child: DatePickerWidget(looping: false, // default is not looping
                  //     firstDate: DateTime(1990, 01, 01),
                  //     lastDate: DateTime(2030, 1, 1),
                  //     initialDate: DateTime(1991, 10, 12),
                  //     dateFormat: "dd-MMM-yyyy",
                  //     locale: DatePicker.localeFromString('en'),
                  //     onChange: (DateTime newDate, _) => _selectedDate = newDate,
                  //     pickerTheme: DateTimePickerTheme(
                  //       itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  //       dividerColor: Colors.grey,
                  //     ),),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //                 child: Container(
                  //               alignment: Alignment.center,
                  //               padding: EdgeInsets.all(6),
                  //               /*decoration: BoxDecoration(
                  //               color: Colors.black26,
                  //               shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10)
                  //           ),*/
                  //               child: DropdownButton(
                  //                 hint: Text(
                  //                   "month",
                  //                 ),
                  //                 isExpanded: true,
                  //                 value: month,
                  //                 icon: SizedBox(),
                  //                 onChanged: (val) {
                  //                   setState(() {
                  //                     month = val;
                  //                   });
                  //                 },
                  //                 items: monthsList
                  //                     .map((item) => DropdownMenuItem(
                  //                           value: item,
                  //                           child: Container(
                  //                               width: 100,
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   item,
                  //                                 ),
                  //                               )),
                  //                         ))
                  //                     .toList(),
                  //               ),
                  //             )),
                  //             SizedBox(
                  //               width: 15,
                  //             ),
                  //             Expanded(
                  //                 child: Container(
                  //               alignment: Alignment.center,
                  //               padding: EdgeInsets.all(6),
                  //               /*decoration: BoxDecoration(
                  //               color: Colors.black26,
                  //               shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10)
                  //           ),*/
                  //               child: DropdownButton(
                  //                 hint: Center(
                  //                     child: Text(
                  //                   "day",
                  //                 )),
                  //                 isExpanded: true,
                  //                 value: day,
                  //                 icon: SizedBox(),
                  //                 onChanged: (val) {
                  //                   setState(() {
                  //                     day = val;
                  //                   });
                  //                 },
                  //                 items: daysList
                  //                     .map((item) => DropdownMenuItem(
                  //                           value: item,
                  //                           child: Container(
                  //                               width: 80,
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   item,
                  //                                 ),
                  //                               )),
                  //                         ))
                  //                     .toList(),
                  //               ),
                  //             )),
                  //             SizedBox(
                  //               width: 15,
                  //             ),
                  //             Expanded(
                  //                 child: Container(
                  //               alignment: Alignment.center,
                  //               padding: EdgeInsets.all(6),
                  //               /*decoration: BoxDecoration(
                  //               color: Colors.black26                                                                                       ,
                  //               shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10)
                  //           ),*/
                  //               child: DropdownButton(
                  //                 hint: Center(
                  //                     child: Text(
                  //                   "year",
                  //                 )),
                  //                 isExpanded: true,
                  //                 value: year,
                  //                 icon: SizedBox(),
                  //                 onChanged: (val) {
                  //                   setState(() {
                  //                     year = val;
                  //                   });
                  //                 },
                  //                 items: yearsList
                  //                     .map((item) => DropdownMenuItem(
                  //                           value: item,
                  //                           child: Container(
                  //                               width: 70,
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   item,
                  //                                 ),
                  //                               )),
                  //                         ))
                  //                     .toList(),
                  //               ),
                  //             )),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //               child: Container(
                  //             alignment: Alignment.center,
                  //             padding: EdgeInsets.all(6),
                  //             /*decoration: BoxDecoration(
                  //             color: Colors.black26,
                  //             shape: BoxShape.rectangle,
                  //             borderRadius: BorderRadius.circular(10)
                  //         ),*/
                  //             child: Text(
                  //               'MM',
                  //               style: TextStyle(color: Colors.grey),
                  //             ),
                  //           )),
                  //           SizedBox(
                  //             width: 15,
                  //           ),
                  //           Text(
                  //             "\\",
                  //             style: TextStyle(color: Colors.grey),
                  //           ),
                  //           Expanded(
                  //               child: Container(
                  //             alignment: Alignment.center,
                  //             padding: EdgeInsets.all(6),
                  //             child: Text(
                  //               'DD',
                  //               style: TextStyle(color: Colors.grey),
                  //             ),
                  //           )),
                  //           SizedBox(
                  //             width: 15,
                  //           ),
                  //           Text(
                  //             "\\",
                  //             style: TextStyle(color: Colors.grey),
                  //           ),
                  //           Expanded(
                  //               child: Container(
                  //             alignment: Alignment.center,
                  //             padding: EdgeInsets.all(6),
                  //             child: Text(
                  //               'YY',
                  //               style: TextStyle(color: Colors.grey),
                  //             ),
                  //           )),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If you don't want to put your actual DOB due to privacy concerns we understand that. ",
                        textAlign: TextAlign.center,
                        style: questionText30Px.copyWith(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You can give us range of your age",
                        textAlign: TextAlign.center,
                        style: questionText30Px.copyWith(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    child: TextFormField(
                      controller: _ageController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Age',
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // widget.signUpBody.dietQuestions.dOB =
                  //     DateTime.parse('$year-$month-$day');
                  //calculateAge(widget.signUpBody.dietQuestions.dOB);
                  if (_ageController.text == "" && date.text == "") {
                    AltDialog(context, "Please Enter Your Age and BirthDate");
                  } else if (_ageController.text == "" || date.text == "") {
                    if (_ageController.text == "") {
                      AltDialog(context, "Please Enter Your Age");
                    } else {
                      AltDialog(context, "Please Enter Your BirthDate");
                    }
                  } else {
                    var age = int.parse(_ageController.text);
                    widget.signUpBody.age = age;
                    widget.signUpBody.dietQuestions.dOB =
                        DateFormat("yyyy-MM-dd'T'HH:mm:ss'")
                            .format(_selectedDate)
                            .toString();
                    if (widget.signUpBody.age >= 80) {
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NotSupportForPregnantOptionScreen(
                                      signUpBody: widget.signUpBody,
                                      text1: TextConstant.ageText1,
                                      text2: TextConstant.ageText2)))
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
                                            NotSupportForPregnantOptionScreen(
                                                signUpBody: widget.signUpBody,
                                                text1: TextConstant.ageText1,
                                                text2: TextConstant.ageText2)),
                                  )));
                    } else {
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SleepHours(
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
                                        child: SleepHours(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    }
                  }
                },
                child: Padding(
                  padding: mobile
                      ? const EdgeInsets.only(top: 105)
                      : const EdgeInsets.only(
                          top: 100, right: 30, left: 30, bottom: 30),
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

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    print("Age:-$age");
    return age;
  }
}
