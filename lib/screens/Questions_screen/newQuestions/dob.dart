import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/learnAboutYou.dart';

import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';

class DOBQestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  DOBQestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<DOBQestion> createState() => _DOBQestionState();
}

class _DOBQestionState extends State<DOBQestion> {
  int yearsOld = 0;
  DateTime _selectedDate = DateTime.now();
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;

  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[4];
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
                top: MediaQuery.of(context).size.height * 0.12,
                left: MediaQuery.of(context).size.width / 2 - 125,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Let us understand your profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "We never sell your personal information.",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Container(
            width: 127,
            height: 127,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              border: Border.all(width: 0.5, color: const Color(0xff707070)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$yearsOld',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 30,
                      color: Color(0xff23233c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(
                    text: ' year',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Color(0xff23233c),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          const Divider(
            thickness: 1,
            indent: 65,
            endIndent: 65,
            color: Color(0xff707070),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Month',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: Color(0xff86aef3),
                    letterSpacing: -0.44999999999999996,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                Text(
                  'Day ',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: Color(0xff86aef3),
                    letterSpacing: -0.44999999999999996,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                Text(
                  'Year',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: Color(0xff86aef3),
                    letterSpacing: -0.44999999999999996,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              // height: 90,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ScrollDatePicker(
                selectedDate: _selectedDate,
                minimumDate: DateTime(1922),
                locale: const Locale('en'),
                scrollViewOptions: DatePickerScrollViewOptions(
                  year: ScrollViewDetailOptions(
                    margin: const EdgeInsets.only(left: 10),
                  ),
                  month: ScrollViewDetailOptions(
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  day: ScrollViewDetailOptions(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                  ),
                ),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                    yearsOld = DateTime.now().year - _selectedDate.year;
                  });
                  widget.signupBody.dietQuestions.dOB =
                      DateFormat("yyyy-MM-dd'T'HH:mm:ss'")
                          .format(_selectedDate)
                          .toString();
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (yearsOld >= 18 && yearsOld <= 70) {
                widget.signupBody.age = yearsOld;
              } else {
                // showToast(text: 'Your Age should be 18y-70y', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Your Age should be 18y-70y, Please select your age'),
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

              var user = Provider.of<UserDataProvider>(context, listen: false);
              // String DOB=yearsOld.toString();
              String DOB = DateFormat("yyyy-MM-dd'T'HH:mm:ss'")
                  .format(_selectedDate)
                  .toString();
              int userId = user.userData.user.id;

              AddDOBQuestionRequestModel requestModel =
                  AddDOBQuestionRequestModel(
                      UserId: userId, DOB: DOB, QuestionOrder: 5);
              addDOBQuestion(requestModel).then((value) {
                if (value != null) {
                  if (value.response == "Data updated successfully") {
                    AddAgeQuestionRequestModel requestModel2 =
                        AddAgeQuestionRequestModel(
                            UserId: userId, Age: yearsOld, QuestionOrder: 5);
                    addAgeQuestion(requestModel2).then((value) {
                      if (value != null) {
                        if (value.response == "Data updated successfully") {
                          AuthService.setQuestionOrder(5);

                          ///For testing purpose
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LearnAboutYou(
                                questionsModel: widget.questionsModel,
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
          //     number: 5, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddDOBQuestionResponseModel> addDOBQuestion(
      AddDOBQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddDOBQuestionResponseModel response =
          await _questionRepository.addDOBQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }

  Future<AddAgeQuestionResponseModel> addAgeQuestion(
      AddAgeQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddAgeQuestionResponseModel response =
          await _questionRepository.addAgeQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
