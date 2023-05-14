import 'package:flutter/material.dart';

class QuestionBackground extends StatelessWidget {
  QuestionBackground(
      {Key key,
      // required this.questionIndex,
      @required this.color,
      @required this.question})
      : super(key: key);

  // int questionIndex;
  String question;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(47)),
            border: Border.all(width: 1.0, color: const Color(0x4d707070)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 160, right: 30, left: 30),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height * 0.25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
          child: Text(
            question.replaceFirst('your', 'your\n'),
            style: const TextStyle(
              fontFamily: 'Book Antiqua',
              fontSize: 25,
              color: Color(0xff23233c),
              letterSpacing: -0.75,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
