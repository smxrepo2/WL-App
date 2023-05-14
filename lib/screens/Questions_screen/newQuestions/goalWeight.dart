import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/goalAnimation.dart';

import '../../../Model/SignupBody.dart';
import '../../../Model/UserDataModel.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class GoalWeightQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  int measureUnit;
  UserDataModel userDataModel;
  GoalWeightQuestion({
    Key key,
    @required this.signupBody,
    @required this.questionsModel,
    @required this.measureUnit,
    @required this.userDataModel,
  }) : super(key: key);

  @override
  State<GoalWeightQuestion> createState() => _GoalWeightQuestionState();
}

class _GoalWeightQuestionState extends State<GoalWeightQuestion> {
  int measureUnit;
  double kg = 90 / 2.20462;
  double lbs = 90;
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  double sliderValue = 90;
  bool inLimit = false;
  var minWeight;
  var maxWeight;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    measureUnit = widget.measureUnit;
    _controller.text =
        measureUnit == 0 ? kg.toStringAsFixed(0) : lbs.toStringAsFixed(0);
    sliderValue = measureUnit == 0 ? kg : lbs;
    recommendedWeightRange();
    print(measureUnit);
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[3];
    //print(_questoins.options);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDataProvider>(context, listen: false);
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
                    top: MediaQuery.of(context).size.height * 0.13,
                    left: MediaQuery.of(context).size.width / 2 - 125,
                    child: Row(
                      children: [
                        const Text(
                          "Let us understand your goal",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'assets/icons/goal.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
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
                      //  setState(() {
                      //  measureUnit = 1;
                      //});
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
                      //setState(() {
                      //measureUnit = 0;
                      //});
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
                  )
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
                    min: measureUnit == 1 ? 90 : 90 / 2.205,
                    max: measureUnit == 1 ? 500 : 500 / 2.205,
                    activeColor: const Color(0xff4885ED),
                    inactiveColor: const Color(0xffEBEBEB),
                    thumbColor: primaryColor,
                    onChanged: (onChanged) {
                      setState(() {
                        sliderValue = onChanged;
                        if (measureUnit == 0) {
                          kg = onChanged;
                          lbs = kg * 2.20462;
                          if (kg >= minWeight && kg <= maxWeight) {
                            inLimit = true;
                          } else {
                            inLimit = false;
                          }
                        } else {
                          lbs = onChanged;
                          kg = lbs / 2.20462;
                          if (lbs >= minWeight && lbs <= maxWeight) {
                            inLimit = true;
                          } else {
                            inLimit = false;
                          }
                        }
                        _controller.text = onChanged.toStringAsFixed(0);
                      });
                    }),
              ),
              const SizedBox(height: 30),
              Text(
                inLimit
                    ? 'Believe in yourself, we\'ll help you achieve.'
                    : 'Recocmmended weight range: ${recommendedWeightRange()}',
              ),
              Expanded(child: SizedBox()),

