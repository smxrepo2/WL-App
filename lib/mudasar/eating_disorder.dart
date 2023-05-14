import 'package:flutter/material.dart';

import 'diet_is_the_foundation_screen.dart';
import 'present_medical_condition_screen.dart';

class EatingDisorder extends StatefulWidget {
  const EatingDisorder({Key key}) : super(key: key);

  @override
  State<EatingDisorder> createState() => _EatingDisorderState();
}

class _EatingDisorderState extends State<EatingDisorder> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: height,
      width: width,
      child: Column(
        children: [
          SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Biology',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Diet',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Excersie',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mind',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sleep/Habit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.01,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            ///this is the stack container........
            height: height * 0.3,
            width: width,
            child: Stack(
              children: [
                Container(
                  height: height * 0.2,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(215, 226, 241, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Center(
                    child: Text(
                      'Let us understand your profile ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.025),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.13,
                  left: height * 0.04,
                  child: Container(
                    height: height * 0.17,
                    width: width * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            " Do you have an active diagnosis \n of an eating disorder (e.g. bulimia\n, anorexia,or similar diagnosis)?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.023),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ],
            ),
          ),

          ///this is the third Container ........3
          SizedBox(
            height: height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .06),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DietIsTheFoundationScreen(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: check ? Colors.white : Colors.lightBlue,
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.02)),
                        border: Border.all(color: Colors.black)),
                    height: height * 0.068,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: check
                          ? Row(
                              children: [
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                const Text('Yes',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.verified),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      check = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: check ? Colors.white : Colors.lightBlue,
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.02)),
                        border: Border.all(color: Colors.black)),
                    height: height * 0.068,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: check
                          ? Row(
                              children: [
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                const Text('No',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.verified),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  'Understood. Regrettably, Weight Loser current structure does not cater to individuals with an ongoing eating disorder.',
                  style: TextStyle(
                      fontSize: height * .026, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'We recommend seeking the advice of a therapist and/or physician for support with your diagnosis.',
                  style: TextStyle(
                      fontSize: height * .026, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.01,
                      width: width / 2,
                      child: LinearProgressIndicator(
                        minHeight: height * 0.02,
                        color: Colors.black,
                        backgroundColor: Colors.black38,
                        value: 0.1,
                      ),
                    ),
                    Text('03 % Completed'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
