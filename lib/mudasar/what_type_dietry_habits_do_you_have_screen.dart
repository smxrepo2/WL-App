import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/select_your_daily_normal_daily_waterIntake_screen.dart';

class WhatTypeDietryHabitsDoYouHave extends StatefulWidget {
  const WhatTypeDietryHabitsDoYouHave({Key key}) : super(key: key);

  @override
  State<WhatTypeDietryHabitsDoYouHave> createState() =>
      _WhatTypeDietryHabitsDoYouHaveState();
}

class _WhatTypeDietryHabitsDoYouHaveState
    extends State<WhatTypeDietryHabitsDoYouHave> {
  @override
  Widget build(BuildContext context) {
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
                height: height * 0.25,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.15,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 197, 196, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Let us Understand Your Dieting Habbits ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.02),
                        ),
                      ),
                    ),
                    Positioned(
                        top: height * 0.10,
                        left: height * 0.04,
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "What Type of Dietry habits do",
                                    style: TextStyle(fontSize: height * 0.04),
                                  ),
                                )),
                                FittedBox(
                                    child: Text(
                                  "you have",
                                  style: TextStyle(fontSize: height * 0.032),
                                )),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                        )),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,

                    ///this is the lenght of the item which you want to display
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(height * 0.03),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.01,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(
                                  2.0,
                                  2.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: .01,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(
                                  -2.0,
                                  -2.0,
                                ),
                                blurRadius: 1,
                                spreadRadius: .01,
                              ), //BoxSh//BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// this is image section
                              SizedBox(
                                height: 80,
                                width: 100,
                                child: Image.asset(
                                    'assets/images/cheken_item_image.png'),
                              ),
                              Divider(
                                  height: height * .02,
                                  color: Colors.black12,
                                  thickness: 1),
                              const Center(
                                child: Text(
                                  'Biryani',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SelectYourDailyNormalDailyWaterIntakeScreen(),
                      ));
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
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height * 0.01,
                    width: width / 2,
                    child: LinearProgressIndicator(
                      minHeight: height * 0.02,
                      color: Colors.black87,
                      value: 1.6,
                    ),
                  ),
                  const Text('60 % Completed'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          elevation: 20,
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.05,
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                            /// this is image section
                                SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset('assets/images/cheken_item_image.png'),),


                                ///this is under area of card
                                Container(
                                  height: height * 0.003,
                                  width: width,
                                  color: Colors.black38,

                                  ///here is the name of the item
                                ),
                                SizedBox(height: height * 0.01),
                                Center(
                                  child: Text(
                                    'Biryani',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );*/
