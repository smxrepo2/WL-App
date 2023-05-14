/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/customer_pkgs.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/Questions_screen/methods/methods.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/avoidFood.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/cuisine.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/dob.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatBored.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatQuicker.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatSnacks.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatStressed.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/eatType.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/endurance.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/foodControl.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/gender.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/goalWeight.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/gymRoutine.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/height.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/mobility.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/pastDiets.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/restaurant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/sleep.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/sleepHours.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/thinkingFood.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/select_your_daily_normal_daily_waterIntake_screen.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/weight.dart';
import 'package:weight_loser/screens/Questions_screen/providers/all_questions_provider.dart';
import 'package:weight_loser/screens/Questions_screen/providers/questions_provider.dart';
import 'package:weight_loser/screens/choose_your_plan.dart';
import 'package:weight_loser/screens/screentext/screens/screenText.dart';

import 'background.dart';

class QuestionsBody extends StatefulWidget {
  const QuestionsBody({Key key}) : super(key: key);

  @override
  State<QuestionsBody> createState() => _QuestionsBodyState();
}

class _QuestionsBodyState extends State<QuestionsBody> {
  PageController pageController = PageController();
  SignUpBody signUpBody = SignUpBody();
  Future<GetAllQuestionsModel> _allQuestionFuture;
  bool status = false;
  String text = 'Question can not be Empty';
  void checkValidation(status) {
    setState(() {
      this.status = status;
    });
  }

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
    //  overlays: [SystemUiOverlay.top]);
    _allQuestionFuture = GetAllQueestions();
    print("Got All Questions");
    signUpBody.customerPackages = CustomerPackages();
    signUpBody.dietQuestions = DietQuestions();
    signUpBody.mindQuestions = MindQuestions();
    signUpBody.exerciseQuestions = ExerciseQuestions();
  }

  int currentPage = 0;
  List<String> totalQuestions = [];

  int currentBackgroundColor = 0;

  List<Color> backgroundColors = [
    const Color(0x4d4885ed),
    const Color(0x4dff3f3f),
    const Color(0xffA947E7).withOpacity(0.33),
    const Color(0xffDF4300).withOpacity(0.33),
  ];

  void changeBackgroundColor() {
    if (currentPage > 14) {
      currentBackgroundColor = 3;
    } else if (currentPage > 10) {
      currentBackgroundColor = 2;
    } else if (currentPage > 5) {
      currentBackgroundColor = 1;
    } else {
      currentBackgroundColor = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<GetAllQuestionsModel>(
              future: _allQuestionFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError)
                      return Text("No Internet Connectivity");
                    else if (snapshot.hasData) {
                      Provider.of<allquestionprovider>(context, listen: false)
                          .setAllQuestions(snapshot.data);
                      totalQuestions = snapshot.data.questionsContent;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                if (currentPage < totalQuestions.length)
                                  QuestionBackground(
                                      questionIndex: currentPage,
                                      color: backgroundColors[
                                          currentBackgroundColor],
                                      question: totalQuestions[currentPage]),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.04,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      if (currentPage > 0) {
                                        setState(() {
                                          currentPage--;
                                          this.status = true;
                                        });
                                        pageController.animateToPage(
                                            currentPage,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            curve: Curves.easeIn);
                                        changeBackgroundColor();
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 350,
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                controller: pageController,
                                children: [
                                  GenderQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  HeightQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  WeightQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  GoalWeightQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  DOBQestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  SleepHours(
                                      signupBody: signUpBody,
                                      callBack: checkValidation),
                                  EatTypeQuestion(
                                      signupBody: signUpBody,
                                      questionsModel: snapshot.data,
                                      callBack: checkValidation),
                                  CuisineQuestion(
                                      signupBody: signUpBody,
                                      questionsModel: snapshot.data,
                                      callBack: checkValidation),
                                  RestaurantQuestion(
                                      signupBody: signUpBody,
                                      questionsModel: snapshot.data,
                                      callBack: checkValidation),
                                  AvoidFoodQuestionQuestion(
                                      signupBody: signUpBody,
                                      questionsModel: snapshot.data,
                                      callBack: checkValidation),
                                  WaterQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  SleepQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  EnduranceQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  GymRoutineQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  MobilityQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  FoodControlQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  ThinkingFoodQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  PastDietsQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  EatStressedQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  EatBoredQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  EatQuickerQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                  EatSnacksQuestion(
                                      signupBody: signUpBody,
                                      callBack: checkValidation,
                                      questionsModel: snapshot.data),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (currentPage != 8) {
                                  if (status) {
                                    print(signUpBody.dietQuestions.gender);

                                    if (mounted) {
                                      setState(() {
                                        currentPage++;
                                        this.status = false;
                                        if (currentPage ==
                                            totalQuestions.length) {
                                          setState(() {
                                            currentPage--;
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                //backgroundColor: Colors.green,
                                                title:
                                                    Text("Confirm Submission"),
                                                content: Text(
                                                    "You won't be able to navigate back on Question Screen"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ScreenText(
                                                                          signUpBody:
                                                                              signUpBody,
                                                                        )));
                                                      },
                                                      child: Text("Continue"))
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          pageController.animateToPage(
                                              currentPage,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeIn);

                                          changeBackgroundColor();
                                        }
                                      });
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("$text"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      currentPage++;
                                      this.status = false;
                                      if (currentPage ==
                                          totalQuestions.length) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChoosePlan(
                                                      signUpBody: signUpBody,
                                                    )));
                                      } else {
                                        pageController.animateToPage(
                                            currentPage,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn);

                                        changeBackgroundColor();
                                      }
                                    });
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xffc7dafa)),
                                ),
                                child: Text(
                                  currentPage + 1 == totalQuestions.length
                                      ? ' Done->'
                                      : ' Next->',
                                  style: const TextStyle(
                                    fontFamily: 'Book Antiqua',
                                    fontSize: 20,
                                    color: Color(0xff2b2b2b),
                                    letterSpacing: -0.6,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${currentPage + 1}/${totalQuestions.length}',
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 15,
                                color: Color(0xff2b2b2b),
                                letterSpacing: -0.44999999999999996,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            )
                          ],
                        ),
                      );
                    }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}
*/