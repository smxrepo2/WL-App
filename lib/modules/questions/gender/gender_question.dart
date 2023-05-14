import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:weight_loser/modules/questions/gender/controllers/question_controller.dart';

import '../../../screens/Questions_screen/newQuestions/background.dart';
import '../../../screens/Questions_screen/newQuestions/constant.dart';

class GenderQuestion extends GetView<QuestionController>{
  const GenderQuestion({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white),
        body: Column(
          children: [
            Stack(
              children: [
                QuestionBackground(
                  // questionIndex: currentPage,
                    color: backgroundColors[0],
                    // question: totalQuestions[0]
                    question: controller.question.value.question),
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
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.options.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // setState(() {
                        //
                        // });

                        controller.selectedOption=index;

                        // Direct Moved to next Screen
                        if (controller.selectedOption== -1) {
                          showToast(
                              text: 'Choose any Gender',
                              context: context);
                        } else {
                          String gender=controller.options.elementAt(index);

                          ///Now call the API to add gender Question
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HeightQuestion(
                                    signUpBody: signUpBody,
                                    questionsModel: snapshot.data,
                                  )));*/
                        }


                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.5, horizontal: 30),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: controller.selectedOption == index
                                    ? const Color(0xff4885ED)
                                    : const Color(0xffdfdfdf),
                                width: controller.selectedOption == index ? 2 : 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minLeadingWidth: 0,
                          leading: Transform.translate(
                            offset: const Offset(0, 3),
                            child: Image.network('${controller.imageUrl[index]['icon']}',
                                width: 15,
                                height: 15),
                          ),
                          title: Text(controller.options.elementAt(index),
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
/*                  GestureDetector(
                    onTap: () {
                      if (selectedOption == -1) {
                        showToast(text: 'Choose any Gender', context: context);
                      } else {
                        signUpBody.dietQuestions.gender = data[selectedOption];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HeightQuestion(
                                      signUpBody: signUpBody,
                                      questionsModel: snapshot.data,
                                    ))

*//*                            MaterialPageRoute(
                                builder: (context) => EatSnacksQuestion(
                                  signupBody: signUpBody,
                                  questionsModel: snapshot.data,
                                ))*//*
                            );
                      }
                    },
                    child: Container(
                        width: 100,
                        height: 35,
                        // padding:
                        // const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: backgroundColors[0],
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
                                color: Color(0xff2b2b2b),
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
                            Icon(Icons.arrow_forward)
                          ],
                        )),
                  ),*/
            const SizedBox(height: 5),
            countingText(
                number: 1,
                totalQuestion: controller.allQuestions.value.questoins.length),
            const SizedBox(height: 5),
          ],
        ));
  }

}