import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loser/Model/SignupBody.dart';

import '../models/all_questions_model.dart';
import 'dob.dart';

class WeightPredict extends StatefulWidget {
  WeightPredict({Key key, @required this.signUpBody, this.questionsModel})
      : super(key: key);
  SignUpBody signUpBody;
  GetAllQuestionsModel questionsModel;
  @override
  State<WeightPredict> createState() => _WeightPredictState();
}

class _WeightPredictState extends State<WeightPredict> {
  GetAllQuestionsModel _questionsModel;
  Questoins _questoins;

  int weight = 0;
  int goalWeight = 0;
  DateTime date = DateTime.now();

  List<ChartData> chartData = <ChartData>[];

  @override
  void initState() {
    super.initState();
    weight = widget.signUpBody.dietQuestions.currentWeight;
    goalWeight = widget.signUpBody.dietQuestions.goalWeight;
    createWeightLossPredictor();
    _questionsModel = widget.questionsModel;
    _questoins = _questionsModel.questoins[4];
    //print(_questoins.options);
  }

  void createWeightLossPredictor() {
    int currentWeight = weight;
    while (currentWeight > goalWeight) {
      // random value between 0 and 2
      final int randomValue = Random().nextInt(5) + 1;
      chartData.add(ChartData(DateFormat("MMM d").format(date), currentWeight));
      currentWeight = currentWeight - randomValue;
      date = date.add(const Duration(days: 7));
    }
    chartData.add(ChartData(DateFormat("MMM d").format(date), goalWeight));
    print(chartData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "You'll reach your goal by",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              '${DateFormat("MMMM dd").format(date)}',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 50),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                axisLine: AxisLine(width: 3),
              ),
              primaryYAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                axisLine: AxisLine(width: 0),
                minimum: 90,
              ),
              plotAreaBorderWidth: 0,
              palette: [
                const Color(0x4d4885ed).withOpacity(0.1),
              ],
              onMarkerRender: (MarkerRenderArgs args) {
                if (args.pointIndex != chartData.length - 1) {
                  args.markerHeight = 0;
                  args.markerWidth = 0;
                }
              },
              series: <ChartSeries>[
                SplineAreaSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  borderColor: Colors.blueAccent,
                  borderWidth: 3,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    borderWidth: 2,
                    borderColor: Colors.white,
                    color: Colors.red,
                    width: 10,
                    height: 10,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DOBQestion(
                              questionsModel: widget.questionsModel,
                              signupBody: widget.signUpBody,
                            )));
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
