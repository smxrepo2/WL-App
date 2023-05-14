import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/constant.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/sleepHours.dart';

import '../models/all_questions_model.dart';

class LearnAboutYou extends StatefulWidget {
  LearnAboutYou({Key key, @required this.signUpBody, this.questionsModel})
      : super(key: key);
  SignUpBody signUpBody;
  GetAllQuestionsModel questionsModel;
  @override
  State<LearnAboutYou> createState() => _LearnAboutYouState();
}

class _LearnAboutYouState extends State<LearnAboutYou> {
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;
  @override
  void initState() {
    super.initState();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[4];
    //print(_questoins.options);
    // change page after 3 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SleepHours(
                    questionsModel: widget.questionsModel,
                    signupBody: widget.signUpBody,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        color: backgroundColors[1],

        child: Center(
          child: Text(
            "Let's learn more about your habits to develop a personalized  plan for you",
            style: GoogleFonts.lato(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Let's Learn About You",
        //       style: TextStyle(
        //           fontSize: 26,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white),
        //       textAlign: TextAlign.center,
        //     ),
        //     SizedBox(
        //       height: MediaQuery.of(context).size.height * 0.4,
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => SleepHours(
        //                       questionsModel: widget.questionsModel,
        //                       signupBody: widget.signUpBody,
        //                     )));
        //       },
        //       child: Text("Continue"),
        //       style: ElevatedButton.styleFrom(
        //           primary: Colors.white,
        //           onPrimary: Colors.black,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10))),
        //     ),
        //     SizedBox(
        //       height: 50,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
