import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/endurance.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class SleepQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  SleepQuestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<SleepQuestion> createState() => _SleepQuestionState();
}

class _SleepQuestionState extends State<SleepQuestion> {
  int selectedOption = -1;
  List<String> data = [];
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[12];
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
                  color: backgroundColors[2],
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
                                        const Text('Please select any option'),
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
                            widget.signupBody.mindQuestions.sevenSleeping =
                                data[selectedOption];

                            var user = Provider.of<UserDataProvider>(context,
                                listen: false);
                            String lessSleep = data[selectedOption];
                            int userId = user.userData.user.id;

                            AddLessSleepQuestionRequestModel requestModel =
                                AddLessSleepQuestionRequestModel(
                                    UserId: userId,
                                    SevenSleeping: lessSleep,
                                    QuestionOrder: 13);
                            addLessSleep(requestModel).then((value) {
                              if (value != null) {
                                if (value.response ==
                                    "Data updated successfully") {
                                  AuthService.setQuestionOrder(13);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EnduranceQuestion(
                                                questionsModel:
                                                    widget.questionsModel,
                                                signupBody: widget.signupBody,
                                              )));
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
                          softWrap: false,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              //Direct Move
              if (selectedOption == -1) {
                // showToast(text: 'Choose any option', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content:
                            const Text('Please select any option to continue'),
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
                widget.signupBody.mindQuestions.sevenSleeping =
                    data[selectedOption];

                var user =
                    Provider.of<UserDataProvider>(context, listen: false);
                String lessSleep = data[selectedOption];
                int userId = user.userData.user.id;

                AddLessSleepQuestionRequestModel requestModel =
                    AddLessSleepQuestionRequestModel(
                        UserId: userId,
                        SevenSleeping: lessSleep,
                        QuestionOrder: 13);
                addLessSleep(requestModel).then((value) {
                  if (value != null) {
                    if (value.response == "Data updated successfully") {
                      AuthService.setQuestionOrder(13);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnduranceQuestion(
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
          //     number: 13, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddLessSleepQuestionResponseModel> addLessSleep(
      AddLessSleepQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddLessSleepQuestionResponseModel response =
          await _questionRepository.addLessSleep(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
