import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class Timer_Screen extends StatefulWidget {
  const Timer_Screen({Key key}) : super(key: key);

  @override
  State<Timer_Screen> createState() => _Timer_ScreenState();
}

class _Timer_ScreenState extends State<Timer_Screen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Losing Weight ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'has never been easier\njoin us today and see the difference',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// here is the card widget in which the date is mention 17 augest 2023
              Card(
                elevation: 8,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: SizedBox(
                  height: height * 0.1,
                  width: width * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "You're going to loss your weight by",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text(
                        "17 August 2023",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              /// this is the container in which i will show the totel bill of the user like 19.99$
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  height: height * 0.09,
                  width: width,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Your total bill for 90 days plan',
                              style: TextStyle(fontSize: 22),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Cancel up to 24 hours before trial ends',
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      const Text(
                        "\$ 19.99",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FittedBox(
                      child: Text(
                    "I would rather take a trial ->",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const FittedBox(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Weight Loser commited to our users , "
                        "if you don't loss\nyour weight your plan will "
                        "be extended with no cost.",
                        style: TextStyle(fontSize: 16),
                      ))),
              SizedBox(
                height: height * 0.1,
              ),
              const Text(
                'Grab this offer with in ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: height * 0.08,
                width: width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: TimerCountdown(
                    timeTextStyle: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    colonsTextStyle: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    format: CountDownTimerFormat.daysHoursMinutesSeconds,
                    endTime: DateTime.now().add(
                      const Duration(
                        days: 1,
                        hours: 14,
                        minutes: 27,
                        seconds: 34,
                      ),
                    ),
                    onEnd: () {
                      print("Timer finished");
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              InkWell(
                onTap: () {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: height*0.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Text('Pay what you think is fair ',style: TextStyle(fontSize: height*0.03),),

                  SizedBox(
                    height: height*0.18,
                    child: Stack(
                      children: [
                        Positioned(
                          height: height*0.1,
                          width: width*0.9,
                          top: height*0.04,
                          left: width*0.04,
                          child: Container(
                             decoration: BoxDecoration(border: Border.all(color: Colors.black),
                                 borderRadius: const BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("\$ 7",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Lower',style: TextStyle(fontWeight: FontWeight.bold),),
                                    SizedBox(
                                        height: height*0.01,
                                        child: Padding(
                                          padding:   const EdgeInsets.all(8.0),
                                          child: Slider(value: 0.4, onChanged: (value){}),
                                        )),
                                    const Text('Higher',style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        ///ya uper wala container ha jo mana lagya hua ha.....
                        Positioned(
                          height: height*0.05,
                          width: width/2,
                          top: 10,
                          left: width*0.25,
                          child: Container(
                            height: 200,
                           decoration: BoxDecoration(
                             color: Colors.white,
                               border: Border.all(color: Colors.black),
                              borderRadius: const BorderRadius.all(Radius.circular(40))),
                            child: const Padding(
                              padding:   EdgeInsets.all(10),
                              child: FittedBox(child: Text('Most People Pick \$7',style: TextStyle(fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///this is the last button on bottom sheet
                  Container(
                    height: height*0.04,
                    width: width/2,
                    color: Colors.black12,
                  child: const FittedBox(

                      child: Center(child: Padding(
                        padding:   EdgeInsets.all(8.0),
                        child: Text("7 days trial, cancel anytime",style: TextStyle(fontWeight: FontWeight.bold),),
                      ))),),
                ],
              ),
            ),
          );
        },
      );

      ///here is the end of the conatiner
                },
                child: Container(
                  height: height * 0.05,
                  width: width / 2,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                      child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}