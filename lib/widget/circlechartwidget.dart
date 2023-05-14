import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:weight_loser/constants/constant.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

enum LegendShape { Circle, Rectangle }

class Graph extends StatefulWidget {
  double carbs,protein,fat;

  Graph(this.carbs, this.protein, this.fat);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {

  List<Color> colorList = [
    purple,
    Colors.white,
    secondaryColor,
    Colors.white,
    pinkColor
  ];

  Map<String, double> dataMap;
  @override
  void initState() {
    super.initState();
    dataMap = {
      "Carbs": widget.carbs,
      'space': 0.05,
      "Fat": widget.fat,
      'space1': 0.05,
      "Protein": widget.protein,
      'spaces': 0.05,
    };
  }

  ChartType _chartType = ChartType.ring;
  // ignore: unused_field
  bool _showCenterText = true;
  double _ringStrokeWidth = 10;
  double _chartLegendSpacing = 10;

  bool _showLegendsInRow = false;
  bool _showLegends = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = false;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 500),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: MediaQuery.of(context).size.width / 1.6 > 100 ? 100 : MediaQuery.of(context).size.width / 1.6,
      colorList: colorList,
      initialAngleInDegree: 270,
      chartType: _chartType,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
    );
    // ignore: unused_local_variable
    final settings = SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [],
        ),
      ),
    );
    return Container(
      child: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: chart,
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(11),
                    child: chart,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  totalCaloriesShowWidget() {}
}
