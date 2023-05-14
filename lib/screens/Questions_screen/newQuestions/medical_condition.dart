import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/avoidFood.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../utils/AppConfig.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class MedicalCondition extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  MedicalCondition(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  _MedicalConditionState createState() => _MedicalConditionState();
}

class _MedicalConditionState extends State<MedicalCondition> {
  List<String> data = [];
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[9];
    data = _questoins.options
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("\"", "")
        .split(",");
    images = _questoins.fileName
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("\"", "")
        .split(",");
    //print(_questoins.options);
  }

  List<String> selectedCondition = [];
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 15, top: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (data[index] == "Normal") {
                          selectedCondition.clear();
                          selectedCondition.add(data[index]);
                        } else {
                          selectedCondition
                              .removeWhere((element) => element == "Normal");

                          if (selectedCondition.contains(data[index])) {
                            selectedCondition.remove(data[index]);
                          } else {
                            selectedCondition.add(data[index]);
                          }
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                              width: 1.5,
                              color: selectedCondition.contains(data[index])
                                  ? const Color(0xff4885ED)
                                  : const Color(0xffdfdfdf)),
                          boxShadow: [
                            BoxShadow(
                              color: selectedCondition.contains(data[index])
                                  ? const Color(0x29000000)
                                  : Colors.transparent,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.network(
                                '$imageBaseUrl${images[index]}',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                data[index],
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: Color(0xff23233c),
                                  letterSpacing: -0.44999999999999996,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedCondition.length == 0) {
                // showToast(
                //     text:
                //         'Choose Normal if you dont have any medical condition',
                //     context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Choose Normal if you dont have any medical condition'),
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
                widget.signupBody.dietQuestions.medicalCondition =
                    selectedCondition.toString();
                print(selectedCondition.toString());

                var user =
                    Provider.of<UserDataProvider>(context, listen: false);
                String medicalCondition = selectedCondition.toString();
                int userId = user.userData.user.id;

                AddMedicalConditionQuestionRequestModel requestModel =
                    AddMedicalConditionQuestionRequestModel(
                        UserId: userId,
                        MedicalCondition: medicalCondition,
                        QuestionOrder: 10);
                addMedicalCondition(requestModel).then((value) {
                  if (value != null) {
                    if (value.response == "Data updated successfully") {
                      AuthService.setQuestionOrder(10);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvoidFoodQuestionQuestion(
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
          //     number: 10, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddMedicalConditionQuestionResponseModel> addMedicalCondition(
      AddMedicalConditionQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddMedicalConditionQuestionResponseModel response =
          await _questionRepository.addMedicalCondition(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
