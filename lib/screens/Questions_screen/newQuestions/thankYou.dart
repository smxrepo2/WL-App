import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/buildingPlan.dart';

import 'constant.dart';

class ThankYouScreen extends StatefulWidget {
  ThankYouScreen({Key key, this.signupBody}) : super(key: key);

  SignUpBody signupBody;

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  // 30 mint timer
  Timer _timer;
  int hours = 0;
  int minutes = 30;
  int seconds = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 1) {
            if (minutes < 1) {
              if (hours < 1) {
                timer.cancel();
              } else {
                hours -= 1;
                minutes = 59;
                seconds = 59;
              }
            } else {
              minutes -= 1;
              seconds = 59;
            }
          } else {
            seconds -= 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: backgroundColors[3],
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(47)),
                      border: Border.all(
                          width: 1.0, color: const Color(0x4d707070)),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 160, right: 30, left: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: MediaQuery.of(context).size.height * 0.725,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          'Your personalized Weightloser profile is ready!',
                          style: TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.75),
                            letterSpacing: -0.75,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Take me to my Personalized Weightloser Profile for Free',
                          style: TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 14,
                            color: Colors.blueAccent.withOpacity(0.75),
                            letterSpacing: -0.75,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.25,
                          margin: const EdgeInsets.only(top: 20),
                          child: Card(
                            color: Colors.black.withOpacity(0.75),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                children: const [
                                  Text(
                                    'Limited Period Discount\nSpecially for you!',
                                    style: TextStyle(
                                      fontFamily: 'Book Antiqua',
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '\$ 19.99',
                                    style: TextStyle(
                                      fontFamily: 'Book Antiqua',
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'per month',
                                    style: TextStyle(
                                      fontFamily: 'Book Antiqua',
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '\$ 9.99',
                                    style: TextStyle(
                                      fontFamily: 'Book Antiqua',
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'per month',
                                    style: TextStyle(
                                      fontFamily: 'Book Antiqua',
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '100% Money Back Guarantee\nIf you do not lose weight as per plan',
                          style: TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.75),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Grab this offer with in',
                          style: TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.75),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '00 Hrs $minutes: $seconds Min',
                          style: const TextStyle(
                            fontFamily: 'Book Antiqua',
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BuildingPlan()));
                          },
                          child: const Text(
                            'I want to lose weight',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.75),
                            maximumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
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
              Positioned(
                top: MediaQuery.of(context).size.height * 0.125,
                left: MediaQuery.of(context).size.width / 2 - 80,
                child: const Text(
                  "Thank you so much!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
