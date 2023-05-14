import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComparisonChart extends StatefulWidget {
  const ComparisonChart({Key key}) : super(key: key);

  @override
  State<ComparisonChart> createState() => _ComparisonChartState();
}

class _ComparisonChartState extends State<ComparisonChart> {
  List<ChartData> chartData = [];
  List<ChartData> chartData2 = [];
  List<ChartData> chartData3 = [];

  DateTime now = DateTime.now();

  @override
  void initState() {
    chartData.add(ChartData(DateFormat('MMM').format(now), 900));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 30))), 600));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 60))), 400));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 100))), 300));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 130))), 250));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 170))), 225));
    chartData.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 220))), 206));

    chartData2.add(ChartData(DateFormat('MMM').format(now), 900));
    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 30))), 700));
    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 60))), 600));
    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 100))), 500));
    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 130))), 550));
    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 170))), 500));

    chartData2.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 220))), 380));

    chartData3.add(ChartData(DateFormat('MMM').format(now), 900));
    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 30))), 850));
    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 60))), 800));
    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 100))), 700));
    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 130))), 500));
    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 170))), 600));

    chartData3.add(ChartData(
        DateFormat('MMM').format(now.add(const Duration(days: 220))), 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('App Comparison',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  'Graph shows the comparison between  this app and the others which works more smoothly',
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ),

        Container(
          height: size.height * 0.4,
          width: size.width * 0.95,
          padding: const EdgeInsets.all(10),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              majorTickLines: MajorTickLines(size: 0),
              axisLine: AxisLine(width: 2),
            ),
            primaryYAxis: CategoryAxis(
              majorTickLines: MajorTickLines(size: 0),
              axisLine: AxisLine(width: 2),
              minimum: 0,
              maximum: 500,
            ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.scroll,
              padding: 5,
              itemPadding: 10,
            ),
            onLegendItemRender: (LegendRenderArgs args) {
              args.legendIconType = LegendIconType.circle;
              if (args.text == 'Series 0') {
                args.text = 'Weight Loser';
              } else if (args.text == 'Series 1') {
                args.text = 'Strava';
              } else if (args.text == 'Series 2') {
                args.text = 'Home Workout';
              }
            },
            series: <ChartSeries>[
              SplineSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                color: Colors.green,
                animationDuration: 5000,
              ),
              SplineSeries<ChartData, String>(
                dataSource: chartData2,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                color: Colors.red,
                animationDuration: 3000,
              ),
              SplineSeries<ChartData, String>(
                dataSource: chartData3,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                color: Colors.blue,
                animationDuration: 2000,
              ),
              SplineSeries<ChartData, String>(
                dataSource: <ChartData>[chartData3[chartData3.length - 1]],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.image,
                  image: AssetImage('assets/icons/app1.png'),
                  width: 10,
                  height: 10,
                ),
                isVisibleInLegend: false,
              ),
              SplineSeries<ChartData, String>(
                dataSource: <ChartData>[chartData2[chartData2.length - 1]],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.image,
                  image: AssetImage('assets/icons/app2.png'),
                  width: 10,
                  height: 10,
                ),
                isVisibleInLegend: false,
              ),
              SplineSeries<ChartData, String>(
                dataSource: <ChartData>[chartData[chartData.length - 1]],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y * 0.5,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.image,
                  image: AssetImage('assets/icons/appicon.png'),
                  width: 15,
                  height: 15,
                ),
                isVisibleInLegend: false,
              ),
            ],
          ),
        ),
        // const Spacer(),
        // // next button
        // Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => ScreenTextWidget(
        //                 signUpBody: widget.signUpBody,
        //               )));
        //     },
        //     child: const Text('Next'),
        //   ),
        // ),
        // const SizedBox(height: 30),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
