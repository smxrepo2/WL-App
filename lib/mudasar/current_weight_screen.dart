import 'package:flutter/material.dart';

import '../screens/Questions_screen/used-Questions/curent_height.dart';

class HieghtScreen extends StatefulWidget {
  const HieghtScreen({Key key}) : super(key: key);

  @override
  State<HieghtScreen> createState() => _HieghtScreenState();
}

class _HieghtScreenState extends State<HieghtScreen> {
  bool check = true;

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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        color: Color(0xffD7E2F1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Center(
                      child: Text(
                        'Let us understand your Profile',
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please Select Your Height",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      )),

                  ///these are the text form fields
                ],
              ),
            ),
            SizedBox(height: height*0.1,),
            Container(
              height: height * 0.1,
              width: width * 0.5,
               decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.1),

                   blurRadius: 1,
                   offset: const Offset(0, 3), // changes position of shadow
                 ),
               ],
               ),
              child: Column(
                children: [
                  SizedBox(height: height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:   [
                      const Text(
                        '4',
                        style: TextStyle(fontSize: 45),
                      ),
                      const Text('Ft'),
                     Container(
                       width: width*0.006,
                       height: height*0.06,color: Colors.black12,),
                      const Text(
                        '7',
                        style: TextStyle(fontSize: 45),
                      ),
                      const Text('in'),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            SizedBox(
              width: width * 0.6,
              height: height * 0.01,
              child: Slider(
                thumbColor: Colors.black,
                inactiveColor: Colors.black,
                value: 0.6,
                max: 100,
                min: 0,
                onChanged: (double value) {},
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const select_current_weight(),));
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
            // lınear progress ındıcators
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
      )),
    );
  }
}
