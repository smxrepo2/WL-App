import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/screentext/screens/screenText.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class EatSnacksQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;

  EatSnacksQuestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<EatSnacksQuestion> createState() => _EatSnacksQuestionState();
}

class _EatSnacksQuestionState extends State<EatSnacksQuestion> {
  int selectedOption = -1;
  List<String> data = [];
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;

  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[22];
    data = _questoins.options
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("\"", "")
        .split(",");
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
                  color: backgroundColors[3],
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
                  "Let us understand your profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.5, horizontal: 30),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                          //Direct Move

                          if (selectedOption == -1) {
                            // showToast(
                            //     text: 'Choose any option', context: context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content:
                                        const Text('Please choose any option'),
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
                            widget.signupBody.mindQuestions.watchingEating =
                                data[selectedOption];
                            widget.signupBody.mindQuestions.freeTimeEating =
                                data[selectedOption];
                            widget.signupBody.mindQuestions.largeEating =
                                data[selectedOption];

                            var user = Provider.of<UserDataProvider>(context,
                                listen: false);
                            String eatQuicker = data[selectedOption];
                            int userId = user.userData.user.id;

                            AddEatSnacksQuestionRequestModel requestModel =
                                AddEatSnacksQuestionRequestModel(
                                    UserId: userId,
                                    LateNightHabit: eatQuicker,
                                    QuestionOrder: 23);
                            addEatSnacks(requestModel).then((value) {
                              if (value != null) {
                                if (value.response ==
                                    "Data updated successfully") {
                                  widget.signupBody.mindQuestions.category = '';
                                  // get();
                                  AddMindCategoryRequestModel requestModel2 =
                                      AddMindCategoryRequestModel(
                                    UserId: userId,
                                    Category: widget
                                        .signupBody.mindQuestions.category,
                                  );
                                  addMindCategory(requestModel2).then((value) {
                                    if (value != null) {
                                      if (value.response ==
                                          "Data updated successfully") {
                                        AuthService.setQuestionOrder(23);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenTextWidget(
                                                    signUpBody:
                                                        widget.signupBody,
                                                  )),
                                        );
                                      }
                                    }
                                  });
                                }
                              }
                            });
                          }
                        });
                      },
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: selectedOption == index
                                  ? const Color(0xff4885ED)
                                  : const Color(0xffdfdfdf),
                              width: selectedOption == index ? 2 : 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minLeadingWidth: 0,
                        // leading: Transform.translate(
                        //   offset: const Offset(0, 3),
                        //   child: Image.network(data[index],
                        //       width: 15, height: 15),
                        // ),
                        title: Text(
                          data[index],
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 15,
                            color: Color(0xff23233c),
                            letterSpacing: -0.44999999999999996,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              if (selectedOption == -1) {
                // showToast(text: 'Choose any option', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('Please choose any option'),
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
                widget.signupBody.mindQuestions.watchingEating =
                    data[selectedOption];
                widget.signupBody.mindQuestions.freeTimeEating =
                    data[selectedOption];
                widget.signupBody.mindQuestions.largeEating =
                    data[selectedOption];

                var user =
                    Provider.of<UserDataProvider>(context, listen: false);
                String eatQuicker = data[selectedOption];
                int userId = user.userData.user.id;

                AddEatSnacksQuestionRequestModel requestModel =
                    AddEatSnacksQuestionRequestModel(
                        UserId: userId,
                        LateNightHabit: eatQuicker,
                        QuestionOrder: 23);
                addEatSnacks(requestModel).then((value) {
                  if (value != null) {
                    if (value.response == "Data updated successfully") {
                      widget.signupBody.mindQuestions.category = '';
                      // get();
                      AddMindCategoryRequestModel requestModel2 =
                          AddMindCategoryRequestModel(
                        UserId: userId,
                        Category: widget.signupBody.mindQuestions.category,
                      );
                      addMindCategory(requestModel2).then((value) {
                        if (value != null) {
                          if (value.response == "Data updated successfully") {
                            AuthService.setQuestionOrder(23);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenTextWidget(
                                  signUpBody: widget.signupBody,
                                ),
                              ),
                            );
                          }
                        }
                      });
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
          //     number: 23, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddEatSnacksQuestionResponseModel> addEatSnacks(
      AddEatSnacksQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddEatSnacksQuestionResponseModel response =
          await _questionRepository.addEatSnacks(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }

  Future<AddMindCategoryResponseModel> addMindCategory(
      AddMindCategoryRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddMindCategoryResponseModel response =
          await _questionRepository.addMindCategory(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }

  void get() {
    var addictiveCount = 0;
    var defensiveCount = 0;
    var poorCount = 0;

    List poorSelf = [
      widget.signupBody.mindQuestions.control,
      widget.signupBody.mindQuestions.preoccupied,
    ];
    if (poorSelf[0] == "I do not know") {
      poorCount += 1;
    } else if (!poorSelf[0].contains("not")) {
      poorCount += 0;
    } else {
      poorCount += 2;
    }

    if (poorSelf[1] == "I do not know") {
      poorCount += 1;
    } else if (!poorSelf[1].contains("not")) {
      poorCount += 2;
    } else {
      poorCount += 0;
    }

    print("Poor self $poorCount");

    List addictive = [widget.signupBody.mindQuestions.craveFoods];
    if (addictive[0] == "I do not know") {
      addictiveCount += 1;
    } else if (!addictive[0].contains("not")) {
      addictiveCount += 2;
    } else {
      addictiveCount += 0;
    }
    print("addictive $addictiveCount");

    List defensive = [
      widget.signupBody.mindQuestions.stressedEating,
      widget.signupBody.mindQuestions.boredEating
    ];
    if (defensive[0] == "I do not know") {
      defensiveCount += 1;
    } else if (!defensive[0].contains("not")) {
      defensiveCount += 0;
    } else {
      defensiveCount += 2;
    }

    if (defensive[1] == "I do not know") {
      defensiveCount += 1;
    } else if (!defensive[1].contains("not")) {
      defensiveCount += 2;
    } else {
      defensiveCount += 0;
    }

    print("addictive $defensiveCount");

    var C = [addictiveCount, defensiveCount, poorCount].reduce(max);
    print(C);
    if (C == addictiveCount) {
      print("addictiveFull ness");
      widget.signupBody.mindQuestions.category =
          "Addictive or obsessive personality type";
    } else if (C == defensiveCount) {
      widget.signupBody.mindQuestions.category = "Defensive eater type";
      print("Defensive eater type");
    } else if (C == poorCount) {
      widget.signupBody.mindQuestions.category = "Poor self control type";
      print("Poor self control type");
    }
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = MaterialButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScreenTextWidget(
                      signUpBody: widget.signupBody,
                    )));
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Question Complete"),
      content: const Text("Please Continue"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
