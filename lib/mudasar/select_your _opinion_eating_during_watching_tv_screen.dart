import 'package:flutter/material.dart';

class SelectYourOpinionEatingDuringWatchingTV extends StatefulWidget {
  const SelectYourOpinionEatingDuringWatchingTV({Key key}) : super(key: key);

  @override
  State<SelectYourOpinionEatingDuringWatchingTV> createState() =>
      _SelectYourOpinionEatingDuringWatchingTVState();
}

class _SelectYourOpinionEatingDuringWatchingTVState
    extends State<SelectYourOpinionEatingDuringWatchingTV> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                          color: Color.fromRGBO(244, 194, 171, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Let us understand your Mind Profile ',
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
                          height: height * 0.16,
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
                                    "Select your opinion on eating",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.04),
                                  ),
                                )),
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "during watching TV or Mobile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.028),
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

                    ///these are the text form fields
                  ],
                ),
              ),

              ///here is the start of the containers....................
              /// this is the first conatainer ......1
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.02)),
                        border: Border.all(color: Colors.black)),
                    height: height * 0.078,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          FittedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "I eat more than normal when i am\nwatching Tv or Mobile",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

              ///this is the second Container 2
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.02)),
                        border: Border.all(color: Colors.black)),
                    height: height * 0.078,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          FittedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "I eat more than normal when i am\nwatching Tv or Mobile",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

              ///this is the third Container ........3
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(height * 0.02)),
                        border: Border.all(color: Colors.black)),
                    height: height * 0.078,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          FittedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "I do not know",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: height * 0.065,
              ),
              Container(
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
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height * 0.01,
                    width: width / 2,
                    child: LinearProgressIndicator(
                      minHeight: height * 0.02,
                      color: const Color.fromARGB(255, 27, 25, 25),
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
