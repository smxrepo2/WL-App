import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/thankYou.dart';
import 'package:weight_loser/screens/screentext/methods/methods.dart';
import 'package:weight_loser/screens/screentext/methods/widgets.dart';
import 'package:weight_loser/screens/screentext/model/screenModel.dart';
import 'package:weight_loser/screens/screentext/screens/comparison.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../../../Provider/UserDataProvider.dart';

class ScreenTextWidget extends StatefulWidget {
  const ScreenTextWidget({Key key, this.signUpBody}) : super(key: key);
  final SignUpBody signUpBody;

  @override
  _ScreenTextState createState() => _ScreenTextState();
}

class _ScreenTextState
    extends State<ScreenTextWidget> //with SingleTickerProviderStateMixin
{
  TooltipBehavior _tooltipBehaviour;
  int goalWeight;
  int currentWeight;
  int measureUnit;
  int days = 0;
  int weeks;
  String unit;

  //AnimationController animationController;
  //Animation<double> animation;
  Future<ScreenTextModel> _screenTextFuture;

  List<ChartData> chartData = <ChartData>[];

  startTime() async {
    print("Timer ");
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ThankYouScreen(
              signupBody: widget.signUpBody,
            )));
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
  void dispose() {
    // TODO: implement dispose
    //animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 5000), () {
        _tooltipBehaviour.showByIndex(0, chartData.length - 1);
      });
    });
    super.initState();
    // _tooltipBehaviour = TooltipBehavior(
    //   enable: true,
    //   shouldAlwaysShow: true,
    //   header: 'Goal',
    //   format: 'point.y',
    //   builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
    //       int seriesIndex) {
    //     return Container(
    //       padding: const EdgeInsets.all(5),
    //       width: 60,
    //       height: 45,
    //       child: Center(
    //         child: Column(
    //           children: [
    //             Text(
    //               'Goal',
    //               style: GoogleFonts.poppins(
    //                   color: Colors.white,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             Text(
    //               '${point.y} $unit',
    //               style: GoogleFonts.poppins(
    //                   color: Colors.white,
    //                   fontSize: 11,
    //                   fontWeight: FontWeight.w400),
    //             ),
    //           ],
    //         ),
    //       ),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     );
    //   },
    // );
    _screenTextFuture = GetScreenTextData();
    // goalWeight = widget.signUpBody.dietQuestions.goalWeight;
    // currentWeight = widget.signUpBody.dietQuestions.currentWeight;
    // createWeightLossPredictor();
    // if (widget.signUpBody.dietQuestions.weightUnit != null) {
    //   var user = Provider.of<UserDataProvider>(context, listen: false);
    //
    //   var currentWeight = 0;
    //   var weightUnit = "";
    //
    //   if (widget.signUpBody.dietQuestions != null) {
    //     // currentWeight=widget.signupBody.dietQuestions.currentWeight;
    //     if (widget.signUpBody.dietQuestions.currentWeight != null) {
    //       currentWeight = widget.signUpBody.dietQuestions.currentWeight;
    //       weightUnit = widget.signUpBody.dietQuestions.weightUnit;
    //     } else {
    //       currentWeight = user.userData.profileVM.currentweight;
    //       weightUnit = user.userData.profileVM.weightUnit;
    //     }
    //   } else {
    //     currentWeight = user.userData.profileVM.currentweight;
    //     weightUnit = user.userData.profileVM.weightUnit;
    //   }
    //
    //   //currentWeight = widget.signUpBody.dietQuestions.currentWeight;
    //   // if (widget.signUpBody.dietQuestions.weightUnit == "kg") {
    //   double lossRate = 2.0;
    //   if (weightUnit == "kg") {
    //     measureUnit = 0;
    //     unit = "KG";
    //     lossRate = 2 / 2.205;
    //   } else {
    //     measureUnit = 1;
    //     unit = "Lb's";
    //   }
    //   int temp = goalWeight;
    //   for (int i = goalWeight; i < currentWeight; i += 7) {
    //     temp = temp - lossRate.toInt();
    //     days += 7;
    //   }
    // if (widget.signUpBody.dietQuestions.weightUnit == "kg") {
    //   measureUnit = 0;
    //   unit = "KG";
    //   days = (currentWeight - goalWeight) ~/ 0.454 * 7;
    //   print(days);
    //   weeks = days ~/ 7;
    // } else {
    //   measureUnit = 1;
    //   unit = "Lb's";
    //   days = (currentWeight - goalWeight) * 7;
    //   weeks = days ~/ 7;
    // }
