import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/betterTogether.dart';

class BuildingPlan extends StatefulWidget {
  const BuildingPlan({Key key}) : super(key: key);

  @override
  State<BuildingPlan> createState() => _BuildingPlanState();
}

class _BuildingPlanState extends State<BuildingPlan> {
  List<Map<String, dynamic>> data = [
    {
      'image': 'assets/images/clock.png',
      'title': 'No time for a complicated diet? Try our 10-minute solution.',
      'color': Color(0xffFFE8E8),
    },
    {
      'image': 'assets/images/cereal.png',
      'title':
          'Don\'t give up your favorite foods, just find healthier ways to enjoy them.',
      'color': Color(0xffE8F7FF),
    },
    {
      'image': 'assets/images/weight-loss.png',
      'title':
          'We don\'t just track calories. We track nutrition for a healthier you.',
      'color': Color(0xffE4EFFF),
    },
    {
      'image': 'assets/images/potato.png',
      'title':
          'Get your green on with our app\'s delicious and nutritious plans.',
      'color': Color(0xffE8FFFB),
    },
    {
      'image': 'assets/images/healthcare.png',
      'title':
          'Your satisfaction is our first priority -  Let our app take care of you.',
      'color': Color(0xffF3E8FF),
    },
    {
      'image': 'assets/images/fruits.png',
      'title':
          'Get your daily dose of vitamins and fiber with our app\'s fruit inspired meal plans.',
      'color': Color(0xffFFF8E8),
    },
    {
      'image': 'assets/images/orange.png',
      'title':
          'Experience the energy and vitality of whole foods with our app\'s fresh juice plans.',
      'color': Color(0xffDCDCDC),
    },
    {
      'image': 'assets/images/avacado.png',
      'title':
          'Our app offers personalized meal plans tailored to your specific dietary needs.',
      'color': const Color(0xffFFF3F3),
    },
  ];

  PageController _pageController = PageController();
  Timer _timer;

  @override
  void initState() {
    // change page every 5 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_pageController.page == data.length - 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BetterTogether()));
          _timer.cancel();
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return buildingPlanSlide(
              data[index]['title'], data[index]['image'], data[index]['color']);
        },
      ),
    );
  }

  Container buildingPlanSlide(String title, String image, Color color) {
    return Container(
      color: color,
      child: Column(
        children: [
          const SizedBox(height: 75),
          Text(
            'Building Plan...'.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.7,
            child: Image.asset(image),
          ),
          const SizedBox(height: 50),
          Text(
            'Why WeightLoser is Different?'.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: 15,
            ),
          ),
          Divider(
            color: Colors.grey.shade500,
            thickness: 0.75,
            indent: 125,
            endIndent: 125,
            height: 30,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  title,
                  textStyle: GoogleFonts.openSans(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
