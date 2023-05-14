import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loser/models/user_goal_data.dart';

class LineChartSyncFusion extends StatefulWidget {
  final List<Goals> goals;
  double goalweight;

  LineChartSyncFusion({Key key, this.title, this.goals, this.goalweight})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LineChartSyncFusionState createState() => _LineChartSyncFusionState();
}

class _LineChartSyncFusionState extends State<LineChartSyncFusion> {
  List<SalesData> _chartData;

  // TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _chartData = getChartData();
    //var abc=_chartData.length;
    // var abc1 = widget.goals.skip(widget.goals.length - 5).take(5);
    // print(abc-1);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 300,
          child: SfCartesianChart(
            enableAxisAnimation: true,
            enableSideBySideSeriesPlacement: true,
            // title: ChartTitle(text: 'Yearly sales analysis'),
            legend: Legend(isVisible: false),
            // tooltipBehavior: _tooltipBehavior,
            series: <SplineSeries>[
              SplineSeries<SalesData, String>(
                  name: 'Sales',
                  dataSource: _chartData,
                  xValueMapper: (SalesData sales, _) => sales.day,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  //dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  color: Colors.blue,
                  width: 1,
                  opacity: 1,
                  isVisible: true,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  ),
                  sortingOrder: SortingOrder.ascending,
                  // xAxisName: "mar",

                  // dashArray: <double>[5, 5],
                  splineType: SplineType.natural,
                  cardinalSplineTension: 0.9),
            ],
            primaryXAxis: CategoryAxis(
              arrangeByIndex: true,
            ),

            // primaryXAxis: NumericAxis(
            //   labelFormat: '{value}',
            //   isInversed: true,
            //   plotOffset: 10,
            //   labelAlignment: LabelAlignment.center,
            //   majorGridLines: MajorGridLines(width: 0),
            //   labelStyle: GoogleFonts.openSans(
            //     fontSize: 10,
            //   ),
            //   // anchorRangeToVisiblePoints: true,
            //   // decimalPlaces: 4,
            //   // axisLine: AxisLine(color: Colors.red),
            //   //interval: 2,
            //   edgeLabelPlacement: EdgeLabelPlacement.shift,
            // ),
            primaryYAxis: NumericAxis(
                maximum: _chartData[_chartData.length - 1].sales + 25,
                minimum: _chartData[0].sales - 25,
                anchorRangeToVisiblePoints: true,
                interval: 10,
                axisLine: AxisLine(color: Colors.transparent),
                labelStyle: GoogleFonts.openSans(
                  fontSize: 10,
                ),
                plotBands: <PlotBand>[
                  PlotBand(
                      verticalTextPadding: '5%',
                      horizontalTextPadding: '5%',
                      // text: 'Average',
                      textAngle: 0,
                      start: widget.goalweight,
                      end: widget.goalweight,
                      //textStyle: TextStyle(color: Colors.blue, fontSize: 16),
                      borderColor: Colors.grey,
                      borderWidth: 2)
                ]
                // labelFormat: '{value}M',
                // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                ),
          ),
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [];

    // var item1 = widget.goals.last;
    // print("Current Weight:-" + item1.currentWeight.toString());

    ///take last five current weight
    //  var abc1 = widget.goals.skip(widget.goals.length - 5).take(5);
    // print(abc1);

    ///get group by data
    // void groupEmployeesByCountry(List<Goals> employees) {
    //   final groups = groupBy(employees, (Goals e) {
    //     // print(e.currentWeight);
    //     return e.createdAt;
    //   });
    //   print(groups);
    //   groups.forEach((date, list) {
    //
    //   });
    // }
    //
    // groupEmployeesByCountry(widget.goals);

    ///get current month
    DateTime today = new DateTime.now();
    String dateSlug = "${today.month.toString().padLeft(2, '0')}";
    print("Current Month:-" + dateSlug);