/*    if (measureUnit == 0) {
      goalWeight = goalWeight ~/ 2.205;
      currentWeight = currentWeight ~/ 2.205;
    }
  */
    //animationController = new AnimationController(
    //  vsync: this, duration: new Duration(seconds: 10));
    //animation =
    //  new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    //animation.addListener(() => this.setState(() {}));
    //animationController.forward();

    //setState(() {
    //_visible = !_visible;
    //});

    //startTime();
    // }
  }

  List<String> words = ['Diet Plan', 'Workout', 'Mindfulness'];
  List<String> images = [
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=600'
  ];
  List<String> benefits = [
    'https://images.pexels.com/photos/6508344/pexels-photo-6508344.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/936094/pexels-photo-936094.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg?auto=compress&cs=tinysrgb&w=600'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: FutureBuilder<ScreenTextModel>(
                future: _screenTextFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("No Internet Connectivity");
                  } else if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     textContainer(
                        //         text1:
                        //             '${widget.signUpBody.dietQuestions.goalWeight} $unit',
                        //         text2: 'Target Weight'),
                        //     textContainer(text1: '$days Days', text2: 'Days'),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(15.0),
                        //   child: Card(
                        //     elevation: 0.4,
                        //     // shape: RoundedRectangleBorder(
                        //     //   borderRadius: BorderRadius.circular(10), // if you need this
                        //     //   side: BorderSide(
                        //     //     color: Colors.grey.withOpacity(1),
                        //     //     width: .5,
                        //     //   ),
                        //     // ),
                        //     child: SizedBox(
                        //       width: double.infinity,
                        //       height: 170,
                        //       child: Column(
                        //         children: [
                        //           const SizedBox(
                        //             height: 10,
                        //           ),
                        //           Center(
                        //             child: Text(
                        //               'How you\'ll reach at goal weight',
                        //               style: GoogleFonts.openSans(
                        //                   color: Colors.black54,
                        //                   fontSize: 11,
                        //                   fontWeight: FontWeight.w600
                        //                   // fontWeight: FontWeight.w500
                        //                   ),
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(
                        //                   left: 15.0, right: 15.0),
                        //               child: SfCartesianChart(
                        //                 primaryXAxis: CategoryAxis(
                        //                   majorGridLines:
                        //                       const MajorGridLines(width: 0),
                        //                   axisLine: const AxisLine(width: 0),
                        //                   edgeLabelPlacement:
                        //                       EdgeLabelPlacement.shift,
                        //                   labelStyle: GoogleFonts.openSans(
                        //                       color: Colors.black54,
                        //                       fontSize: 10,
                        //                       fontWeight: FontWeight.w600
                        //                       // fontWeight: FontWeight.w500
                        //                       ),
                        //                   labelAlignment: LabelAlignment.end,
                        //                 ),
                        //                 primaryYAxis: CategoryAxis(
                        //                   majorGridLines:
                        //                       const MajorGridLines(width: 0),
                        //                   axisLine: const AxisLine(width: 0),
                        //                   minimum: 90,
                        //                   maximum: currentWeight + 50.0,
                        //                   edgeLabelPlacement:
                        //                       EdgeLabelPlacement.shift,
                        //                   labelStyle: GoogleFonts.openSans(
                        //                       color: Colors.black54,
                        //                       fontSize: 11,
                        //                       fontWeight: FontWeight.w600
                        //                       // fontWeight: FontWeight.w500
                        //                       ),
                        //                   labelAlignment: LabelAlignment.end,
                        //                 ),
                        //                 tooltipBehavior: _tooltipBehaviour,
                        //                 plotAreaBorderWidth: 0,
                        //                 palette: [
                        //                   Colors.red.withOpacity(0.1),
                        //                 ],
                        //                 onMarkerRender:
                        //                     (MarkerRenderArgs args) {
                        //                   if (args.pointIndex !=
                        //                       chartData.length - 1) {
                        //                     args.markerHeight = 0;
                        //                     args.markerWidth = 0;
                        //                   }
                        //                 },
                        //                 series: <ChartSeries>[
                        //                   SplineAreaSeries<ChartData, String>(
                        //                     enableTooltip: true,
                        //                     dataSource: chartData,
                        //                     xValueMapper: (ChartData data, _) =>
                        //                         data.x,
                        //                     yValueMapper: (ChartData data, _) =>
                        //                         data.y,
                        //                     borderColor: Colors.redAccent,
                        //                     borderWidth: 3,
                        //                     animationDuration: 4000,
                        //                     markerSettings:
                        //                         const MarkerSettings(
                        //                       isVisible: true,
                        //                       shape: DataMarkerType.circle,
                        //                       borderWidth: 2,
                        //                       borderColor: Colors.white,
                        //                       color: Colors.green,
                        //                       width: 10,
                        //                       height: 10,
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        // const ComparisonChart(),
                        // const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('\u2022' ' ',
                                  style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: Text(
                                  "We are so sure of your weight loss with our diet exercise and mind techniques that you'll reach your goal weight, otherwise we will give 100% money back guarantee",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                    color: Color(0xff080808),
                                    height: 1.25,
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: 10,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('\u2022' ' ',
                                  style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: Text(
                                  "Money back guarantees for minimum of 70% compliance on our daily plan.",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                    color: Color(0xff080808),
                                    height: 1.25,
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: 10,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Center(
                          child: Text(
                            'Success stories',
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                color: Colors.black87,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SizedBox(
                            height: 170,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imageBaseUrl${snapshot.data.users[index].fileName}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                //colorFilter:
                                                //  ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor:
                                                      Colors.grey[100]),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        '${(snapshot.data.users[index].currentweight - snapshot.data.users[index].goalWeight).abs()} kg loss',
                                        style: const TextStyle(
                                          fontFamily: 'Segoe UI',
                                          color: Colors.black54,
                                          fontSize: 11,
                                          // fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const Text(
                                        '7 days',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          color: Colors.black87,
                                          fontSize: 11,
                                          // fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black87,
                          thickness: 1,
                          indent: 80,
                          endIndent: 80,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.screenText.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Center(
                                child: Text(
                                  snapshot.data.screenText[index].text,
                                  style: const TextStyle(
                                      fontFamily: 'Segoe UI',
                                      color: Colors.black87,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: Text(
                            'What you will get in app',
                            style: GoogleFonts.openSans(
                                color: const Color(0xff000000),
                                fontSize: 11,
                                fontWeight: FontWeight.w600
                                // fontWeight: FontWeight.w500
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: SizedBox(
                            height: 140,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: benefits.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  Image.network(benefits[index])
                                                      .image,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        words[index],
                                        style: GoogleFonts.openSans(
                                            color: const Color(0xff000000),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                              right: MediaQuery.of(context).size.height * 0.05,
                              left: MediaQuery.of(context).size.height * 0.05),
                          child: GestureDetector(
                            onTap: () {
                              navigationPage();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /*switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:

                    default:
                      if (snapshot.hasError)
                        return Text("No Internet Connectivity");
                      else if (snapshot.hasData) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                textContainer(
                                    text1:
                                        '${widget.signUpBody.dietQuestions.goalWeight} $unit',
                                    text2: 'Target Weight'),
                                textContainer(
                                    text1: '$days Days', text2: 'Days'),
                              ],
                            ),
                            SizedBox(
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
                                child: Container(
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
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: ConcaveGraph(
                                                currentWeight: widget
                                                    .signUpBody
                                                    .dietQuestions
                                                    .currentWeight,
                                                measureUnit: measureUnit,
                                                weeks: weeks,
                                                weightDifference: goalWeight,
                                                days: days)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Text(
                                "\u2022 We are so sure of your weight loss with our diet+exercise+mind techniques that you'll reach your goal weight,otherwise we will give 100% money back gaurantee ",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: Color(0xff080808),
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Text(
                                "\u2022 Money back gaurantees for minimum of 70% compliance on our daily plan",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: Color(0xff080808),
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: const Text(
                                'Success stories',
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    color: Colors.black87,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                height: 170,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 72,
                                            height: 66,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "$imageBaseUrl${snapshot.data.users[index].fileName}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    //colorFilter:
                                                    //  ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            '${(snapshot.data.users[index].currentweight - snapshot.data.users[index].goalWeight).abs()} kg loss',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              color: Colors.black54,
                                              fontSize: 11,
                                              // fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            '7 days',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              color: Colors.black87,
                                              fontSize: 11,
                                              // fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black87,
                              thickness: 1,
                              indent: 80,
                              endIndent: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.screenText.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data.screenText[index].text}',
                                      style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          color: Colors.black87,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Center(
                              child: Text(
                                'What you will get in app',
                                style: GoogleFonts.openSans(
                                    color: Color(0xff000000),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600
                                    // fontWeight: FontWeight.w500
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                height: 140,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: benefits.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 75,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                          benefits[index])
                                                      .image,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            words[index],
                                            style: GoogleFonts.openSans(
                                                color: Color(0xff000000),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right:
                                      MediaQuery.of(context).size.height * 0.05,
                                  left: MediaQuery.of(context).size.height *
                                      0.05),
                              child: GestureDetector(
                                onTap: () {
                                  navigationPage();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                  }*/
                })));
  }
}

// class ChartData {
//   ChartData(this.x, this.y);
//
//   final String x;
//   final int y;
// }
