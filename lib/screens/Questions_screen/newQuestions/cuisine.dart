import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/restaurant.dart';

import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/AppConfig.dart';
import '../../../utils/ui.dart';

class CuisineQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  CuisineQuestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<CuisineQuestion> createState() => _CuisineQuestionState();
}

class _CuisineQuestionState extends State<CuisineQuestion> {
  List<String> data = [];
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[7];
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

  List<String> selectedCuisines = [];

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
                left: MediaQuery.of(context).size.width / 2 - 140,
                child: const Text(
                  "Let us build your personalized plan",
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
                  left: 50, right: 50, bottom: 15, top: 10),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedCuisines.contains(data[index])) {
                            selectedCuisines.remove(data[index]);
                          } else {
                            selectedCuisines.add(data[index]);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                              width: 2,
                              color: selectedCuisines.contains(data[index])
                                  ? const Color(0xff2196F3)
                                  : Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(2)),
                              child: Image.network(
                                '$imageBaseUrl${images[index]}',
                                width: 139,
                                height: 85,
                                fit: BoxFit.cover,
                              ),
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
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedCuisines.length > 3 || selectedCuisines.isEmpty) {
                // showToast(text: 'You can choose 3', context: context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            "Choose between 1 to 3 cuisines to continue"),
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
                widget.signupBody.dietQuestions.favCuisine =
                    selectedCuisines.toString();
                widget.signupBody.dietQuestions.favFoods =
                    selectedCuisines.toString();

                var user =
                    Provider.of<UserDataProvider>(context, listen: false);
                String cousin = selectedCuisines.toString();
                int userId = user.userData.user.id;

                AddCousinQuestionRequestModel requestModel =
                    AddCousinQuestionRequestModel(
                        UserId: userId, FavCuisine: cousin, QuestionOrder: 8);
                addCousinQuestion(requestModel).then((value) {
                  if (value != null) {
                    if (value.response == "Data updated successfully") {}
                  }
                  AuthService.setQuestionOrder(8);

                  ///For testing purpose
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantQuestion(
                                questionsModel: widget.questionsModel,
                                signupBody: widget.signupBody,
                              )));
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
          //     number: 8, totalQuestion: _questionsModel.questoins.length),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Future<AddCousinQuestionResponseModel> addCousinQuestion(
      AddCousinQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddCousinQuestionResponseModel response =
          await _questionRepository.addCousinQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
