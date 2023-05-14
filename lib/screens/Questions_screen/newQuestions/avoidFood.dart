import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/water.dart';

import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';

class AvoidFoodQuestionQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  AvoidFoodQuestionQuestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<AvoidFoodQuestionQuestion> createState() =>
      _AvoidFoodQuestionQuestionState();
}

class _AvoidFoodQuestionQuestionState extends State<AvoidFoodQuestionQuestion> {
  List<String> data = [];
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[10];
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

  List<String> selectedAvoidFood = [];
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
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 10),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedAvoidFood.contains(data[index])) {
                          selectedAvoidFood.remove(data[index]);
                        } else {
                          selectedAvoidFood.add(data[index]);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                            width: 1.5,
                            color: selectedAvoidFood.contains(data[index])
                                ? const Color(0xff4885ED)
                                : const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: selectedAvoidFood.contains(data[index])
                                ? const Color(0x29000000)
                                : Colors.transparent,
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 7.5),
                          Image.network(
                            '$imageBaseUrl${images[index]}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data[index],
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 15,
                              color: Color(0xff000000),
                              letterSpacing: -0.44999999999999996,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedAvoidFood.isEmpty) {
                // showToast(text: 'Select Foods', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Please select atleast one food to continue'),
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
                widget.signupBody.dietQuestions.restrictedFood =
                    selectedAvoidFood.toString();
                widget.signupBody.dietQuestions.allergies =
                    selectedAvoidFood.toString();
                widget.signupBody.dietQuestions.noCuisine = "";

                var user =
                    Provider.of<UserDataProvider>(context, listen: false);
                String restrictedFood = selectedAvoidFood.toString();
                int userId = user.userData.user.id;

                AddRestrictedFoodQuestionRequestModel requestModel =
                    AddRestrictedFoodQuestionRequestModel(
                        UserId: userId,
                        RestrictedFood: restrictedFood,
                        QuestionOrder: 11);
                addRestrictedFood(requestModel).then((value) {
                  if (value != null) {
                    if (value.response == "Data updated successfully") {
                      AuthService.setQuestionOrder(11);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaterQuestion(
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
          //     number: 11, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddRestrictedFoodQuestionResponseModel> addRestrictedFood(
      AddRestrictedFoodQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddRestrictedFoodQuestionResponseModel response =
          await _questionRepository.addRestrictedFood(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
