import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key,
    @required this.userDataModel,
    @required this.signUpBody,
    this.questionsModel})
      : super(key: key);
  SignUpBody signUpBody;
  GetAllQuestionsModel questionsModel;
  UserDataModel userDataModel;

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Widget> questionScreens;

  // Future<GetAllQuestionsModel> _allQuestionFuture;
  @override
  void initState() {
    // _allQuestionFuture = GetAllQueestions();
    // widget.signUpBody.userName = "Faizan";
    // widget.signUpBody.name = "Faizan";
    // widget.signUpBody.email = "Faizanshoukat45@gmail.com";
    // widget.signUpBody.password = "admin123";


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
            "assets/icons/appicon.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Weight Loser",
            style: GoogleFonts.openSans(
                color: Colors.black, fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            "About Us",
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nisl eget ultricies tincidunt, nunc nisl aliquam mauris, eget aliquet nunc nisl sed nunc. Nullam auctor, nisl eget ultricies tincidunt, nunc nisl aliquam mauris, eget aliquet nunc nisl sed nunc. Nullam auctor, nisl eget ultricies tincidunt, nunc nisl aliquam mauris, eget aliquet nunc nisl sed nun',
            textAlign: TextAlign.justify,
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                int questionOrder = widget.userDataModel.user.questionOrder;
                print(questionOrder);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),),
        ],
      ),
    ),)
    ,
    );
  }
}

/*
*  questionScreens = [
      GenderQuestion(signUpBody: widget.signUpBody),
      HeightQuestion(
        signUpBody: widget.signUpBody,
        questionsModel: widget.questionsModel,
      ),
      HeightQuestion(
        signUpBody: widget.signUpBody,
        questionsModel: widget.questionsModel,
      ),
      HeightQuestion(
        signUpBody: widget.signUpBody,
        questionsModel: widget.questionsModel,
      ),
      DOBQestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      SleepHours(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EatTypeQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      CuisineQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      RestaurantQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      MedicalCondition(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      AvoidFoodQuestionQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      WaterQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      SleepQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EnduranceQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      GymRoutineQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      MobilityQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      FoodControlQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      ThinkingFoodQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      PastDietsQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EatStressedQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EatBoredQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EatQuickerQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
      EatSnacksQuestion(
        questionsModel: widget.questionsModel,
        signupBody: widget.signUpBody,
      ),
    ];
    int questionOrder = widget.userDataModel.user.QuestionOrder;
    Future.delayed(Duration.zero, () {
      if (questionOrder == 23) {
        if (widget.userDataModel.Paid) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                (route) => false,
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentScreen(),
            ),
          );
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => BottomBarNew(0)),
          //   (route) => false,
          // );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => questionScreens[questionOrder],
          ),
        );
      }
    });*/