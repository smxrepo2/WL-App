import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

class DoNotKnow extends StatefulWidget {

  final Function() ontap;
  DoNotKnow({this.ontap});

  @override
  State<DoNotKnow> createState() => _DoNotKnowState();
}

class _DoNotKnowState extends State<DoNotKnow> {
  @override
  Widget build(BuildContext context) {
    var mobile=Responsive1.isMobile(context);
    return Scaffold(
        body: Center(child: Stack(
          children: <Widget>[
            Container(child: Column(
              children: [
                SizedBox(height: 25),
                questionHeaderSimple(percent: .99,color: mindBorder,),
                SizedBox(height: 35),
                Text("I don't know!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'Book Antiqua'),)
              ],
            ),),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                ImagePath.mindmsg,
                height: 290,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: const Text(
                  "To eat is a necessity, but to\neat intelligently is an art",
                  style: msgStyle,
                  textAlign: TextAlign.center,
                )),
            Positioned(
              bottom: 20,
              left:40,
              right: 40,
              child: InkWell(
                onTap: widget.ontap,
                child:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      width: Get.width * .6,
                      height: 40,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(40.0))),
                      child: Center(
                        child: Text(
                          "Next",
                          style:buttonStyle,
                        ),
                      )),
                ),),
            )

          ],
        ),));
  }
}