              GestureDetector(
                onTap: () {
                  int weight = 0;

                  if (measureUnit == 0) {
                    if (kg > 0) {
                      var currentWeight = 0;
                      var heightUnit =
                          widget.signupBody.dietQuestions.heightUnit;
                      var height = widget.signupBody.dietQuestions.height;

                      if (calculateBMI() < 18.5) {
                        var feet = height.toString().split('.')[0];
                        var inches = height.toString().split('.')[1];
                        if (heightUnit == 'feet') {
                          bmiAlertDialog(context, feet, inches, null);
                          return;
                        } else {
                          bmiAlertDialog(
                              context, null, null, height.toStringAsFixed(0));
                          return;
                        }
                      }

                      if (widget.signupBody.dietQuestions != null) {
                        // currentWeight=widget.signupBody.dietQuestions.currentWeight;
                        if (widget.signupBody.dietQuestions.currentWeight !=
                            null) {
                          currentWeight =
                              widget.signupBody.dietQuestions.currentWeight;
                        } else {
                          currentWeight = user.userData.profileVM.currentweight;
                        }
                      } else {
                        currentWeight = user.userData.profileVM.currentweight;
                      }

                      if (kg < currentWeight) {
                        weight = kg.toInt();

                        if (widget.signupBody.dietQuestions != null) {
                          // currentWeight=widget.signupBody.dietQuestions.currentWeight;
                          if (widget.signupBody.dietQuestions.currentWeight !=
                              null) {
                            widget.signupBody.dietQuestions.goalWeight =
                                kg.toInt();
                          } else {}
                        } else {}
                      } else {
                        // showToast(
                        //     text:
                        //         'Goal Weight can not greater than current weight',
                        //     context: context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                    'Goal Weight can not greater than current weight'),
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text('Please enter your goal weight'),
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
                      var currentWeight = 0;
                      var height = widget.signupBody.dietQuestions.height;
                      var heightUnit =
                          widget.signupBody.dietQuestions.heightUnit;
                      if (calculateBMI() < 18.5) {
                        var feet = height.toString().split('.')[0];
                        var inches = height.toString().split('.')[1];
                        if (heightUnit == 'feet') {
                          bmiAlertDialog(context, feet, inches, null);
                          return;
                        } else {
                          bmiAlertDialog(
                              context, null, null, height.toStringAsFixed(0));
                          return;
                        }
                      }
                      if (widget.signupBody.dietQuestions.currentWeight !=
                          null) {
                        currentWeight =
                            widget.signupBody.dietQuestions.currentWeight;
                      } else {
                        currentWeight = user.userData.profileVM.currentweight;
                      }

                      if (lbs < currentWeight) {
                        widget.signupBody.dietQuestions.goalWeight =
                            lbs.toInt();
                        weight = lbs.toInt();
                      } else {
                        // showToast(
                        //     text:
                        //         'Goal Weight can not greater than current weight',
                        //     context: context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(
                                    'Goal Weight can not greater than current weight'),
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text('Please enter your goal weight'),
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

                  if (weight > 0) {
                    int userId = user.userData.user.id;
                    AddGoalWeightQuestionRequestModel requestModel =
                        AddGoalWeightQuestionRequestModel(
                            UserId: userId,
                            WeightUnit: measureUnit == 0 ? ' kg' : ' lbs',
                            GoalWeight: weight,
                            QuestionOrder: 4);
                    addGoalWeightQuestion(requestModel).then((value) {
                      if (value != null) {
                        if (value.response == "Data updated successfully") {
                          AuthService.setQuestionOrder(4);

                          ///For testing purpose
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalAnimation(
                                        questionsModel: widget.questionsModel,
                                        signupBody: widget.signupBody,
                                      )));
                        }
                      }
                    });
                  }
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
              //     number: 4, totalQuestion: _questionsModel.questoins.length),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> bmiAlertDialog(
      BuildContext context, String feet, String inches, String cm) {
    String text = '$feet ft. $inches”';
    if (cm != null) {
      text = '${cm} cm';
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'BMI Alert',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'BMI under 18.5 is considered underweight by CDC. Kindly make changes in your goal.',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<AddGoalWeightQuestionResponseModel> addGoalWeightQuestion(
      AddGoalWeightQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddGoalWeightQuestionResponseModel response =
          await _questionRepository.addGoalWeightQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }

  double calculateBMI() {
    var bmi = 0.0;
    var heightUnit = widget.signupBody.dietQuestions.heightUnit;
    var height = widget.signupBody.dietQuestions.height;
    if (heightUnit == 'feet') {
      var feet = height.toString().split('.')[0];
      var inches = height.toString().split('.')[1];
      height = int.parse(feet) * 12 + int.parse(inches).toDouble();
    }
    if (heightUnit == 'cm') {
      height = height / 2.54;
    }
    double weight = double.parse(_controller.text);
    if (measureUnit == 0) {
      weight = weight * 2.205;
      bmi = 703 * weight / (height * height);
    } else {
      bmi = 703 * weight / (height * height);
    }
    print('BMI: $bmi');
    return bmi;
  }

  String recommendedWeightRange() {
    // find recommended weight range for the bmi 19-25 according to height and weight
    var heightUnit = widget.signupBody.dietQuestions.heightUnit;
    var height = widget.signupBody.dietQuestions.height;
    if (heightUnit == 'feet') {
      var feet = height.toString().split('.')[0];
      var inches = height.toString().split('.')[1];
      height = int.parse(feet) * 12 + int.parse(inches).toDouble();
    }
    if (heightUnit == 'cm') {
      height = height / 2.54;
    }
    double weight = double.parse(_controller.text);
    if (measureUnit == 0) {
      weight = weight * 2.205;
    }
    setState(() {
      minWeight = 19 * (height * height) / 703;
      maxWeight = 25 * (height * height) / 703;
      if (measureUnit == 0) {
        minWeight = minWeight / 2.205;
        maxWeight = maxWeight / 2.205;
      }
    });

    if (measureUnit == 0) {
      return '${minWeight.toStringAsFixed(0)} kg  - ${maxWeight.toStringAsFixed(0)} kg';
    }
    return '${minWeight.toStringAsFixed(0)} lb - ${maxWeight.toStringAsFixed(0)} lb';
  }
}
