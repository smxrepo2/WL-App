import 'package:flutter/material.dart';

import 'goal_graph_screen.dart';

class PresentMedicalCondition extends StatefulWidget {
  const PresentMedicalCondition({Key key}) : super(key: key);

  @override
  State<PresentMedicalCondition> createState() =>
      _PresentMedicalConditionState();
}

class _PresentMedicalConditionState extends State<PresentMedicalCondition> {
  bool check = true;

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
              height: height * .1,
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
            ///this is the stack container........
            height: height * 0.3,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Select your present medical\n condition if any ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.03),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                    )),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.04,
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
                        padding: const EdgeInsets.all(8.0),
                        child: check
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  const Text('High Blood Pressure',
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
                        padding: const EdgeInsets.all(8.0),
                        child: check
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  const Text('Heart Diseas or strok',
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
                        padding: const EdgeInsets.all(8.0),
                        child: check
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  const Text('Diabtes',
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
                        padding: const EdgeInsets.all(8.0),
                        child: check
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  const Text('Kediny Disease',
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
                        padding: const EdgeInsets.all(8.0),
                        child: check
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  const Text('None',
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
                ],
              ),
            ),
          )),

          ///this is the third Container ........3

          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const goal_Graph_Screen(),
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
    )));
  }
}
