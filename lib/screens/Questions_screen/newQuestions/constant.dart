import 'package:flutter/material.dart';

List<Color> backgroundColors = [
  const Color(0x4d4885ed),
  const Color(0x4dff3f3f),
  const Color(0xffA947E7).withOpacity(0.33),
  const Color(0xffDF4300).withOpacity(0.33),
];

// List<Color> backgroundColors = [
//   const Color(0x4d4885ed),
//   const Color(0x4d4885ed),
//   const Color(0x4d4885ed),
//   const Color(0x4d4885ed),
// ];

// List<String> totalQuestions = [
//   'What\'s your gender?',
//   'What\'s your height?',
//   'What\'s your weight?',
//   'What\'s your goal weight?',
//   'What\'s your date of birth?',
//   'What are your sleep hours?',
//   'What do you consider yourself?',
//   'What is your favorite cuisine?',
//   'Tell us about your favorite restaurant.',
//   'Tell us which food you cannot eat for any reason',
//   'I drink less than 8 (16 oz) of glass of water every day',
//   'I sleep less than 7 hours',
//   'I can do a minimum of 10 minutes of exercise',
//   'How often do you go to the gym?',
//   'How can you describe everyday mobility?',
//   'I cannot control myself when it comes to food',
//   'I am preoccupied with thinking about foods most of the time',
//   'My past diets failed due to my cravings',
//   'I eat more than normal when I am stressed',
//   'I eat more than normal when I am bored',
//   'I eat quicker compared to people around me',
//   'I eat meals or snacks while watching TV'
// ];

showToast({String text, BuildContext context}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.red,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

countingText({int number, @required int totalQuestion}) {
  return Text(
    '$number/$totalQuestion',
    style: const TextStyle(
      fontFamily: 'Open Sans',
      fontSize: 15,
      color: Color(0xff2b2b2b),
      letterSpacing: -0.44999999999999996,
      fontWeight: FontWeight.w600,
    ),
    softWrap: false,
  );
}
