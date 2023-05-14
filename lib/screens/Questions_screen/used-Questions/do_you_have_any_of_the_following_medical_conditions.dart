import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/not_support_medical_condition.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import 'diet _exercise_mind.dart';

class DoYouHaveFollowingMedicalConditions extends StatefulWidget {
  SignUpBody signUpBody;

  DoYouHaveFollowingMedicalConditions({Key key, this.signUpBody})
      : super(key: key);

  @override
  _DoYouHaveFollowingMedicalConditionsState createState() =>
      _DoYouHaveFollowingMedicalConditionsState();
}

class _DoYouHaveFollowingMedicalConditionsState
    extends State<DoYouHaveFollowingMedicalConditions> {
  String gender = '';
  List selectedOptions = [];
  List<Data> medicalCondition = [
    Data("High blood pressure", ImagePath.highBlood),
    Data("Heart disease or stroke", ImagePath.heartStroke),
    Data("Diabetes", ImagePath.diabetes),
    Data("Kidney diseases", ImagePath.kidney),
    Data("High cholesterol", ImagePath.colestrol),
    Data("Severe Arthritis", ImagePath.severer),
    Data("Liver disease", ImagePath.liver),
    Data("Depression", ImagePath.depression),
    Data("Chronic back pain", ImagePath.backPain),
    Data("Eating disorders", ImagePath.eatingDisorder),
    Data("None", '')

    //	"Eating disorders such as Bulimia Nervosa, Anorexia Nervosa, bothor binge eating disorder"
  ];

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool _canshow = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Biology',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Diet',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Excersie',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mind',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sleep/Habit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.3,
              width: width,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.2,
                    decoration: const BoxDecoration(
                        color: Color(0xffD7E2F1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Center(
                      child: Text(
                        'Let us understand your profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.025),
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.13,
                      left: height * 0.04,
                      child: Container(
                        height: height * 0.16,
                        width: width * 0.85,
                        padding: EdgeInsets.all(height * .02),
                        child: FittedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Select your present medical \n         condition if any",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.06),
                          ),
                        )),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      )),

                  ///these are the text form fields
                ],
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            SizedBox(
              height: height * .34,
              width: width,
              child: ListView.builder(
                  
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicalCondition.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .06, vertical: height * .01),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (medicalCondition[index].text == "None") {
                              selectedOptions.clear();
                              selectedOptions.add("None");
                            } else if (selectedOptions
                                .contains(medicalCondition[index].text)) {
                              selectedOptions
                                  .remove(medicalCondition[index].text);
                            } else {
                              selectedOptions.remove("None");
                              selectedOptions.add(medicalCondition[index].text);
                            }

                            gender = medicalCondition[index].text;
                          });
                        },
                        child: Container(
                          width: Get.width * .9,
                          height: height * .07,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * .05),
                                child: Text(
                                  medicalCondition[index].text,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: selectedOptions
                                      .contains(medicalCondition[index].text)
                                  ? const Color(0xffD7E2F1)
                                  : Colors.white,
                              border: Border.all(
                                color: selectedOptions
                                        .contains(medicalCondition[index].text)
                                    ? const Color(0xffD7E2F1)
                                    : Colors.grey,
                              ),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
              onTap: () {
                if (selectedOptions.contains("Liver disease") ||
                    selectedOptions.contains("Severe Arthritis") ||
                    selectedOptions.contains("Chronic back pain") ||
                    selectedOptions.contains("Eating disorders")) {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotSupportMedicalCondition(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: NotSupportMedicalCondition(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                } else if (selectedOptions.isNotEmpty) {
                  if (selectedOptions.contains("None")) {
                    widget.signUpBody.dietQuestions.medicalCondition = "none";
                  } else {
                    widget.signUpBody.dietQuestions.medicalCondition =
                        selectedOptions.toString();
                  }
                  print(widget.signUpBody.dietQuestions.medicalCondition);
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DietExerciseMindScreen(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DietExerciseMindScreen(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                } else {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DietExerciseMindScreen(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DietExerciseMindScreen(
                                      signUpBody: widget.signUpBody,
                                    )),
                              )));
                }
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.6,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: height * 0.024,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.01,
                  width: width / 2,
                  child: LinearProgressIndicator(
                    minHeight: height * 0.02,
                    color: const Color.fromARGB(255, 27, 25, 25),
                    value: 1.6,
                  ),
                ),
                const Text('60 % Completed'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
