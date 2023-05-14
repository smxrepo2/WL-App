import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/do_you_know.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

class DisagreeMsg extends StatefulWidget {
  SignUpBody signUpBody;
  DisagreeMsg({Key key, this.signUpBody}) : super(key: key);

  @override
  _DisagreeMsgState createState() => _DisagreeMsgState();
}

class _DisagreeMsgState extends State<DisagreeMsg> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                const SizedBox(height: 25),
                questionHeaderSimple(
                  percent: .99,
                  color: exBorder,
                ),
                SizedBox(height: height * .05),
                const Text(
                  "Disagree!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Book Antiqua'),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImagePath.exMsg,
              height: 330,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                "It’s never too early or too late to work \ntowards being the healthiest you.",
                style: msgStyle,
                textAlign: TextAlign.center,
              )),
          Positioned(
            bottom: 10,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                widget.signUpBody.exerciseQuestions.bodyType = "";
                print(
                    "BodyType:- ${widget.signUpBody.exerciseQuestions.bodyType}");
                mobile
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoyouknowScreen(
                              signUpBody: widget.signUpBody,
                            )))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 430, right: 430, top: 30, bottom: 30),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DoyouknowScreen(
                                    signUpBody: widget.signUpBody,
                                  )),
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