    // var d3;
    // widget.goals.sort((a, b) {
    //   var adate = a.createdAt;
    //   var bdate = b.createdAt; //var bdate = b.expiry;
    //   d3 = bdate.compareTo(adate);
    //   print(d3);
    //   return -adate.compareTo(bdate);
    // });
    for (var i = 0; i < widget.goals.length; i++) {
      var d1;
      var d2;
      for (var j = i + 1; j < widget.goals.length; j++) {
        d2 = widget.goals[j].createdAt.substring(0, 10);
      }
      d1 = widget.goals[i].createdAt.substring(0, 10);

      // Ignore

      // var d3=d2.compareTo(d1);
      if (DateFormat("MM").format(DateTime.parse(widget.goals[i].createdAt)) ==
          dateSlug) {
        if (d1 == d2) {
          print("D $d1");
          print("Data");
          // chartData.removeAt(i);
          // chartData.insert(i, SalesData(
          //   double.parse(
          //       DateFormat("yyyy").format(DateTime.parse(widget.goals[i].createdAt))),
          //   double.parse(DateFormat("MM").format(DateTime.parse(widget.goals[i].createdAt))),
          //   double.parse(DateFormat("dd").format(DateTime.parse(widget.goals[i].createdAt))),
          //   double.parse(widget.goals[i].currentWeight.toString()),
          //   // double.parse(item.currentWeight.toString()),
          // ),);
          // print("data");
          // chartData.add(
          //   SalesData(
          //     0.0,0.0,0.0,0.0
          //     // double.parse(item.currentWeight.toString()),
          //   ),
          // );
          //chartData.removeAt(i);
          //  if(DateFormat("MM").format(DateTime.parse(widget.goals[i].createdAt))==dateSlug){
          //    chartData.add(
          //      SalesData(
          //        double.parse(
          //            DateFormat("yyyy").format(DateTime.parse(widget.goals[i].createdAt))),
          //        double.parse(DateFormat("MM").format(DateTime.parse(widget.goals[i].createdAt))),
          //        double.parse(DateFormat("dd").format(DateTime.parse(widget.goals[i].createdAt))),
          //        double.parse(widget.goals[i].currentWeight.toString()),
          //        // double.parse(item.currentWeight.toString()),
          //      ),
          //    );
          //  }
        } else {
          print("Data1");

          // chartData.add(
          //   SalesData(
          //     double.parse(DateFormat("yyyy")
          //         .format(DateTime.parse(widget.goals[i].createdAt))),
          //     double.parse(DateFormat("MM")
          //         .format(DateTime.parse(widget.goals[i].createdAt))),
          //     double.parse(DateFormat("dd")
          //         .format(DateTime.parse(widget.goals[i].createdAt))),
          //     double.parse(widget.goals[i].currentWeight.toString()),
          //     // double.parse(item.currentWeight.toString()),
          //   ),
          // );
        }
      }
    }

    for (var item in widget.goals) {
      //groupEmployeesByCountry(widget.goals);
      DateTime date = DateTime.parse(item.createdAt);
      var formatter = new DateFormat('dd');
      String currentDate = formatter.format(date);
      //  if(DateFormat("MM").format(DateTime.parse(item.createdAt))==dateSlug){
      chartData.add(
        SalesData(
          double.parse(
              DateFormat("yyyy").format(DateTime.parse(item.createdAt))),
          double.parse(DateFormat("MM").format(DateTime.parse(item.createdAt))),
          currentDate,
          //double.parse(DateFormat("dd").format(DateTime.parse(item.createdAt))),
          double.parse(item.currentWeight.toString()),
          // double.parse(item.currentWeight.toString()),
        ),
      );
      //}
    }

    ///logic for last five data
    // for (var item in widget.goals) {
    //   //groupEmployeesByCountry(widget.goals);
    //   for (var abc in abc1) {
    //     chartData.add(SalesData(
    //       double.parse(
    //           DateFormat("yyyy").format(DateTime.parse(abc.createdAt))),
    //       double.parse(DateFormat("MM").format(DateTime.parse(abc.createdAt))),
    //       double.parse(DateFormat("dd").format(DateTime.parse(abc.createdAt))),
    //       double.parse(abc.currentWeight.toString()),
    //     ));
    //
    //   }
    // }

    return chartData;
  }
}

class SalesData {
  final double year;
  final double sales;
  final double month;
  final String day;

  SalesData(this.year, this.month, this.day, this.sales);
}
