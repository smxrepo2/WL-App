
import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/select_your_opinion_exercise.dart';


class ActiveGoalGraghScreen extends StatefulWidget {
  const ActiveGoalGraghScreen({Key key}) : super(key: key);

  @override
  State<ActiveGoalGraghScreen> createState() => _ActiveGoalGraghScreenState();
}

class _ActiveGoalGraghScreenState extends State<ActiveGoalGraghScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  int widgetIndex = 0;
    Widget child;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      setState(() {
        widgetIndex = 1;
      });
    });
  }

  ///assets/LottieCalendar.json
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    if(widgetIndex==1){
      child = AnimatedContainer(
        duration: const Duration(microseconds: 300,

        ),
        curve: Curves.linear,
        child: Padding(
              padding:const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),

                        )),
                    height: height*0.04,
                    width: width,
                    child: FittedBox(child: Center(child: Text('Feb',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: height*0.02),))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height*0.02),
                        bottomRight: Radius.circular(height*0.02),
                      ),
                      color: Colors.white,
                        boxShadow: [
                          BoxShadow(

                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                       ),
                    height: height*0.14,
                    width: width,
                    child: Center(child: FittedBox(child: Text('18',style: TextStyle(fontWeight:FontWeight.bold,fontSize: height*0.3),))),)
                ],
              ),
            ),
      );
    }else if(widgetIndex == 0){
    child = Image.asset("assets/cal.gif");

    }
    print(child.toString());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                ///this is the two widget for display lbs and calendar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54)),
                      height: height * 0.2,
                      width: width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                              child: Text(
                            '90 Lbs',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.04,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          FittedBox(
                              child: Text(
                            'Target Weight',
                            style: TextStyle(
                                color: Colors.white, fontSize: height * 0.02),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      // decoration: BoxDecoration(
                      //     color: Colors.black54,
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(color: Colors.black54)),
                      height: height * 0.2,
                      width: width * 0.4,
                      child:child
                    ),
                  ],
                ),
              ),
              FittedBox(
                  child: Text(
                'After Analyzing your profile we',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: height * 0.03,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: height * 0.05,
              ),
              FittedBox(
                  child: Text(
                'Active Goal Graph',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: height * 0.03,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                      child: Text(
                    'Starts with Our app',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: height * 0.35,
                    width: width,
                    child: LineChart(LineChartData(
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.transparent),
                        ),
                        gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                  color: Colors.white, strokeWidth: 1);
                            }),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                          )),
                        ),
                        maxX: 8,
                        maxY: 8,
                        minX: 0,
                        minY: 0,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 5),
                              const FlSpot(5, 5),
                              const FlSpot(7, 6),
                              const FlSpot(8, 4),
                            ],
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 5,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.redAccent.withOpacity(0.2),
                            ),
                          ),
                        ]))),
              ),
              SizedBox(
                height: height * 0.03,
              ),

              ///this is the container black button
              InkWell(
                onTap: (){

                  Navigator.push(context,MaterialPageRoute(builder:  (context) => const SelectYourOpinionExerciseScreen   (),));
                },
                child: Container(
                  height: height * 0.065,
                  width: width / 2,
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.025),
                  )),
                ),
              ),

              ///here is the end of container
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                  height: height * 0.04,
                  width: width * 0.8,
                  color: Colors.black26,
                  child: Row(
                    children: [
                      Container(
                        color: Colors.black,
                        width: width * 0.02,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
 