import 'package:flutter/material.dart';

import '../../../mudasar/target_weight_screen.dart';

class select_current_weight extends StatefulWidget {
  const select_current_weight({Key key}) : super(key: key);

  @override
  State<select_current_weight> createState() => _select_current_weightState();
}

class _select_current_weightState extends State<select_current_weight> {
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
                ///this is the stack container........
                height: height * 0.33,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(215, 226, 241, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Select your current height',
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
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Select your current Height",
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                        )),
                  ],
                ),
              ),

              ///this is the first two button which indicate the lbs adn kg
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.05,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          color: Colors.grey,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: const Center(
                          child: FittedBox(
                              child: Text(
                        'Lbs',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ))),
                    ),
                    Container(
                      height: height,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: const Center(
                          child: FittedBox(
                              child: Text(
                        'Kg',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ))),
                    ),
                  ],
                ),
              ),

              ///this is the /
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Container(
                  height: height * 0.2,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    '120 Lbs',
                    style: TextStyle(
                        fontSize: height * 0.04, fontWeight: FontWeight.w400),
                  )),
                ),
              ),

              ///this is the third Container ........3
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Slider(
                  value: 0.3,
                  onChanged: (value) {},
                  inactiveColor: Colors.black26,
                  activeColor: Colors.black,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                'Recommended Weight range is 82 lbg to - 108 lbg',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              // Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius:
              //               BorderRadius.all(Radius.circular(height * 0.02)),
              //           border: Border.all(color: Colors.black)),
              //       height: height * 0.078,
              //       child: Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             FittedBox(
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 15),
              //                 child: Text(
              //                   "I do not know",
              //                   style: TextStyle(
              //                       fontSize: 16, fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     )),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectYourTargetWeight(),
                    ),
                  );
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
                      color: Colors.black,
                      backgroundColor: Colors.black38,
                      value: 0.1,
                    ),
                  ),
                  const Text('03 % Completed'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
