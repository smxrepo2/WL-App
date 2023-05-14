import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/screens/navigation_tabs/ExerciseSceen.dart';

class RunningTabInnerPage extends StatefulWidget {
  const RunningTabInnerPage({Key key}) : super(key: key);

  @override
  _RunningTabInnerPageState createState() => _RunningTabInnerPageState();
}

class _RunningTabInnerPageState extends State<RunningTabInnerPage> {
  List<bool> days = [false, false, false, false, false, false, false];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double margin = height * 0.02;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: height * 0.25,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/bannar.png',
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Get Up Go Up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(margin, margin, 0, 0),
              child: Text(
                "Days",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            daysRowUpdated(margin, height),
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.fromLTRB(margin, 10, margin, margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Set 1",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      "2 Reps",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.fromLTRB(margin, 0, margin, margin),
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ExerciseScreen([], 0));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         ExerciseScreen([],0),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                  height: height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/1.png',
                                          ))),
                                ),
                              ),
                              Container(
                                  height: height * 0.12,
                                  width: MediaQuery.of(context).size.width -
                                      (MediaQuery.of(context).size.width * 0.3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Walk",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "10 minutes",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "200 kcal",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: Colors.blue,
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.3,
                          )
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Container daysRowUpdated(double margin, double height) {
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < days.length; i++) {
                    setState(() {
                      days[i] = false;
                    });
                  }
                  setState(() {
                    days[0] = true;
                  });
                },
                child: dayNumberUpdated(height, "1", 0),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[1] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "2", 1)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[2] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "3", 2)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[3] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "4", 3)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[4] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "5", 4)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[5] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "6", 5)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[6] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "7", 6)),
            ),
          ],
        ));
  }

  Container dayNumberUpdated(double height, number, index) {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size4,
        bottom: MySize.size4,
      ),
      // padding: EdgeInsets.fromLTRB(height * 0.001,
      //     height * 0.018, height * 0.002, height * 0.015),
      margin: EdgeInsets.only(
        right: height * 0.025,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: days[index] ? selectedBgColor : unSelectedBgColor),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DDText(
              title: "Day",
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
            DDText(
              title: number,
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
