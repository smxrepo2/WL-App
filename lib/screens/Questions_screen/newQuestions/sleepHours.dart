import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatType.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class SleepHours extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  SleepHours(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<SleepHours> createState() => _SleepHoursState();
}

class _SleepHoursState extends State<SleepHours> {
  Color currentColor = backgroundColors[3];
  int sleepHours = 8;
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  @override
  void initState() {
    super.initState();

    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[5];
    //print(_questoins.options);
  }

  List<Color> colors = [
    const Color(0x4d4885ed),
    const Color(0x4dff3f3f),
    const Color(0xffA947E7).withOpacity(0.33),
    const Color(0xffDF4300).withOpacity(0.33),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              QuestionBackground(
                  // questionIndex: currentPage,
                  color: backgroundColors[1],
                  question: _questoins.question),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.02,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.125,
                left: MediaQuery.of(context).size.width / 2 - 125,
                child: const Text(
                  "Let us understand your routine",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.125),
          SleekCircularSlider(
              min: 0,
              max: 24,
              initialValue: 8,
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  progressBarWidth: 15,
                  trackWidth: 15,
                ),
                customColors: CustomSliderColors(
                  progressBarColor: currentColor,
                  trackColor: currentColor.withOpacity(0.05),
                  dotColor: Colors.white,
                  hideShadow: true,
                ),
              ),
              innerWidget: (double value) {
                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${value.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            color: Color(0xff23233c),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: ' hours',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: Color(0xff23233c),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              onChange: (double value) {
                setState(() {
                  sleepHours = value.toInt();
                  if (sleepHours < 6) {
                    currentColor = colors[1];
                  }
                  if (sleepHours >= 6 && sleepHours <= 8) {
                    currentColor = colors[3];
                  }
                  if (sleepHours > 8) {
                    currentColor = colors[0];
                  }
                });
              }),
          // Container(
          //   width: 127,
          //   height: 127,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     color: const Color(0xffffffff),
          //     borderRadius:
          //         const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          //     border: Border.all(width: 0.5, color: const Color(0xff707070)),
          //     boxShadow: const [
          //       BoxShadow(
          //         color: Color(0x29000000),
          //         offset: Offset(0, 3),
          //         blurRadius: 6,
          //       ),
          //     ],
          //   ),
          //   child: RichText(
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //           text: '$sleepHours',
          //           style: const TextStyle(
          //             fontFamily: 'Montserrat',
          //             fontSize: 30,
          //             color: Color(0xff23233c),
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         const TextSpan(
          //           text: ' hours',
          //           style: TextStyle(
          //             fontFamily: 'Montserrat',
          //             fontSize: 20,
          //             color: Color(0xff23233c),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () async {
          //     showTimeRangePicker12Hour(context).then((value) {
          //       setState(() {});
          //     });
          //   },
          //   child: Transform.translate(
          //     offset: const Offset(25, 0),
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 50),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 height: 50,
          //                 width: 50,
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       '${start.hourOfPeriod}',
          //                       style: const TextStyle(
          //                         fontFamily: 'Montserrat',
          //                         fontSize: 25,
          //                         color: Color(0xff23233c),
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                       softWrap: false,
          //                     ),
          //                     const Divider(thickness: 1)
          //                   ],
          //                 ),
          //               ),
          //               const Text(
          //                 ':',
          //                 style: TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   fontSize: 25,
          //                   color: Color(0xff23233c),
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 softWrap: false,
          //               ),
          //               SizedBox(
          //                 height: 50,
          //                 width: 50,
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       '${start.minute}',
          //                       style: const TextStyle(
          //                         fontFamily: 'Montserrat',
          //                         fontSize: 25,
          //                         color: Color(0xff23233c),
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                       softWrap: false,
          //                     ),
          //                     const Divider(thickness: 1)
          //                   ],
          //                 ),
          //               ),
          //               Text(
          //                 start.periodOffset == 0 ? 'AM' : 'PM',
          //                 style: const TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   fontSize: 15,
          //                   color: Color(0xff6C9DF0),
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 textAlign: TextAlign.center,
          //                 softWrap: false,
          //               )
          //             ],
          //           ),
          //         ),
          //         Transform.translate(
          //           offset: const Offset(-22.5, 0),
          //           child: const Text(
          //             'TO',
          //             style: TextStyle(
          //               fontFamily: 'Montserrat',
          //               fontSize: 15,
          //               color: Color(0xff6C9DF0),
          //               fontWeight: FontWeight.w500,
          //             ),
          //             textAlign: TextAlign.center,
          //             softWrap: false,
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 50),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 height: 50,
          //                 width: 40,
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       '${end.hourOfPeriod}',
          //                       style: const TextStyle(
          //                         fontFamily: 'Montserrat',
          //                         fontSize: 25,
          //                         color: Color(0xff23233c),
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                       softWrap: false,
          //                     ),
          //                     const Divider(thickness: 1)
          //                   ],
          //                 ),
          //               ),
          //               const Text(
          //                 ':',
          //                 style: TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   fontSize: 25,
          //                   color: Color(0xff23233c),
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 softWrap: false,
          //               ),
          //               SizedBox(
          //                 height: 50,
          //                 width: 50,
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       '${end.minute}',
          //                       style: const TextStyle(
          //                         fontFamily: 'Montserrat',
          //                         fontSize: 25,
          //                         color: Color(0xff23233c),
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                       softWrap: false,
          //                     ),
          //                     const Divider(thickness: 1)
          //                   ],
          //                 ),
          //               ),
          //               Text(
          //                 end.periodOffset == 0 ? 'AM' : 'PM',
          //                 style: const TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   fontSize: 15,
          //                   color: Color(0xff6C9DF0),
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 textAlign: TextAlign.center,
          //                 softWrap: false,
          //               )
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              if (sleepHours < 2) {
                // showToast(text: 'Enter Correct Hours', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Sleeping hours should be greater than 2 hours'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'))
                        ],
                      );
                    });
                return;
              } else {
                widget.signupBody.dietQuestions.sleepTime = sleepHours;
              }

              var user = Provider.of<UserDataProvider>(context, listen: false);
              int userId = user.userData.user.id;

              AddSleepHourQuestionRequestModel requestModel =
                  AddSleepHourQuestionRequestModel(
                      UserId: userId, SleepTime: sleepHours, QuestionOrder: 6);
              addSleepHourQuestion(requestModel).then((value) {
                if (value != null) {
                  if (value.response == "Data updated successfully") {
                    AuthService.setQuestionOrder(6);

                    ///For testing purpose
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EatTypeQuestion(
                                  questionsModel: widget.questionsModel,
                                  signupBody: widget.signupBody,
                                )));
                  }
                }
              });
            },
            child: Container(
                width: 100,
                height: 35,
                // padding:
                // const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(width: 2.0, color: const Color(0xffc7dafa)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'Book Antiqua',
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: -0.6,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
          // const SizedBox(height: 5),
          // countingText(
          //     number: 6, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Future<void> showTimeRangePicker12Hour(BuildContext context) async {
  //   showTimeRangePicker(
  //     context: context,
  //     use24HourFormat: false,
  //     start: start,
  //     end: end,
  //     ticks: 24,
  //     snap: true,
  //     labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
  //         .asMap()
  //         .entries
  //         .map((e) {
  //       return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
  //     }).toList(),
  //     onStartChange: (start) {
  //       setState(() {
  //         this.start = start;
  //         int temp = end.hour - start.hour;
  //         if (temp < 0) {
  //           sleepHours = 24 + temp;
  //         } else {
  //           sleepHours = temp;
  //         }
  //       });
  //     },
  //     onEndChange: (end) {
  //       setState(() {
  //         this.end = end;
  //         int temp = end.hour - start.hour;
  //         if (temp < 0) {
  //           sleepHours = 24 + temp;
  //         } else {
  //           sleepHours = temp;
  //         }
  //       });
  //     },
  //   );
  //   // return showDialog(
  //   //     context: context,
  //   //     builder: (BuildContext context) {
  //   //       return AlertDialog(
  //   //         title: const Text("Choose sleep time"),
  //   //         content: t.TimeRangePicker(
  //   //           initialFromHour: start.hour,
  //   //           initialFromMinutes: start.minute,
  //   //           initialToHour: end.hour,
  //   //           initialToMinutes: end.minute,
  //   //           backText: "Back",
  //   //           nextText: "Next",
  //   //           cancelText: "Cancel",
  //   //           selectText: "Select",
  //   //           editable: false,
  //   //           is24Format: false,
  //   //           disableTabInteraction: true,
  //   //           iconCancel: const Icon(Icons.cancel_presentation, size: 12),
  //   //           iconNext: const Icon(Icons.arrow_forward, size: 12),
  //   //           iconBack: const Icon(Icons.arrow_back, size: 12),
  //   //           iconSelect: const Icon(Icons.check, size: 12),
  //   //           inactiveBgColor: Colors.grey.shade800,
  //   //           timeContainerStyle: BoxDecoration(
  //   //               color: Colors.white, borderRadius: BorderRadius.circular(7)),
  //   //           separatorStyle: TextStyle(color: Colors.grey[900], fontSize: 30),
  //   //           onSelect: (from, to) {
  //   //             start = from;
  //   //             end = to;
  //   //
  //   //             int temp = end.hour - start.hour;
  //   //             if (temp < 0) {
  //   //               sleepHours = 24 + temp;
  //   //             } else {
  //   //               sleepHours = temp;
  //   //             }
  //   //             Navigator.pop(context);
  //   //           },
  //   //           onCancel: () => Navigator.pop(context),
  //   //         ),
  //   //       );
  //   //     });
  // }

  Future<AddSleepHourQuestionResponseModel> addSleepHourQuestion(
      AddSleepHourQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddSleepHourQuestionResponseModel response =
          await _questionRepository.addSleepHourQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
