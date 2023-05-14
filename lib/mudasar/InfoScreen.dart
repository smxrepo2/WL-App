import 'package:flutter/material.dart';

import 'eating_disorder.dart';

class InFoScreen extends StatefulWidget {
  const InFoScreen({Key key}) : super(key: key);

  @override
  State<InFoScreen> createState() => _InFoScreenState();
}

class _InFoScreenState extends State<InFoScreen> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .03),
          child: Column(
            children: [
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * 0.05,
                child: Image.asset(
                  'assets/images/weightchopper.png',
                ),
              ),
              SizedBox(
                height: height * .13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: Text(
                  'We are pleased that you have shared your goals with us.',
                  style: TextStyle(
                      fontSize: height * .03, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: Text(
                  'Although weight loss is a significant objective, Weight Loser is committed to supporting individuals in achieving their own unique definition of better health.',
                  style: TextStyle(
                      fontSize: height * .03, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: height * .25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EatingDisorder()));
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
