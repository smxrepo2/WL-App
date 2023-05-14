import 'package:flutter/material.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/gender_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';


class DoyouknowScreen extends StatefulWidget {
  SignUpBody signUpBody;
  DoyouknowScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _DoyouknowScreenState createState() => _DoyouknowScreenState();
}

class _DoyouknowScreenState extends State<DoyouknowScreen> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  questionHeaderSimple(
                    percent: .99,
                    color: exBorder,
                  ),
                  SizedBox(height: height * .05),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Do you know?',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  SizedBox(
                      height: mobile ? 300 : 250,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.doYou,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: height * .06),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: width*0.03),
                    child: FittedBox(
                      child: Text(
                        'Here, you have 24x7 access to nutritional, exercise, and mind\n coaches who answer any of your questions 24 hours a day.\nWe work together closely to make you healthy.',
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: height*.05),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .1),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenderScreen() ,));
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
            ],
          ),
        ),
      ),
    );
  }
}
