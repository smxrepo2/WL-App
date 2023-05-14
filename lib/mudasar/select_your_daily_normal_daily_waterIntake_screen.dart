import 'package:flutter/material.dart';

import 'active_goal_gragh_screen.dart';

class SelectYourDailyNormalDailyWaterIntakeScreen extends StatefulWidget {
  const SelectYourDailyNormalDailyWaterIntakeScreen({Key key})
      : super(key: key);

  @override
  State<SelectYourDailyNormalDailyWaterIntakeScreen> createState() =>
      _SelectYourDailyNormalDailyWaterIntakeScreenState();
}

class _SelectYourDailyNormalDailyWaterIntakeScreenState
    extends State<SelectYourDailyNormalDailyWaterIntakeScreen> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    print(check);
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Biology',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
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
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Diet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
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
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Excersie',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
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
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Mind',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
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
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sleep/Habit',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
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
              SizedBox(
                height: height * 0.3,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(227, 194, 247, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Let us Understand Your Profile ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.02),
                        ),
                      ),
                    ),
                    Positioned(
                        top: height * 0.13,
                        left: height * 0.04,
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Select your Daily Normal\n daily water intake",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.04),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .045),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * .065,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .02),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                              SizedBox(
                                width: width * .02,
                              ),
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                              SizedBox(
                                width: width * .02,
                              ),
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                              SizedBox(
                                width: width * .02,
                              ),
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                            ],
                          ),
                          const Text('More than Eight Glasses')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    Container(
                      height: height * .065,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .02),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                              SizedBox(
                                width: width * .02,
                              ),
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                              SizedBox(
                                width: width * .02,
                              ),
                              SizedBox(
                                height: height * .036,
                                width: width * .031,
                                child:
                                    Image.asset('assets/images/glass_icon.png'),
                              ),
                            ],
                          ),
                          const Text('More than Eight Glasses')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    Container(
                      height: height * .065,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .02),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('?'),
                          Text('Do not Count'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.09,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                  const ActiveGoalGraghScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.07,
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
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                          width: width / 2,
                          child: LinearProgressIndicator(
                            minHeight: height * 0.02,
                            color: Colors.black,
                            value: 1.6,
                          ),
                        ),
                        const Text('60 % Completed'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
