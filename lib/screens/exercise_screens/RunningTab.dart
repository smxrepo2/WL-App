import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/exercise_api.dart';
import 'package:weight_loser/models/food_plans_model.dart';
import 'package:weight_loser/screens/exercise_screens/ActiveRunning.dart';
import 'package:weight_loser/screens/exercise_screens/CreateExerciseCustomPlan.dart';
import 'package:weight_loser/screens/exercise_screens/GetUpGoUp.dart';
import 'package:weight_loser/screens/exercise_screens/MyPlansExercise.dart';
import 'package:weight_loser/screens/exercise_screens/individualExercise.dart';
import 'package:weight_loser/screens/groupExercise/models/individual_exercise_model.dart';
import 'package:weight_loser/screens/groupExercise/screens/exerciseTimer.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/floating_action_button_widget.dart';
import 'package:weight_loser/widget/Shimmer/running_shimmer_widget.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../Provider/UserDataProvider.dart';
import '../groupExercise/screens/exerciseGroup.dart';

class RunningTabView extends StatefulWidget {
  const RunningTabView({Key key}) : super(key: key);

  @override
  _RunningTabViewState createState() => _RunningTabViewState();
}

class _RunningTabViewState extends State<RunningTabView>
    with AutomaticKeepAliveClientMixin<RunningTabView> {
  @override
  bool get wantKeepAlive => true;
  List<String> running = [
    "https://images.pexels.com/photos/1149923/pexels-photo-1149923.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/34514/spot-runs-start-la.jpg?auto=compress&cs=tinysrgb&w=800"
  ];
  List<String> exerciseNames = ["5k Walk", "5k Run"];
  UserDataProvider _userDataProvider;
  GlobalKey<FormState> _exeMyPlans = GlobalKey<FormState>();
  GlobalKey<FormState> _exeCustomPlans = GlobalKey<FormState>();
  GlobalKey<FormState> _exeGroupPlans = GlobalKey<FormState>();
  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("exeshowcaseStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context)
              .startShowCase([_exeMyPlans, _exeCustomPlans, _exeGroupPlans]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: true);
    // ignore: unused_local_variable
    int initialIndex;

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    var mobile = Responsive1.isMobile(context);
    return Scaffold(
        body: SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        //physics:
        //  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height * 0.25,
              child: Stack(
                children: [
                  Image.asset(
                    ImagePath.runTab,
                    fit: BoxFit.cover,
                    height: height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Exercise Programs",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ShowCaseWidget(
                                onStart: (index, key) {
                                  //log('onStart: $index, $key');
                                },
                                onComplete: (index, key) async {
                                  //log('onComplete: $index, $key');
                                  print("showcaseIndex:$index");

                                  if (index == 1) {
                                    print(
                                        "walk through Exercise Plans completed");
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool(
                                        "innerexeshowcaseStatus", true);
                                  }
                                },
                                enableAutoScroll: true,
                                builder: Builder(
                                    builder: (context) =>
                                        const MyPlansExercise()),
                              ));
                        },
                        child: ShowCaseView(
                          globalKey: _exeMyPlans,
                          title: "Exercise Plans",
                          description:
                              "Click to see your activated exercise plan and custom plans",
                          shapeBorder: BeveledRectangleBorder(),
                          child: Text(
                            "My Plans",
                            style: TextStyle(
                                fontSize: MySize.size15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          Responsive1.isMobile(context)
                              ? Get.to(() => ShowCaseWidget(
                                    onStart: (index, key) {
                                      //log('onStart: $index, $key');
                                    },
                                    onComplete: (index, key) async {
                                      //log('onComplete: $index, $key');
                                      print("showcaseIndex:$index");

                                      if (index == 3) {
                                        print(
                                            "walk through custom exercise completed");
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setBool(
                                            "customexeshowcaseStatus", true);
                                      }
                                    },
                                    enableAutoScroll: true,
                                    builder: Builder(
                                        builder: (context) =>
                                            CreateExerciseCustomPlan(0)),
                                  ))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150,
                                          right: 150,
                                          bottom: 50,
                                          top: 50),
                                      child: CreateExerciseCustomPlan(0)));
                        },
                        child: ShowCaseView(
                          globalKey: _exeCustomPlans,
                          title: "Create Plans",
                          description:
                              "Create your own plans according to your needs",
                          shapeBorder: BeveledRectangleBorder(),
                          child: Text(
                            "Create custom plan",
                            style: TextStyle(
                                fontSize: MySize.size15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 10),
          ShowCaseView(
            globalKey: _exeGroupPlans,
            title: "Group Plans",
            description: "Tap to participate in group exercises",
            shapeBorder: BeveledRectangleBorder(),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExerciseGroup()));
                  },
                  child: Text("Group Exercises")),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Walk Exercises",
              style: TextStyle(
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ),
          Divider(),
          FutureBuilder<IndividualExerciseModel>(
            future: fetchIndividualExercisePlans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data.fiveKRun.day == 0) {
                  return Center(child: Text("Enjoy your holiday"));
                }
                List<double> distance = [
                  snapshot.data.fiveKRun.slowWalkMeters,
                  snapshot.data.fiveKRun.fastWalkMeters
                ];
                return GridView.builder(
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: mobile ? 250 : 210,
                        childAspectRatio: 280 / 350,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: 2,
                    itemBuilder: (BuildContext newctx, index) {
                      print("Image Path:${running[index]}");
                      return InkWell(
                        onTap: () {
                          Get.to(() => IndividualExercise(
                              path: running[index],
                              distance: distance[index],
                              run: index == 0 ? false : true,
                              name: exerciseNames[index],
                              days: snapshot.data.fiveKRun.day));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5)),
                                    image: DecorationImage(
                                      image: NetworkImage("${running[index]}"),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(exerciseNames[index],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: mobile ? 12 : 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            "${distance[index]} meters",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('No Data is Available'),
                );
              }

              // By default, show a loading spinner.
              return RunningShimmerWidget();
              //RunningShimmerWidget();
            },
          ),

          /***************************************Exercise Plans************************************** */

          const SizedBox(height: 10),
          Center(
            child: Text(
              "Exercise Plans",
              style: TextStyle(
                  fontSize: MySize.size15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ),
          Divider(),
          FutureBuilder<PlanModel>(
            future: fetchExercisePlans(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.plans.length == 0) {
                  return const Center(
                    child: Text('No any Excercise Plan'),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: mobile ? 250 : 210,
                          childAspectRatio: 280 / 350,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.plans.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {});
                            initialIndex = 1;
                            print("plan id ${snapshot.data.plans[index].id}");
                            Responsive1.isMobile(context)
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowCaseWidget(
                                        onStart: (index, key) {
                                          //log('onStart: $index, $key');
                                        },
                                        onComplete: (index, key) async {
                                          //log('onComplete: $index, $key');
                                          print("showcaseIndex:$index");

                                          if (index == 3) {
                                            print(
                                                "walk through deit completed");
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool(
                                                "singleexeshowcaseStatus",
                                                true);
                                          }
                                        },
                                        enableAutoScroll: true,
                                        builder: Builder(
                                            builder: (context) => GetUpGoUp(
                                                  "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                                                  snapshot
                                                      .data.plans[index].title,
                                                  snapshot.data.plans[index].id,
                                                  int.parse(snapshot.data
                                                      .plans[index].duration),
                                                )))))
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 300,
                                            right: 300,
                                            bottom: 50,
                                            top: 50),
                                        child: GetUpGoUp(
                                          "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                                          snapshot.data.plans[index].title,
                                          snapshot.data.plans[index].id,
                                          int.parse(snapshot
                                              .data.plans[index].duration),
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                              snapshot.data.plans[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: mobile ? 12 : 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "${snapshot.data.plans[index].duration} weeks",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('No Internet Connectivity'),
                );
              }

              // By default, show a loading spinner.
              return RunningShimmerWidget();
            },
          ),
        ],
      ),
    ));
  }
}
