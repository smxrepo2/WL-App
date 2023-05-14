import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/mudasar/select_your_age_screen.dart';

import '../../Model/customer_pkgs.dart';
import '../../notifications/getit.dart';
import '../Questions_screen/methods/methods.dart';
import '../Questions_screen/models/all_questions_model.dart';
import '../Questions_screen/used-Questions/do_you_know.dart';
import '../auth/authenticate/provider/authprovider.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key key, this.signUpBody, this.userModel}) : super(key: key);
  SignUpBody signUpBody;
  UserDataModel userModel;
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {
  Future<GetAllQuestionsModel> _allQuestionFuture;
  @override
  void initState() {
    _allQuestionFuture = GetAllQueestions();
    widget.signUpBody.customerPackages = CustomerPackages();
    widget.signUpBody.dietQuestions = DietQuestions();
    widget.signUpBody.mindQuestions = MindQuestions();
    widget.signUpBody.exerciseQuestions = ExerciseQuestions();
    var provider = getit<AuthModeprovider>();
    if (provider.getData() != null) {
      if (!provider.getData()) {
        widget.signUpBody.email = widget.signUpBody.email;
        widget.signUpBody.password = widget.signUpBody.password;
        widget.signUpBody.userName = widget.signUpBody.userName;
        widget.signUpBody.name = widget.signUpBody.userName;
     }
   }
    super.initState();
  }
  double height;
  double  width;
  @override
  Widget build(BuildContext context) {
      height =MediaQuery.of(context).size.height-kToolbarHeight;
       width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                return Padding(
                  padding:   EdgeInsets.symmetric(horizontal:width*.07 ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/weightchopper.png',
                      ),
                      SizedBox(height: height*.02,),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Image.asset( 'assets/images/let_go.png'),
                          
                          ),
                          SizedBox(height: height*.02,),
                      Text(
                        'Weight Loser Plan personalized for you!',
                        style: GoogleFonts.josefinSans(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                        SizedBox(height: height*0.06),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: widget.signUpBody.name,
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              ', allow us to gain insight into your biological characteristics and habits to create a personalized plan for you.',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ])),
                         SizedBox(height: height*.02,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>DoyouknowScreen()
                            ),
                          );
                        },
                        child: const Text(
                          'Let\'s go',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
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
}


class LScreen extends StatefulWidget {
  const LScreen({Key key}) : super(key: key);

  @override
  State<LScreen> createState() => _LScreenState();
}


///  let go screen
class _LScreenState extends State<LScreen> {
  // medıa query sıze
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height-kToolbarHeight;
    width=MediaQuery.of(context).size.width;

    return Scaffold(
       body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: height*0.1,
            ),
            SizedBox(
              height: height*0.05,
              child: Image.asset(
                'assets/images/weightchopper.png',
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.04),
            Text(
              'Weight Loser',
              style: GoogleFonts.poppins(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.01),
            Text(
              'Plan personalized for you!',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
              SizedBox(height:  height*0.03),
            RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: ' '
                        'UserName,',
                    // text: widget.signUpBody.name,
                    style: GoogleFonts.openSans(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                    'Allow us to gain insight into your biological characteristics and habits to create a personalized plan for you.',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ])),
            SizedBox(height:  height*0.06),
            SizedBox(height:  height*0.35, width:   width ,
                child: Image.asset( 'assets/images/To_Do.png'),),
            SizedBox(height:  height*0.09),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const SelectYourAgeScreen(),));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AboutUs(
                //       signUpBody: widget.signUpBody,
                //       userDataModel: widget.userModel,
                //       questionsModel: snapshot.data,
                //     ),
                //   ),
                // );
              },
              child: const Text(
                'Let\'s go',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
