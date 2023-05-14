import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/weight.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';
import 'constant.dart';

class HeightQuestion extends StatefulWidget {
  SignUpBody signUpBody;
  GetAllQuestionsModel questionsModel;
  HeightQuestion(
      {Key key, @required this.signUpBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<HeightQuestion> createState() => _HeightQuestionState();
}

class _HeightQuestionState extends State<HeightQuestion> {
  // ft = 0, cm = 1
  int measureUnit = 0;
  double _currentValue = 55;

  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  double cm = 139;

  TextEditingController _feetController = TextEditingController();
  TextEditingController _inchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[1];
    _feetController.text = '4';
    _inchController.text = '7';
    //print(_questoins.options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              QuestionBackground(
                  // questionIndex: currentPage,
                  color: backgroundColors[0],
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
                left: MediaQuery.of(context).size.width / 2 - 145,
                child: const Text(
                  "Let us understand your biological makeup",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    measureUnit = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: measureUnit == 0
                        ? const Color(0xff4885ED)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                    ),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff4885ed)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 74.5,
                    height: 31,
                    child: Text(
                      'Ft',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: measureUnit == 0
                            ? Colors.white
                            : const Color(0xff2b2b2b),
                        letterSpacing: -0.44999999999999996,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    measureUnit = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: measureUnit == 1
                        ? const Color(0xff4885ED)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff4885ed)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 74.5,
                    height: 31,
                    child: Text(
                      'Cm',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: measureUnit == 1
                            ? Colors.white
                            : const Color(0xff2b2b2b),
                        letterSpacing: -0.44999999999999996,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          measureUnit == 1
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 140,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x20000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$cm'.split('.')[0],
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            color: Color(0xc423233c),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: ' cm',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xc4797a7a),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x20000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _feetController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 30,
                                      color: Color(0xc423233c),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 30,
                                    color: Color(0xc423233c),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onChanged: (value) {
                                    if (int.parse(value) <= 7 &&
                                        int.parse(value) >= 4) {
                                      if (int.parse(_inchController.text) < 7 &&
                                          int.parse(value) == 4) return;
                                      if (int.parse(_inchController.text) >
                                              11 &&
                                          int.parse(value) == 7) return;
                                      setState(() {
                                        _currentValue =
                                            double.parse(value) * 12;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const Text(
                                'ft',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Color(0xc4797a7a),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 0.75,
                            color: Color(0xff707070),
                          ),
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _inchController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 30,
                                      color: Color(0xc423233c),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 30,
                                    color: Color(0xc423233c),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onChanged: (value) {
                                    if (int.parse(value) >= 0 &&
                                        int.parse(value) < 12) {
                                      if (_feetController.text == '4' &&
                                          int.parse(value) < 7) return;
                                      if (_feetController.text == '7' &&
                                          int.parse(value) > 3) return;
                                      setState(() {
                                        _currentValue =
                                            _currentValue + double.parse(value);
                                      });
                                    }
                                  },
                                ),
                              ),
                              const Text(
                                'in',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Color(0xc4797a7a),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Slider(
              value: _currentValue,
              min: 55,
              max: 88,
              divisions: 34,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey,
              onChanged: (double value) {
                setState(() {
                  _currentValue = value;
                  cm = _currentValue * 2.54;
                  _feetController.text =
                      (_currentValue / 12).floor().toString();
                  _inchController.text =
                      (_currentValue % 12).floor().toString();
                });
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          GestureDetector(
            onTap: () {
              double height = 0.0;
              String heightUnit = "";
              if (measureUnit == 0) {
                if (int.parse(_feetController.text) < 3) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                              'Enter Correct Height (Minimum 3 feet)'),
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
                  heightUnit = "feet";
                  height = double.parse(
                      '${int.parse(_feetController.text)}.${int.parse(_inchController.text)}');
                  widget.signUpBody.dietQuestions.height = double.parse(
                      '${int.parse(_feetController.text)}.${int.parse(_inchController.text)}');
                  widget.signUpBody.dietQuestions.heightUnit = 'feet';

/*
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeightQuestion(
                                signupBody: widget.signUpBody,
                                questionsModel: widget.questionsModel,
                              )));*/
                }
              } else {
                if (cm < 30.0) {
                  // showToast(text: 'Enter Correct Height', context: context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                            'Enter Correct Height (Minimum 30 cm)',
                          ),
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
                  heightUnit = "cm";
                  height = double.parse('$cm');
                  widget.signUpBody.dietQuestions.height = double.parse('$cm');
                  widget.signUpBody.dietQuestions.heightUnit = 'cm';
                  /*
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeightQuestion(
                                signupBody: widget.signUpBody,
                                questionsModel: widget.questionsModel,
                              )));*/
                }
              }

              var user = Provider.of<UserDataProvider>(context, listen: false);
              int userId = user.userData.user.id;

              AddHeightQuestionRequestModel requestModel =
                  AddHeightQuestionRequestModel(
                      UserId: userId,
                      Height: height,
                      HeightUnit: heightUnit,
                      QuestionOrder: 2);
              addHeightQuestion(requestModel).then((value) {
                if (value != null) {
                  if (value.response == "Data updated successfully") {
                    ///Just for testing purpose
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeightQuestion(
                                  signupBody: widget.signUpBody,
                                  questionsModel: widget.questionsModel,
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
          //     number: 2, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddHeightQuestionResponseModel> addHeightQuestion(
      AddHeightQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddHeightQuestionResponseModel response =
          await _questionRepository.addHeightQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
