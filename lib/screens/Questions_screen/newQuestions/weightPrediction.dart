import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/yoyoEffect.dart';

class WeightPrediction extends StatefulWidget {
  const WeightPrediction({Key key}) : super(key: key);

  @override
  State<WeightPrediction> createState() => _WeightPredictionState();
}

class _WeightPredictionState extends State<WeightPrediction>
    with TickerProviderStateMixin {
  TooltipBehavior _tooltipBehaviour;
  int goalWeight;
  int currentWeight;
  int measureUnit;
  int days = 0;
  int weeks;
  String unit = 'LB';
  DateTime date = DateTime.now().add(const Duration(days: 200));
  DateTime goalDate;

  List<ChartData> chartData = <ChartData>[];

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 5000), () {
        _tooltipBehaviour.showByIndex(0, chartData.length - 1);
      });
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
      createWeightLossPredictor();
      Future<void>.delayed(const Duration(milliseconds: 6000), () {
        Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
          setState(() {
            date = date.subtract(const Duration(days: 7));
            _controller.forward(from: 1.0).then((value) {
              _controller.reverse();
            });
            if (date.isBefore(goalDate)) {
              date = goalDate;
              t.cancel();
            }
          });
        });
      });
    });
    super.initState();
    _tooltipBehaviour = TooltipBehavior(
      enable: true,
      shouldAlwaysShow: true,
      header: 'Goal',
      format: 'point.y',
      color: const Color(0xff6A78BE),
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
        );
      },
    );
    goalWeight = 145;
    currentWeight = 200;
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
    setState(() {
      goalDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      'WE STILL PREDICT YOU\'LL BE',
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '145 lb by ',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFC503A),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.translationValues(
                                  1.0, _animation.value * -20, 0.0),
                              child: child,
                            );
                          },
                          child: Text(
                            DateFormat("MMMM d").format(date),
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffFC503A),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(17),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.33,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                  labelAlignment: LabelAlignment.end,
                ),
                primaryYAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  minimum: goalWeight.toDouble(),
                  maximum: currentWeight.toDouble() + 5,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: GoogleFonts.openSans(
                    color: Colors.black54,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  labelAlignment: LabelAlignment.end,
                ),
                tooltipBehavior: _tooltipBehaviour,
                plotAreaBorderWidth: 0,
                palette: const [
                  Colors.transparent,
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
                    borderColor: const Color(0xff6A78BE),
                    borderWidth: 2,
                    animationDuration: 4000,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.white,
                      color: Color(0xffD95E00),
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Text(
              'Remember, we\'re adjusting your plan to help you lose the weight and maintain a healthy pace',
              style: GoogleFonts.openSans(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YoYoEffect(),
                  ),
                );
              },
              child: Text(
                'Next',
                style: GoogleFonts.openSans(fontSize: 19),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF573D),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
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
