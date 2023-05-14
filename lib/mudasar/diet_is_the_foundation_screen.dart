import 'dart:async';

import 'package:flutter/material.dart';

import 'eating_disorder.dart';
import 'next_Section_screen.dart';

class DietIsTheFoundationScreen extends StatefulWidget {
  const DietIsTheFoundationScreen({Key key}) : super(key: key);

  @override
  State<DietIsTheFoundationScreen> createState() =>
      _DietIsTheFoundationScreenState();
}

class _DietIsTheFoundationScreenState extends State<DietIsTheFoundationScreen> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * .4,
              width: width,
              color: Color(0xffD7E2F1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .05, vertical: height * .05),
                child: Image.asset(
                  'assets/images/Eating_healthy_food_image.png',
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Text(
                ' Diet is the Foundation of Weight Loss Journey',
                style: TextStyle(
                    fontSize: height * .03, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Text(
                " you'll learn how to build a strong, healthy foundation that will support your goals for years to come",
                style: TextStyle(
                    fontSize: height * .03, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: height * .06,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, _createRoute());
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.6,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Getting Started',
                    style: TextStyle(
                        fontSize: height * 0.024,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Weight Loser subscribers who lost at least 3% of their original weight as of October 2023.',
                style: TextStyle(
                    fontSize: height * .02, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Container(
              height: height * .03,
              width: width,
              color: const Color(0xffFFC5C4),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 900),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NextSetion(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
