import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/background.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/medical_condition.dart';

import '../../../Model/SignupBody.dart';
import '../../../Model/rest_id.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../../Service/AuthService.dart';
import '../../../utils/AppConfig.dart';
import '../../../repository/questions_repository.dart';
import '../../../utils/ui.dart';
import '../models/all_questions_model.dart';

class RestaurantQuestion extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  RestaurantQuestion(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<RestaurantQuestion> createState() => _RestaurantQuestionState();
}

class _RestaurantQuestionState extends State<RestaurantQuestion> {
  List selectedOptions = [];
  List<RestId> restId = [];

  List<AddRestaurantQuestionModel> resturantIds = [];
  List<dynamic> allMovies = [];
  bool loading = true;
  String gender = '';
  int genderid;
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getRestuarants();
  }

  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[8];

    //print(_questoins.options);
  }

  Future<dynamic> getRestuarants() async {
    var client = http.Client();
    try {
      var url = Uri.parse('https://weightchoper.somee.com/api/restaurant');
      var response = await client.get(url, headers: {
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
        'User-Agent': 'PostmanRuntime/7.28.4',
      });
      if (response != null && response.statusCode == 200) {
        print("Restaurants ${response.body}");
        setState(() {
          allMovies = json.decode(response.body)['restaurants'];
          loading = false;
        });
        print(allMovies.length);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Column(
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
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: 20,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          "We will try to find healthy choices from your favorite restaurants",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 15, top: 10),
                    child: allMovies.length == 0
                        ? Center(child: Text("No Restaurants"))
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: allMovies.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.95,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectedOptions
                                        .contains(allMovies[index]['Name'])) {
                                      selectedOptions
                                          .remove(allMovies[index]['Name']);
                                      restId.remove(RestId(
                                          RestuarantId: allMovies[index]
                                              ['Id']));
                                      resturantIds.remove(
                                          AddRestaurantQuestionModel(
                                              restuarantId: allMovies[index]
                                                  ['Id']));
                                    } else {
                                      selectedOptions
                                          .add(allMovies[index]['Name']);
                                      restId.add(RestId(
                                          RestuarantId: allMovies[index]
                                              ['Id']));
                                      resturantIds.add(
                                          AddRestaurantQuestionModel(
                                              restuarantId: allMovies[index]
                                                  ['Id']));
                                    }
                                    gender = allMovies[index]['Name'];
                                    genderid = allMovies[index]['Id'];
                                    print(gender);
                                    print(genderid);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(14.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: selectedOptions.contains(
                                                allMovies[index]['Name'])
                                            ? const Color(0xff4885ED)
                                            : const Color(0xffdfdfdf)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: selectedOptions.contains(
                                                allMovies[index]['Name'])
                                            ? const Color(0x29000000)
                                            : Colors.transparent,
                                        offset: const Offset(0, 3),
                                        blurRadius: 6,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        '$imageBaseUrl${allMovies[index]['Image']}',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${allMovies[index]['Name']}',
                                        style: const TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 15,
                                          color: Color(0xff2b2b2b),
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
                    if (selectedOptions.isEmpty && allMovies.length != 0) {
                      // showToast(
                      //     text: 'Kindly Choose Restaurants', context: context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text('Kindly Choose Restaurants'),
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
                      widget.signupBody.dietQuestions.favRestuarant =
                          selectedOptions.toString();
                      widget.signupBody.restaurants = restId;

                      var user =
                          Provider.of<UserDataProvider>(context, listen: false);
                      //String cousin=selectedCuisines.toString();
                      int userId = user.userData.user.id;

                      AddFavouriteRestaurantQuestionRequestModel requestModel =
                          AddFavouriteRestaurantQuestionRequestModel(
                              UserId: userId,
                              restaurants: resturantIds,
                              QuestionOrder: 9);
                      addFavouriteRestaurant(requestModel).then((value) {
                        if (value != null) {
                          if (value.response == "Data updated successfully") {}
                        }
                        AuthService.setQuestionOrder(9);

                        ///For testing purpose
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalCondition(
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
                //     number: 9, totalQuestion: _questionsModel.questoins.length),
                const SizedBox(height: 30),
              ],
            ),
    );
  }

  Future<AddFavouriteRestaurantQuestionResponseModel> addFavouriteRestaurant(
      AddFavouriteRestaurantQuestionRequestModel requestModel) async {
    try {
      EasyLoading.show();
      // Get.put(LaravelApiClient());
      QuestionRepository _questionRepository = QuestionRepository();
      AddFavouriteRestaurantQuestionResponseModel response =
          await _questionRepository.addFavouriteRestaurant(requestModel);
      EasyLoading.dismiss();
      return response;
    } catch (e) {
      // Get.showSnackbar();
      Ui.ErrorSnackBar(message: e.toString());
      throw Exception('unable to find your email');
    }
  }
}
