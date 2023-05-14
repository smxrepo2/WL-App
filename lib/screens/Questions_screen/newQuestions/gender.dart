import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/customer_pkgs.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/height.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../notifications/getit.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../../auth/authenticate/provider/authprovider.dart';
import '../methods/methods.dart';
import 'constant.dart';

class GenderQuestion extends StatefulWidget {
  GenderQuestion({Key key, this.signUpBody, this.questionModel})
      : super(key: key);
  SignUpBody signUpBody = SignUpBody();
  GetAllQuestionsModel questionModel;

  @override
  State<GenderQuestion> createState() => _GenderQuestionState();
}

class _GenderQuestionState extends State<GenderQuestion> {
  SignUpBody signUpBody = SignUpBody();
  Future<GetAllQuestionsModel> _allQuestionFuture;
  int selectedOption = -1;

  List<Map<String, dynamic>> imageUrl = [
    {
      "gender": "Male",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/male-sign-microsoft.png',
    },
    {
      "gender": "Female",
      "icon":
          'https://cdn-0.emojis.wiki/emoji-pics/microsoft/female-sign-microsoft.png',
    },
    {
      "gender": "Non Binary",
      "icon":
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Non-binary_symbol_%28fixed_width%29.svg/1200px-Non-binary_symbol_%28fixed_width%29.svg.png',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allQuestionFuture = GetAllQueestions();
    print("Got All Questions");
    signUpBody.customerPackages = CustomerPackages();
    signUpBody.dietQuestions = DietQuestions();
    signUpBody.mindQuestions = MindQuestions();
    signUpBody.exerciseQuestions = ExerciseQuestions();
    var provider = getit<AuthModeprovider>();
    if (provider.getData() != null) {
      if (!provider.getData()) {
        signUpBody.email = widget.signUpBody.email;
        signUpBody.password = widget.signUpBody.password;
        signUpBody.userName = widget.signUpBody.userName;
        signUpBody.name = widget.signUpBody.userName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white),
      body: FutureBuilder<GetAllQuestionsModel>(
        future: _allQuestionFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                        "There was an error fetching further details.\nPlease go back and tap continue again"));
              } else if (snapshot.hasData) {
                GetAllQuestionsModel questionsModel = snapshot.data;
                Questoins _questoins = questionsModel.questoins[0];
                List<String> data = _questoins.options
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .replaceAll("\"", "")
                    .split(",");
                return Column(
                  children: [
                    Stack(
                      children: [
                        QuestionBackground(
                            // questionIndex: currentPage,
                            color: backgroundColors[0],
                            // question: totalQuestions[0]
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
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                  if (selectedOption == -1) {
                                    showToast(
                                        text: 'Choose any option',
                                        context: context);
                                  } else {
                                    var p = Provider.of<UserDataProvider>(
                                        context,
                                        listen: false);

                                    String gender = data[selectedOption];
                                    int userId = p.userData.user.id;

                                    AddGenderQuestionRequestModel requestModel =
                                        AddGenderQuestionRequestModel(
                                            UserId: userId,
                                            Gender: gender,
                                            QuestionOrder: 1);
                                    /*    AddGenderQuestionResponseModel response=await addGenderQuestion(requestModel);
                                if (response.response=="Data updated successfully") {

                                  signUpBody.dietQuestions.gender =
                                  data[selectedOption];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HeightQuestion(
                                            signUpBody: signUpBody,
                                            questionsModel: snapshot.data,
                                          )));
                                }*/

                                    addGenderQuestion(requestModel)
                                        .then((value) {
                                      if (value.response ==
                                          "Data updated successfully") {
                                        AuthService.setQuestionOrder(1);
                                        signUpBody.dietQuestions.gender =
                                            data[selectedOption];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HeightQuestion(
                                                      signUpBody: signUpBody,
                                                      questionsModel:
                                                          snapshot.data,
                                                    )));
                                      }
                                    });
                                  }
                                  // String userId=AuthService.getUserId()

                                  // Direct Moved to next Screen
/*                                if (selectedOption == -1) {
                                  showToast(
                                      text: 'Choose any Gender',
                                      context: context);
                                } else {
                                  signUpBody.dietQuestions.gender =
                                      data[selectedOption];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HeightQuestion(
                                                signUpBody: signUpBody,
                                                questionsModel: snapshot.data,
                                              )));
                                }*/
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.5, horizontal: 30),
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
                                  leading: Transform.translate(
                                    offset: const Offset(0, 3),
                                    child: Image.network(
                                        '${imageUrl[index]['icon']}',
                                        width: 15,
                                        height: 15),
                                  ),
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
                        if (selectedOption == -1) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                      'Please select any option to proceed'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'))
                                  ],
                                );
                              });
                          // showToast(
                          //     text: 'Choose any option', context: context);
                        } else {
                          var p = Provider.of<UserDataProvider>(context,
                              listen: false);

                          String gender = data[selectedOption];
                          int userId = p.userData.user.id;

                          AddGenderQuestionRequestModel requestModel =
                              AddGenderQuestionRequestModel(
                                  UserId: userId,
                                  Gender: gender,
                                  QuestionOrder: 1);
                          /*    AddGenderQuestionResponseModel response=await addGenderQuestion(requestModel);
                                if (response.response=="Data updated successfully") {

                                  signUpBody.dietQuestions.gender =
                                  data[selectedOption];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HeightQuestion(
                                            signUpBody: signUpBody,
                                            questionsModel: snapshot.data,
                                          )));
                                }*/

                          addGenderQuestion(requestModel).then((value) {
                            if (value.response == "Data updated successfully") {
                              AuthService.setQuestionOrder(1);
                              signUpBody.dietQuestions.gender =
                                  data[selectedOption];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HeightQuestion(
                                            signUpBody: signUpBody,
                                            questionsModel: snapshot.data,
                                          )));
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
//                   const SizedBox(height: 5),
//                   countingText(
//                       number: 1,
//                       totalQuestion: questionsModel.questoins.length),
                    const SizedBox(height: 30),
                  ],
                );
              }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<AddGenderQuestionResponseModel> addGenderQuestion(
      AddGenderQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      //Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddGenderQuestionResponseModel response =
          await _questionRepository.addGenderQuestion(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
