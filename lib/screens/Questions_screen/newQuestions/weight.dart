import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/goalWeight.dart';

import '../../../Model/SignupBody.dart';
import '../../../Model/UserDataModel.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class WeightQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  UserDataModel userDataModel;
  WeightQuestion({
    Key key,
    @required this.signupBody,
    @required this.questionsModel,
    @required this.userDataModel,
  }) : super(key: key);

  @override
  State<WeightQuestion> createState() => _WeightQuestionState();
}

class _WeightQuestionState extends State<WeightQuestion> {
  int measureUnit = 1;
  double kg = 120 / 2.205;
  double lbs = 120;
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  double sliderValue = 120;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "120";
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[2];
    //print(_questoins.options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                        measureUnit = 1;
                        _controller.text = lbs.toStringAsFixed(0);
                        sliderValue = lbs;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: measureUnit == 1
                            ? const Color(0xff4885ED)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        ),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff4885ed)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 74.5,
                        height: 31,
                        child: Text(
                          'Lbs',
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        measureUnit = 0;
                        _controller.text = kg.toStringAsFixed(0);
                        sliderValue = kg;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: measureUnit == 0
                            ? const Color(0xff4885ED)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff4885ed)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 74.5,
                        height: 31,
                        child: Text(
                          'Kg',
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
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                alignment: Alignment.center,
                // padding:
                // const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border:
                      Border.all(width: 0.5, color: const Color(0xff707070)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 30,
                          color: Color(0xff23233c),
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            color: Color(0xff23233c),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (measureUnit == 0) {
                              if (double.parse(value) > 120) {
                                kg = double.parse(value);
                                lbs = kg * 2.205;
                              }
                            } else {
                              if (double.parse(value) > 120 / 2.205) {
                                lbs = double.parse(value);
                                kg = lbs / 2.205;
                              }
                            }
                            sliderValue = measureUnit == 0 ? kg : lbs;
                          });
                        },
                      ),
                    ),
                    Text(
                      measureUnit == 0 ? ' Kg' : ' Lbs',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: Color(0xff23233c),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Slider(
                    value: sliderValue,
                    min: measureUnit == 1 ? 120 : 120 / 2.205,
                    max: measureUnit == 1 ? 550 : 550 / 2.205,
                    activeColor: const Color(0xff4885ED),
                    inactiveColor: const Color(0xffEBEBEB),
                    thumbColor: primaryColor,
                    onChanged: (onChanged) {
                      setState(() {
                        sliderValue = onChanged;
                        if (measureUnit == 0) {
                          kg = onChanged;
                          lbs = kg * 2.20462;
                        } else {
                          lbs = onChanged;
                          kg = lbs / 2.20462;
                        }
                        _controller.text = onChanged.toStringAsFixed(0);
                      });
                    }),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  String weightUnit = "";
                  int currentWeight = 0;
                  if (measureUnit == 0) {
                    if (kg > 0) {
                      currentWeight = kg.toInt();
                      widget.signupBody.dietQuestions.currentWeight =
                          kg.toInt();
                      widget.signupBody.dietQuestions.weightUnit = 'kg';
                      weightUnit = "kg";
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                  'Please enter your current weight'),
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
                    }
                  } else {
                    if (lbs > 0) {
                      currentWeight = lbs.toInt();
                      widget.signupBody.dietQuestions.currentWeight =
                          lbs.toInt();
                      widget.signupBody.dietQuestions.weightUnit = 'lbs';
                      weightUnit = "lbs";
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                  'Please enter your current weight'),
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
                    }
                  }

                  var user =
                      Provider.of<UserDataProvider>(context, listen: false);
                  int userId = user.userData.user.id;

                  AddWeightQuestionRequestModel requestModel =
                      AddWeightQuestionRequestModel(
                          UserId: userId,
                          Currentweight: currentWeight,
                          WeightUnit: weightUnit,
                          QuestionOrder: 3);
                  addWeightQuestion(requestModel).then((value) {
                    if (value != null) {
                      if (value.response == "Data updated successfully" ||
                          value.response == "Data saved successfully") {
                        ///For testing purpose
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalWeightQuestion(
                                questionsModel: widget.questionsModel,
                                signupBody: widget.signupBody,
                                measureUnit: measureUnit),
                          ),
                        );
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
              //     number: 3, totalQuestion: _questionsModel.questoins.length),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<AddWeightQuestionResponseModel> addWeightQuestion(
      AddWeightQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddWeightQuestionResponseModel response =
          await _questionRepository.addWeightQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
