import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/food_plan_model.dart';
import 'package:weight_loser/models/food_plans_model.dart';

import 'package:weight_loser/screens/GroceryList.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/food_screens/CreateCustomPlan.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

class MyPlansView extends StatefulWidget {
  const MyPlansView({Key key}) : super(key: key);

  @override
  _MyPlansViewState createState() => _MyPlansViewState();
}

class _MyPlansViewState extends State<MyPlansView>
    with TickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];
  List<Plans> customDietPlans = [];
  int userid;

  GlobalKey<FormState> _dietActivePlans = GlobalKey<FormState>();
  GlobalKey<FormState> _dietGroceryList = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomPlansList = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("innerdietshowcaseStatus");
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(1);
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase(
              [_dietActivePlans, _dietGroceryList, _dietCustomPlansList]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
    fetchCustomDietPlans().then((value) {
      setState(() {
        value.plans.forEach((element) {
          if (element.planTypeId == 1) customDietPlans.add(element);
        });
      });
    });
  }

  // Future<List<ActivePlanModel>> fetchActivePlans() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userid=prefs.getInt('userid');
  //   final response = await get(Uri.parse('$apiUrl/api/activeplans/Diet/$userid'), );
  //   print("response ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     Iterable l = json.decode(response.body);
  //     List<ActivePlanModel> posts = List<ActivePlanModel>.from(l.map((model)=> ActivePlanModel.fromJson(model)));
  //     return posts;
  //   } else {
  //     throw Exception('Failed to load plan');
  //   }
  // }
  // Future<PlanModel> fetchCustomDietPlans() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userid=prefs.getInt('userid');
  //   final response = await get(Uri.parse('$apiUrl/api/plan/getbyuser/$userid'), );
  //   print("lll $userid");
  //   print("response ${response.statusCode} ${response.body}");
  //   if (response.statusCode == 200) {
  //     return PlanModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load plans');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    int initialIndex;
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? titleAppBar(context: context, title: "My Plans")
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      body: Padding(
        padding: Responsive1.isDesktop(context)
            ? const EdgeInsets.all(10.0)
            : const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              HeadingWeb(),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.26,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/Diet.png',
                        fit: BoxFit.cover,
                        height: height * 0.3,
                        width: MediaQuery.of(context).size.width,
                      ),
                      /*Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "My Plans",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),*/
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Browse Plans",
                              style: TextStyle(
                                  fontSize: MySize.size15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              print("tapped");
                              Responsive1.isMobile(context)
                                  ? Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: ((context) => ShowCaseWidget(
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
                                                        "customdietshowcaseStatus",
                                                        true);
                                                  }
                                                },
                                                enableAutoScroll: true,
                                                builder: Builder(
                                                    builder: (context) =>
                                                        CreateDietCustomPlan(
                                                            0)),
                                              ))))
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250,
                                                right: 250,
                                                bottom: 50,
                                                top: 50),
                                            child: ShowCaseWidget(
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
                                                      "customdietshowcaseStatus",
                                                      true);
                                                }
                                              },
                                              enableAutoScroll: true,
                                              builder: Builder(
                                                  builder: (context) =>
                                                      CreateDietCustomPlan(0)),
                                            ),
                                          ));
                              // var route = MaterialPageRoute(
                              //     builder: (context) => CreateDietCustomPlan(0));
                              // Navigator.push(context, route);
                            },
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
                    ],
                  )),
              SizedBox(
                height: MySize.size20,
              ),
              leftRightheading("Active Plan(s)", Icons.list_alt_outlined,
                  "Grocery list", GroceryList()),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder<List<ActivePlanModel>>(
                    future: fetchActivePlans(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ShowCaseView(
                          globalKey: _dietActivePlans,
                          title: "Active Plans",
                          description: "Click to see your active plan diet",
                          shapeBorder: BeveledRectangleBorder(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  //setState(() {});
                                  initialIndex = 1;
                                  PlanModel plan;
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

                                                        if (index == 3) {
                                                          print(
                                                              "walk through deit completed");
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          prefs.setBool(
                                                              "singledietshowcaseStatus",
                                                              true);
                                                        }
                                                      },
                                                      enableAutoScroll: true,
                                                      builder: Builder(
                                                          builder: (context) =>
                                                              DietInnerTab(
                                                                  '$imageBaseUrl${snapshot.data[index].fileName}',
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .title,
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .planId,
                                                                  int.parse(snapshot
                                                                      .data[
                                                                          index]
                                                                      .duration))))))
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Padding(
                                            padding: const EdgeInsets.only(
                                                left: 300,
                                                right: 300,
                                                bottom: 50,
                                                top: 50),
                                            child: ShowCaseWidget(
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
                                                  builder: (context) =>
                                                      DietInnerTab(
                                                          '$imageBaseUrl${snapshot.data[index].fileName}',
                                                          snapshot.data[index]
                                                              .title,
                                                          snapshot.data[index]
                                                              .planId,
                                                          int.parse(snapshot
                                                              .data[index]
                                                              .duration)),
                                                )),
                                          ),
                                        );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         DietInnerTab('$imageBaseUrl${snapshot.data[index].fileName}',snapshot.data[index].title,snapshot.data[index].planId,int.parse(snapshot.data[index].duration)),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  '$imageBaseUrl${snapshot.data[index].fileName}',
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index].title,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "${snapshot.data[index].duration} days",
                                                style: TextStyle(
                                                    color: Colors.grey,
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
                            },
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
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
                                  width: 200,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Yoga',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "0days",
                                          style: TextStyle(
                                              color: Colors.grey,
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
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          enabled: true,
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(child: Text("No Internet Connectivity"));
                        //return SizedBox(
                        //height: 200,
                        //width: 200,
                        //child: Center(
                        //child: CircularProgressIndicator(
                        //color: Colors.blue,
                        //),
                        //),
                        //);
                      }

                      // By default, show a loading spinner.
                      return Shimmer.fromColors(
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
                                width: 200,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Yoga',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "7 days",
                                        style: TextStyle(
                                            color: Colors.grey,
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
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        enabled: true,
                      );
                    }),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              headingView("Custom Plan(s)", MySize.size0),
              customDietPlans.length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(child: Text("No Custom Plans")),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 280 / 350,
                          // childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: customDietPlans.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            Responsive1.isMobile(context)
                                ? Get.to(() => DietInnerTab(
                                    "${imageBaseUrl}${customDietPlans[index].fileName}",
                                    customDietPlans[index].title,
                                    customDietPlans[index].id,
                                    int.parse(customDietPlans[index].duration)))
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 300,
                                              right: 300,
                                              bottom: 50,
                                              top: 50),
                                          child: DietInnerTab(
                                              "${imageBaseUrl}${customDietPlans[index].fileName}",
                                              customDietPlans[index].title,
                                              customDietPlans[index].id,
                                              int.parse(customDietPlans[index]
                                                  .duration)),
                                        ));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (BuildContext context) => DietInnerTab("${imageBaseUrl}${customDietPlans[index].fileName}",customDietPlans[index].title,customDietPlans[index].id,int.parse(customDietPlans[index].duration),)
                            //   ),
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
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${imageBaseUrl}${customDietPlans[index].fileName}"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(customDietPlans[index].title,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "${customDietPlans[index].duration} days",
                                          style: TextStyle(
                                              color: Colors.grey,
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
                      })
            ],
          ),
        ),
      ),
    );
  }

  Container customPlansGrid(int initialIndex, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                      PlanModel plan;
                      initialIndex = 1;
                      Get.to(() => DietInnerTab("", "", 6, 1));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => DietInnerTab("","",6,1),
                      //   ),
                      // );
                    },
                    child: Image.asset(
                      'assets/images/diet1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kernal Diet",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "2 weeks",
                            style: TextStyle(
                                color: Colors.grey,
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
          ),
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        initialIndex = 1;
                      });
                      PlanModel plan;
                      Get.to(() => DietInnerTab("", "", 6, 1));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (BuildContext context) => DietInnerTab("","",6,1)),
                      // );
                    },
                    child: Image.asset(
                      'assets/images/diet2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fruit Diet",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "4 weeks",
                            style: TextStyle(
                                color: Colors.grey,
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
          ),
        ],
      ),
    );
  }

  Widget leftRightheading(left, iconName, right, route) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DDText(
            title: left,
            size: MySize.size15,
          ),
          ShowCaseView(
            globalKey: _dietGroceryList,
            title: "Grocery List",
            description: "Find list of grocery according to your plan",
            shapeBorder: BeveledRectangleBorder(),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => route));
              },
              child: Row(
                children: [
                  Icon(
                    iconName,
                    size: 18,
                    color: primaryColor,
                  ),
                  DDText(
                    title: right,
                    size: MySize.size15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headingView(title, bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size16, bottom: bottomPadding),
      child: Row(
        children: [
          ShowCaseView(
            globalKey: _dietCustomPlansList,
            title: "Custom Plans",
            description:
                "Find list of custom plans you created according to need",
            shapeBorder: BeveledRectangleBorder(),
            child: DDText(
              title: title,
              size: MySize.size15,
            ),
          ),
        ],
      ),
    );
  }
}
