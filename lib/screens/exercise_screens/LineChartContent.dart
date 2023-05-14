import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_line_chart/simple_line_chart.dart';

class LineChartContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LineChartContentState();
  }
}

class _LineChartContentState extends State<LineChartContent> {
  LineChartData data;

  @override
  void initState() {
    super.initState();

    // create a data model
    data = LineChartData(datasets: [
      // Dataset(
      //   label: '',
      //   dataPoints: _createDataPoints(offsetInDegrees: 90),
      // ),
      Dataset(label: '', dataPoints: _createDataPoints(offsetInDegrees: 0)),
      // Dataset(label: '', dataPoints: _createDataPoints(offsetInDegrees: 90))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: LineChart(
          // chart is styled
          style: LineChartStyle.fromTheme(context),
          seriesHeight: 300,
          // chart has data
          data: data,
        ),
      )
    ]);
  }
}

// data points are created on a sine curve here,
// but you can plot any data you like
int ycounter = 0;
int xcounter = 0;
List<DataPoint> _createDataPoints({int offsetInDegrees}) {
  List<DataPoint> dataPoints = [];
  // final degreesToRadians = (pi / 180);
  for (int x = 0; x < 40; x += 20) {
    // final di = (x * 2).toDouble() * degreesToRadians;
    dataPoints.add(DataPoint(x: 0.0 + xcounter, y: 76.0 + ycounter));
    ycounter = ycounter + 4;
    xcounter = xcounter + 2;
  }
  return dataPoints;
}
