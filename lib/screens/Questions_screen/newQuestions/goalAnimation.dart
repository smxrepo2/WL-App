import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Model/SignupBody.dart';
import '../../../Provider/UserDataProvider.dart';
import '../../screentext/methods/widgets.dart';
import '../../screentext/screens/comparison.dart';
import '../models/all_questions_model.dart';
import 'dob.dart';

class GoalAnimation extends StatefulWidget {
  SignUpBody signupBody;
  GetAllQuestionsModel questionsModel;
  GoalAnimation(
      {Key key, @required this.signupBody, @required this.questionsModel})
      : super(key: key);

  @override
  State<GoalAnimation> createState() => _GoalAnimationState();
}

class _GoalAnimationState extends State<GoalAnimation> {
  TooltipBehavior _tooltipBehaviour;
  int goalWeight;
  int currentWeight;
  int measureUnit;
  int days = 0;
  int weeks;
  String unit;

  List<ChartData> chartData = <ChartData>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 5000), () {
        _tooltipBehaviour.showByIndex(0, chartData.length - 1);
      });
    });
    super.initState();
    _tooltipBehaviour = TooltipBehavior(
      enable: true,
      shouldAlwaysShow: true,
      header: 'Goal',
      format: 'point.y',
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          padding: const EdgeInsets.all(5),
          width: 60,
          height: 45,
          child: Center(
            child: Column(
              children: [
                Text(
                  'Goal',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${point.y} $unit',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
    goalWeight = widget.signupBody.dietQuestions.goalWeight;
    currentWeight = widget.signupBody.dietQuestions.currentWeight;
    createWeightLossPredictor();
    if (widget.signupBody.dietQuestions.weightUnit != null) {
      var user = Provider.of<UserDataProvider>(context, listen: false);

      var currentWeight = 0;
      var weightUnit = "";

      if (widget.signupBody.dietQuestions != null) {
        // currentWeight=widget.signupBody.dietQuestions.currentWeight;
        if (widget.signupBody.dietQuestions.currentWeight != null) {
          currentWeight = widget.signupBody.dietQuestions.currentWeight;
          weightUnit = widget.signupBody.dietQuestions.weightUnit;
        } else {
          currentWeight = user.userData.profileVM.currentweight;
          weightUnit = user.userData.profileVM.weightUnit;
        }
      } else {
        currentWeight = user.userData.profileVM.currentweight;
        weightUnit = user.userData.profileVM.weightUnit;
      }

      //currentWeight = widget.signUpBody.dietQuestions.currentWeight;
      // if (widget.signUpBody.dietQuestions.weightUnit == "kg") {
      double lossRate = 2.0;
      if (weightUnit == "kg") {
        measureUnit = 0;
        unit = "KG";
        lossRate = 2 / 2.205;
      } else {
        measureUnit = 1;
        unit = "Lb's";
      }
      int temp = goalWeight;
      for (int i = goalWeight; i < currentWeight; i += 7) {
        temp = temp - lossRate.toInt();
        days += 7;
      }
    }
    super.initState();
  }

  void createWeightLossPredictor() {
    int current = currentWeight;
    DateTime date = DateTime.now();
    while (current > goalWeight) {
      // random value between 0 and 2
      final int randomValue = Random().nextInt(5) + 1;
      chartData.add(ChartData(DateFormat("MMM d").format(date), current));
      current = current - randomValue;
      date = date.add(const Duration(days: 7));
    }
    chartData.add(ChartData(DateFormat("MMM d").format(date), goalWeight));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textContainer(
                  text1: '${widget.signupBody.dietQuestions.goalWeight} $unit',
                  text2: 'Target Weight'),
              textContainer(text1: '$days Days', text2: 'Days'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 0.4,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10), // if you need this
              //   side: BorderSide(
              //     color: Colors.grey.withOpacity(1),
              //     width: .5,
              //   ),
              // ),
              child: SizedBox(
                width: double.infinity,
                height: 170,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'How you\'ll reach at goal weight',
                        style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize: 11,
                            fontWeight: FontWeight.w600
                            // fontWeight: FontWeight.w500
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            labelStyle: GoogleFonts.openSans(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                                // fontWeight: FontWeight.w500
                                ),
                            labelAlignment: LabelAlignment.end,
                          ),
                          primaryYAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                            minimum: 90,
                            maximum: currentWeight + 50.0,
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            labelStyle: GoogleFonts.openSans(
                                color: Colors.black54,
                                fontSize: 11,
                                fontWeight: FontWeight.w600
                                // fontWeight: FontWeight.w500
                                ),
                            labelAlignment: LabelAlignment.end,
                          ),
                          tooltipBehavior: _tooltipBehaviour,
                          plotAreaBorderWidth: 0,
                          palette: [
                            Colors.red.withOpacity(0.1),
                          ],
                          onMarkerRender: (MarkerRenderArgs args) {
                            if (args.pointIndex != chartData.length - 1) {
                              args.markerHeight = 0;
                              args.markerWidth = 0;
                            }
                          },
                          series: <ChartSeries>[
                            SplineAreaSeries<ChartData, String>(
                              enableTooltip: true,
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              borderColor: Colors.redAccent,
                              borderWidth: 3,
                              animationDuration: 4000,
                              markerSettings: const MarkerSettings(
                                isVisible: true,
                                shape: DataMarkerType.circle,
                                borderWidth: 2,
                                borderColor: Colors.white,
                                color: Colors.green,
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const ComparisonChart(),
          const SizedBox(height: 10),
          const Text(
            'Weight Loser plan prepare you with healthy habits and cognitive behavioral changes. Not that plain old fad diet plan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DOBQestion(
                                questionsModel: widget.questionsModel,
                                signupBody: widget.signupBody,
                              )));
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}
