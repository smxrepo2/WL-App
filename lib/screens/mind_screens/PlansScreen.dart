import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Mind%20_service.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/mind_plan_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/custom_bottombar.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../Provider/UserDataProvider.dart';
import 'CreateMeditationCustomPlan.dart';
import 'MeditationView.dart';
import 'my_mind_plans.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Today',
    ),
    const Tab(text: 'Diet'),
    const Tab(text: 'Exercise'),
    const Tab(text: 'Mind'),
  ];
  UserDataProvider _userDataProvider;
  GlobalKey<FormState> _mindMyPlans = GlobalKey<FormState>();
  GlobalKey<FormState> _mindCustomPlans = GlobalKey<FormState>();
  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("mindshowcaseStatus");
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(3);
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _mindMyPlans,
            _mindCustomPlans,
          ]),
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
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: true);

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    var orientation = MediaQuery.of(context).orientation;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Padding(
          padding: Responsive1.isMobile(context)
              ? const EdgeInsets.all(8)
              : const EdgeInsets.all(10),
          child: Container(
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: const AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.25,
                    child: Stack(
                      children: [
                        Image.asset(
                          ImagePath.mindPlan,
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Meditation Programs",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
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

                                            if (index == 1) {
                                              print(
                                                  "walk through mind plans completed");
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool(
                                                  "innermindshowcaseStatus",
                                                  true);
                                            }
                                          },
                                          enableAutoScroll: true,
                                          builder: Builder(
                                              builder: (context) =>
                                                  const MyMindPlansView()),
                                        ))
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 250,
                                                  right: 250,
                                                  bottom: 50,
                                                  top: 50),
                                              child: MyMindPlansView(),
                                            ));
                                // var route = MaterialPageRoute(
                                //     builder: (context) =>
                                //         MyMindPlansView());
                                // Navigator.push(context, route);
                              },
                              child: ShowCaseView(
                                globalKey: _mindMyPlans,
                                title: "Mind Plans",
                                description:
                                    "Click to see your activated Mind plan and custom plans",
                                shapeBorder: BeveledRectangleBorder(),
                                child: Text(
                                  "My Plans",
                                  style: TextStyle(
                                      fontSize: MySize.size15,
                                      fontWeight: FontWeight.w600,
                                      color: white),
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
                                                  "walk through custom meditation completed");
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool(
                                                  "custommindshowcaseStatus",
                                                  true);
                                            }
                                          },
                                          enableAutoScroll: true,
                                          builder: Builder(
                                              builder: (context) =>
                                                  CreateMeditationCustomPlan(
                                                      0)),
                                        ))
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 200,
                                                    right: 200,
                                                    bottom: 50,
                                                    top: 50),
                                                child:
                                                    CreateMeditationCustomPlan(
                                                        0)));
                                // var route = MaterialPageRoute(
                                //     builder: (context) =>
                                //         CreateMeditationCustomPlan(0));
                                // Navigator.push(context, route);
                              },
                              child: ShowCaseView(
                                globalKey: _mindCustomPlans,
                                title: "Create Plans",
                                description:
                                    "Create your own plans according to your needs",
                                shapeBorder: BeveledRectangleBorder(),
                                child: Text(
                                  "Create custom plan",
                                  style: TextStyle(
                                      fontSize: MySize.size15,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                FutureBuilder<MindModel>(
                  future: fetchMindPlans(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.plans.length == 0) {
                        return Center(
                          child: Text('No plan is available'),
                        );
                      } else {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio:
                                        orientation == Orientation.landscape
                                            ? 250 / 350
                                            : 280 / 350,
                                    // childAspectRatio: (itemWidth / itemHeight),
                                    crossAxisSpacing:
                                        orientation == Orientation.landscape
                                            ? 15
                                            : 20,
                                    mainAxisSpacing:
                                        orientation == Orientation.landscape
                                            ? 15
                                            : 20),
                            itemCount: snapshot.data.plans.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  print(
                                      "plan id ${snapshot.data.plans[index].id}");
                                  Responsive1.isMobile(context)
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowCaseWidget(
                                                      onStart: (index, key) {
                                                        //log('onStart: $index, $key');
                                                      },
                                                      onComplete:
                                                          (index, key) async {
                                                        //log('onComplete: $index, $key');
                                                        print(
                                                            "showcaseIndex:$index");

                                                        if (index == 2) {
                                                          print(
                                                              "walk through deit completed");
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          prefs.setBool(
                                                              "singlemindshowcaseStatus",
                                                              true);
                                                        }
                                                      },
                                                      enableAutoScroll: true,
                                                      builder: Builder(
                                                          builder: (context) => MeditationViewMind(
                                                              "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                                                              snapshot
                                                                  .data
                                                                  .plans[index]
                                                                  .title,
                                                              snapshot
                                                                  .data
                                                                  .plans[index]
                                                                  .id,
                                                              int.parse(snapshot
                                                                  .data
                                                                  .plans[index]
                                                                  .duration))))))
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 300,
                                                  right: 300,
                                                  bottom: 100,
                                                  top: 100),
                                              child: MeditationViewMind(
                                                  "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                                                  snapshot
                                                      .data.plans[index].title,
                                                  snapshot.data.plans[index].id,
                                                  int.parse(snapshot
                                                      .data
                                                      .plans[index]
                                                      .duration))));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (BuildContext context) => MeditationViewMind("${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",snapshot.data.plans[index].title,snapshot.data.plans[index].id,int.parse(snapshot.data.plans[index].duration),)
                                  //   ),
                                  // );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topRight:
                                                    const Radius.circular(5),
                                                topLeft:
                                                    const Radius.circular(5)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 10, 0, 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                snapshot
                                                    .data.plans[index].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: black)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "${snapshot.data.plans[index].duration} days",
                                                style: const TextStyle(
                                                    color: greyColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            )
                                          ],
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
                        child: const Text('No Internet Connectivity'),
                      );
                    }

                    // By default, show a loading spinner.
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
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
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Title',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: black)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "0 days",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
