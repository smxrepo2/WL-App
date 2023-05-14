import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/weightPrediction.dart';

class YoYoEffect extends StatefulWidget {
  const YoYoEffect({Key key}) : super(key: key);

  @override
  State<YoYoEffect> createState() => _YoYoEffectState();
}

class _YoYoEffectState extends State<YoYoEffect> {
  List<ChartData> chartData = <ChartData>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 5000), () {
        setState(() {});
      });
    });
    // add data to the list by yoyo effect
    for (int i = 0; i < 3; i++) {
      chartData.add(ChartData('1$i', 110));
      chartData.add(ChartData('2$i', 105));
      chartData.add(ChartData('3$i', 90));
      chartData.add(ChartData('4$i', 80));
      chartData.add(ChartData('5$i', 80));
      chartData.add(ChartData('6$i', 90));
      chartData.add(ChartData('7$i', 105));
    }
    chartData.add(ChartData('1', 110));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Text(
          //       'Dieting',
          //       style: GoogleFonts.openSans(
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //     Text(
          //       'After Diet',
          //       style: GoogleFonts.openSans(
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Weight',
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.grey.withOpacity(0.1),
                            width: MediaQuery.of(context).size.width * 0.12,
                            margin: EdgeInsets.only(
                              top: 15,
                              bottom: 10,
                              left: 10,
                              right: MediaQuery.of(context).size.width * 0.12,
                            ),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.1),
                            width: MediaQuery.of(context).size.width * 0.12,
                            margin: EdgeInsets.only(
                              top: 15,
                              bottom: 10,
                              right: MediaQuery.of(context).size.width * 0.12,
                            ),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.1),
                            width: MediaQuery.of(context).size.width * 0.12,
                            margin: const EdgeInsets.only(
                              top: 15,
                              bottom: 10,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            axisLine: const AxisLine(width: 0),
                            labelStyle: GoogleFonts.openSans(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                          primaryYAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 2),
                            majorTickLines: const MajorTickLines(size: 0),
                            desiredIntervals: 5,
                            axisLine: const AxisLine(width: 0),
                            minimum: 70,
                            maximum: 120,
                            labelStyle: GoogleFonts.openSans(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                          plotAreaBorderWidth: 0,
                          palette: const [
                            Colors.transparent,
                          ],
                          onMarkerRender: (MarkerRenderArgs args) {
                            // get y value of the marker
                            final int yValue = chartData[args.pointIndex].y;
                            if (yValue != 110 && yValue != 90) {
                              args.markerHeight = 0;
                              args.markerWidth = 0;
                            }
                          },
                          onDataLabelRender: (DataLabelRenderArgs args) {
                            if (args.pointIndex == chartData.length - 2) {
                              args.text = 'GAIN IT BACK';
                              args.offset = const Offset(-15, 15);
                            } else if (args.pointIndex == 2) {
                              args.text = 'LOOSE WEIGHT';
                              args.offset = const Offset(15, -40);
                            } else {
                              args.text = '';
                            }
                          },
                          series: <ChartSeries>[
                            SplineAreaSeries<ChartData, String>(
                              enableTooltip: true,
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              borderColor: const Color(0xffF9A300),
                              borderWidth: 2,
                              animationDuration: 5000,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              markerSettings: const MarkerSettings(
                                isVisible: true,
                                shape: DataMarkerType.circle,
                                borderWidth: 1,
                                borderColor: Colors.white,
                                color: Color(0xffF9A300),
                                width: 8,
                                height: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black.withOpacity(0.75),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            child: Row(
              children: ['Jan', 'Mar', 'May', 'Jul']
                  .map((e) => Expanded(
                        child: Center(
                          child: Text(
                            e,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.33),
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Dieting',
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.33),
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'After Dieting',
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey.withOpacity(0.33),
            thickness: 1,
            indent: 50,
            endIndent: 50,
            height: 40,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Restrictive diets often fail, creating a "yo-yo" effect',
              style: GoogleFonts.openSans(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Traditional restrictive diets can help you lose weight in short bursts (aka the"yo-yo" effect  ),but ultimately don\'t help you keep the weight off.',
              style: GoogleFonts.openSans(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Weight Loser can help you create long-term results through habit and behavior change, not restrictive dieting.',
              style: GoogleFonts.openSans(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightPrediction(),
                ),
              );
            },
            child: Text(
              'Next',
              style: GoogleFonts.openSans(fontSize: 19),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF573D),
              padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
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
