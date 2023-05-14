import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weight_loser/Component/DDText.dart';

import '../../../utils/ColorConfig.dart';

class ConcaveGraph extends StatefulWidget {
  const ConcaveGraph(
      {Key key,
      this.currentWeight,
      this.weeks,
      this.days,
      this.measureUnit,
      this.weightDifference})
      : super(key: key);
  final int currentWeight;
  final int weightDifference;
  final int weeks;
  final int measureUnit;
  final int days;
  @override
  State<ConcaveGraph> createState() => _ConcaveGraphState();
}

class _ConcaveGraphState extends State<ConcaveGraph> {
  List<ChartData> chartData = [];
  double currentWeight;
  List<String> months = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  var month;
  /*
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      animationDuration: 5000,

      animateAxis: true,
      animateRange: true,
      //showTicks: true,
      /*
      barPointers: [
        LinearBarPointer(
          value: 100,
          enableAnimation: true,
        )
      ],
      */

      ranges: [
        LinearGaugeRange(
            startValue: 0,
            midValue: 50,
            endValue: 100,
            startWidth: 80,
            color: Colors.red.shade300,
            midWidth: 20,
            endWidth: 10,
            rangeShapeType: LinearRangeShapeType.curve),
      ],
    );
  }
}
*/
  int totalMonths;
  int daysCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    daysCount = widget.days;
    currentWeight = widget.currentWeight.toDouble();
    DateTime now = DateTime.now();

    totalMonths = (widget.days / 30).ceil();
    print("Total Months:$totalMonths");
    int currentMonth = now.month;
    String label = '';
    month = months[currentMonth - 1];
    print("current Month:$month");
    int currentMonthdays = (30 - now.day).abs();
    if (totalMonths == 0) {
      label = '';
    }
    daysCount = daysCount - currentMonthdays;
    print("current Month and weight loss days: $currentMonthdays - $daysCount");
    double currentMonthLoss;
    if (widget.measureUnit == 1)
      currentMonthLoss = currentMonthdays * 0.14;
    else
      currentMonthLoss = currentMonthdays * 0.065;
    chartData.add(ChartData(month, currentWeight - currentMonthLoss, label,
        widget.weightDifference));
    currentWeight = currentWeight - currentMonthLoss;
    print("weight after current month loss:$currentWeight");
    for (int i = 0; i < totalMonths; i++) {
      if (daysCount > 0) {
        double weightloss = 0;
        if (currentMonth > 11) currentMonth = 0;
        month = months[currentMonth];
        print("month inside loop:$month");
        if (widget.measureUnit == 0) {
          if (daysCount >= 30) {
            weightloss = 30 * 0.065;
            daysCount = daysCount - 30;
          } else {
            weightloss = daysCount * 0.065;
            daysCount = 0;
          }
          if (totalMonths - i == 1) {
            print("label true");
            label = 'Goal ${widget.weightDifference} Kg';
          }

          chartData.add(ChartData(month, (currentWeight - weightloss), label,
              widget.weightDifference));

          currentWeight = currentWeight - weightloss;
          print("$currentWeight - $i");
        } else {
          if (daysCount >= 30) {
            weightloss = 30 * 0.14;
            daysCount = daysCount - 30;
          } else {
            weightloss = daysCount * 0.14;
            daysCount = 0;
          }
          if (totalMonths - i == 1) {
            print("true");
            label = 'Goal ${widget.weightDifference} lbs';
          }
          chartData.add(ChartData(month, (currentWeight - weightloss), label,
              widget.weightDifference));
          print("month:$month");

          currentWeight = currentWeight - weightloss;
        }
      }
      //daysCount = daysCount - 30;
      currentMonth = currentMonth + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(
                      labelPlacement: LabelPlacement.onTicks,
                    ),
                    primaryYAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        axisLine: const AxisLine(width: 0),
                        minimum: widget.weightDifference.toDouble(),
                        interval: 1),
                    series: <ChartSeries<ChartData, String>>[
          SplineAreaSeries<ChartData, String>(
              color: Colors.red.shade300,
              animationDuration: 2500,
              dataSource: chartData,

              /*
              <ChartData>[
                ChartData(1, widget.currentWeight.toDouble()),
                ChartData(2, widget.currentWeight.toDouble() - 20),
                ChartData(3, widget.currentWeight.toDouble() - 30),
                ChartData(4, widget.currentWeight.toDouble() - 35),
              ],
              */
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  //alignment: ChartAlignment.center,
                  labelAlignment: ChartDataLabelAlignment.auto,
                  textStyle: GoogleFonts.openSans(
                    fontSize: 10,
                    color: ColorConfig().terColor,
                    fontWeight: FontWeight.w400,
                    //textStyle: TextStyle(overflow: TextOverflow.visible)
                  )),
              dataLabelMapper: (data, _) => data.z,
              enableTooltip: true,
              splineType: SplineType.monotonic,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y)
        ]))));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z, this.low);
  final String x;
  final double y;
  final String z;
  final int low;
}
