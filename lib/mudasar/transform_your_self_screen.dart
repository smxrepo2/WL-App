import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/second_section_screen.dart';

class TransFormYourSelfScreen extends StatefulWidget {
  const TransFormYourSelfScreen({Key key}) : super(key: key);

  @override
  State<TransFormYourSelfScreen> createState() =>
      _TransFormYourSelfScreenState();
}

class _TransFormYourSelfScreenState extends State<TransFormYourSelfScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: Image.asset(
                    'assets/images/weightchopper.png',
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Transform Yourself with all-in-one weight loss app. Expert guidance from a nutritionist, personal trainer, and therapist in your pocket.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: height * .03,
                          color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.2,
                          width: width * .5,
                          child: Image.asset(
                            'assets/images/man_gragh.png',
                          ),
                        ),
                        Container(
                          height: height * .1,
                          width: width * .25,
                          decoration: BoxDecoration(
                            color: const Color(0xffD7E2F1),
                            borderRadius: BorderRadius.circular(height * .02),
                          ),
                          child: Center(
                            child: Text(
                              '1X',
                              style: TextStyle(
                                  fontSize: height * .03, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          'your own',
                          style: TextStyle(
                              fontSize: height * .02, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: height * 0.2,
                          width: width * .15,
                          decoration: BoxDecoration(
                            color: const Color(0xffF4C2AB),
                            borderRadius: BorderRadius.circular(height * .02),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(height * .02),
                            child: Text(
                              '1X',
                              style: TextStyle(
                                  fontSize: height * .03, color: Colors.white),
                            ),
                          ),
                        ),
                        Text(
                          'Weight Loser',
                          style: TextStyle(
                              fontSize: height * .02, color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * .12,
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
                        "Next",
                        style: TextStyle(
                            fontSize: height * 0.024,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .04,
                ),
                Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  color: const Color(0xff434343),
                  child: Center(
                    child: Text(
                      "100X",
                      style: TextStyle(
                          fontSize: height * 0.024,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 900),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const SecondSectionScreen(),
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
