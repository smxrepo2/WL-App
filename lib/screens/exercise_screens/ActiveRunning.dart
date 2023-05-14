import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/screens/navigation_tabs/ExerciseSceen.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class ActiveRunning extends StatefulWidget {
  const ActiveRunning({Key key}) : super(key: key);

  @override
  _ActiveRunningState createState() => _ActiveRunningState();
}

class _ActiveRunningState extends State<ActiveRunning>
    with TickerProviderStateMixin {
  List<bool> days = [false, false, false, false, false, false, false];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;

  TabController _tabController;

  bool isFavourite = false;
  bool isAdded = false;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double margin = height * 0.02;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: CustomStaticBottomNavigationBar(),
        drawer: CustomDrawer(),
        appBar: customAppBar(
          context,
          elevation: 0.5,
          /*tabBar: TabBar(
            onTap: (index) {
              setState(() {
                _tabController.index = 2;
              });
            },
            controller: _tabController,
            labelPadding: EdgeInsets.only(left: MySize.size4),
            indicatorColor: Color(0xff4885ED),
            labelColor: Color(0xff4885ED),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black87,
            tabs: myTabs,
          ),*/
        ),
        body: Container(
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.25,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/run2.png',
                        fit: BoxFit.cover,
                        height: height * 0.3,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Active Running",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.fromLTRB(margin, margin, 0, 0),
                child: Text(
                  "Days",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              daysRowUpdated(margin, height),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(margin, 10, margin, margin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Set 1",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "2 Reps",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(margin, 0, margin, margin),
                  child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ExerciseScreen([], 0));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) =>
                                    //         ExerciseScreen([],0),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 0, margin, 0),
                                    height: height * 0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/1.png',
                                            ))),
                                  ),
                                ),
                                Container(
                                    height: height * 0.12,
                                    width: MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.width *
                                            0.31),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Walk",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              "10 minutes",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              color: Colors.blue,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "200 kcal",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isFavourite =
                                                          !isFavourite;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: isFavourite == true
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isAdded = !isAdded;
                                                    });
                                                  },
                                                  child: Icon(
                                                    isAdded == true
                                                        ? MdiIcons.minus
                                                        : MdiIcons.plus,
                                                    color: Colors.blue,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                            )
                          ],
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container daysRowUpdated(double margin, double height) {
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < days.length; i++) {
                    setState(() {
                      days[i] = false;
                    });
                  }
                  setState(() {
                    days[0] = true;
                  });
                },
                child: dayNumberUpdated(height, "1", 0),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[1] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "2", 1)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[2] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "3", 2)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[3] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "4", 3)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[4] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "5", 4)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[5] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "6", 5)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < days.length; i++) {
                      setState(() {
                        days[i] = false;
                      });
                    }
                    setState(() {
                      days[6] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "7", 6)),
            ),
          ],
        ));
  }

  Container dayNumberUpdated(double height, number, index) {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size4,
        bottom: MySize.size4,
      ),
      // padding: EdgeInsets.fromLTRB(height * 0.001,
      //     height * 0.018, height * 0.002, height * 0.015),
      margin: EdgeInsets.only(
        right: height * 0.025,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: days[index] ? selectedBgColor : unSelectedBgColor),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DDText(
              title: "Day",
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
            DDText(
              title: number,
              size: 11,
              weight: FontWeight.w300,
              color: days[index] ? selectedTextColor : unSelectedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
