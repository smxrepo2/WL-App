import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/food_plans_model.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/food_screens/CreateCustomPlan.dart';
import 'package:weight_loser/screens/food_screens/MyPlans.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/Shimmer/diet_shimmer_widget.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/floating_action_button_widget.dart';
import 'package:weight_loser/widget/no_internet_dialog.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

class DietTabView extends StatefulWidget {
  const DietTabView({Key key}) : super(key: key);

  @override
  _DietTabViewState createState() => _DietTabViewState();
}

class _DietTabViewState extends State<DietTabView>
    with AutomaticKeepAliveClientMixin<DietTabView> {
  @override
  bool get wantKeepAlive => true;
  UserDataProvider _userDataProvider;
  GlobalKey<FormState> _dietMyPlans = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomPlans = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("dietshowcaseStatus");
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
          (_) => ShowCaseWidget.of(context).startShowCase([
            _dietMyPlans,
            _dietCustomPlans,
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
    super.build(context);
    // ignore: unused_local_variable
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: true);
    int initialIndex;

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height * 0.25,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Diet.png',
                    fit: BoxFit.cover,
                    height: height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Diet Programs",
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
                          Get.to(
                            () => ShowCaseWidget(
                              onStart: (index, key) {
                                //log('onStart: $index, $key');
                              },
                              onComplete: (index, key) async {
                                //log('onComplete: $index, $key');
                                print("showcaseIndex:$index");

                                if (index == 2) {
                                  print("walk through deit completed");
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool(
                                      "innerdietshowcaseStatus", true);
                                }
                              },
                              enableAutoScroll: true,
                              builder: Builder(
                                  builder: (context) => const MyPlansView()),
                            ),
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return MyPlansView();
                          // }));
                        },
                        child: ShowCaseView(
                          globalKey: _dietMyPlans,
                          title: "Diet Plans",
                          description:
                              "Click to see your activated diet plan and custom plans",
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
                          //Get.to(CreateDietCustomPlan(0));
                          // var route = MaterialPageRoute(
                          //     builder: (context) =>CreateDietCustomPlan(0));
                          // CreateDietCustomPlan(0));
                          Responsive1.isMobile(context)
                              ? Get.to(
                                  () => ShowCaseWidget(
                                    onStart: (index, key) {
                                      //log('onStart: $index, $key');
                                    },
                                    onComplete: (index, key) async {
                                      //log('onComplete: $index, $key');
                                      print("showcaseIndex:$index");

                                      if (index == 4) {
                                        print(
                                            "walk through custom deit completed");
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setBool(
                                            "customdietshowcaseStatus", true);
                                      }
                                    },
                                    enableAutoScroll: true,
                                    builder: Builder(
                                        builder: (context) =>
                                            CreateDietCustomPlan(0)),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    fetchDietPlans();
                                  });
                                })
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 250,
                                            right: 250,
                                            bottom: 50,
                                            top: 50),
                                        child: CreateDietCustomPlan(0),
                                      ));
                        },
                        child: ShowCaseView(
                          globalKey: _dietCustomPlans,
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
          FutureBuilder<PlanModel>(
            future: fetchDietPlans(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.plans.isEmpty) {
                  return const Center(
                    child: Text(
                      'No any Diet Plan',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
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
                                                "singledietshowcaseStatus",
                                                true);
                                          }
                                        },
                                        enableAutoScroll: true,
                                        builder: Builder(
                                            builder: (context) => DietInnerTab(
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
                                          child: DietInnerTab(
                                            "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                                            snapshot.data.plans[index].title,
                                            snapshot.data.plans[index].id,
                                            int.parse(snapshot
                                                .data.plans[index].duration),
                                          ),
                                        ));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (BuildContext context) => DietInnerTab(
                            //             "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}",
                            //             snapshot.data.plans[index].title,
                            //             snapshot.data.plans[index].id,
                            //             int.parse(snapshot.data.plans[index].duration),
                            //           )),
                            // );
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
                                          topLeft: const Radius.circular(5)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                                "${snapshot.data.imagePath}${snapshot.data.plans[index].fileName}") ??
                                            "https://www.freeiconspng.com/thumbs/food-png/food-salad-21.png",
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
                                        Text(snapshot.data.plans[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: black)),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "${snapshot.data.plans[index].duration} days",
                                              style: const TextStyle(
                                                  color: lightGrey,
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
              return const DieShimmertWidget();
            },
          ),
        ],
      ),
    );
  }
}
