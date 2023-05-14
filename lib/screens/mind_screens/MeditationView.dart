import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/MeditationListData.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Mind%20_service.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/models/mind_detail_model.dart';
import 'package:weight_loser/models/mind_plan_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../widget/CustomDrawer.dart';

class MeditationViewMind extends StatefulWidget {
  int planId;
  int days;
  String path;
  String name;

  MeditationViewMind(this.path, this.name, this.planId, this.days);

  @override
  _MeditationViewMindState createState() => _MeditationViewMindState();
}

class _MeditationViewMindState extends State<MeditationViewMind>
    with TickerProviderStateMixin {
  SimpleFontelicoProgressDialog _dialog;

  List<bool> days = [];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;

  TabController _tabController;

  bool isFavourite = false;
  bool isAdded = false;
  int userid;
  int dayNumber = 1;
  MindDetailModel mindDetailModel;

  List<FavouriteMindModel> favouriteItems = [];
  List<bool> isFavorite = [];
  bool isLoadingFavourites = true;
  GlobalKey<FormState> _mindDays = GlobalKey<FormState>();
  GlobalKey<FormState> _mindFoodDetails = GlobalKey<FormState>();
  GlobalKey<FormState> _mindReplace = GlobalKey<FormState>();
  GlobalKey<FormState> _mindFavorite = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _mindAddMeal = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("singlemindshowcaseStatus");
  }

  fetchFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Mind/$userid'),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['favoriteMindVMs'];
      setState(() {
        favouriteItems = List<FavouriteMindModel>.from(
            l.map((model) => FavouriteMindModel.fromJson(model)));
        isLoadingFavourites = false;
      });
      print("favorite mind items:" + favouriteItems.toString());
    } else {
      setState(() {
        isLoadingFavourites = false;
      });
      throw Exception('Failed to load plan');
    }
    _dialog.hide();
  }

  Future<MindDetailModel> fetchMindPlanDetail(int id, int day) async {
    print("plan $id");
    print("plan day $day");
    final response = await get(
      Uri.parse('$apiUrl/api/plan/MindPlan?planId=$id&day=$day'),
    );
    print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      return MindDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load plan');
    }
  }

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
    fetchActivePlans();
    fetchFavourites();
    for (int i = 0; i < widget.days; i++) {
      if (i == 0) {
        days.add(true);
      } else
        days.add(false);
    }
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _mindDays,
            _mindFoodDetails,

            _mindFavorite,
            // _dietCustomAddFood,
            //_mindAddMeal
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
    /*
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(1);*/
  }

  bool isActive = false;
  fetchActivePlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/activeplans/getbyuser/$userid'),
    );
    print("response ${response.statusCode}");
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<ActivePlanModel> posts = List<ActivePlanModel>.from(
          l.map((model) => ActivePlanModel.fromJson(model)));
      posts.forEach((element) {
        if (element.planId == widget.planId) {
          setState(() {
            isActive = true;
          });
        }
      });
    } else {
      throw Exception('Failed to load plan');
    }
  }

  Future<Response> setPlanActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    return post(
      Uri.parse('$apiUrl/api/activeplans/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "PlanId": widget.planId,
        "Type": "mind"
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var orientation = MediaQuery.of(context).orientation;
    double margin = height * 0.02;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        //bottomNavigationBar: CustomStaticBottomNavigationBar(),
        drawer: CustomDrawer(),
        // appBar: customAppBar(
        //   context,
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(
                  context,
                )
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        body: Padding(
          padding: Responsive1.isMobile(context)
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.all(10),
          child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.25,
                    child: Stack(
                      children: [
                        // ColorFiltered(
                        //   colorFilter: ColorFilter.mode(
                        //       Colors.black.withOpacity(0.3), BlendMode.darken),
                        //   child:
                        Image.network(
                          widget.path,
                          //widget.path!=null?widget.path:"https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                        ),
                        // ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
                !isActive
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, top: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                UIBlock.block(context);
                                setPlanActive().then((value) {
                                  UIBlock.unblock(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Plan has been Activated")));
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        true, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(error.toString()),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              },
                              child: Text("Active Plan"),
                            ),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(margin, margin, 0, 0),
                  child: Text(
                    "Days",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.only(
                      left: height * 0.025,
                    ),
                    height: orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.09
                        : MediaQuery.of(context).size.height * 0.06,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.days,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            for (int i = 0; i < days.length; i++) {
                              setState(() {
                                days[i] = false;
                              });
                            }
                            setState(() {
                              days[index] = true;
                              dayNumber = index + 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.08,
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
                                color: days[index]
                                    ? selectedBgColor
                                    : unSelectedBgColor),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DDText(
                                    title: "Day",
                                    size: 11,
                                    weight: FontWeight.w300,
                                    color: days[index]
                                        ? selectedTextColor
                                        : unSelectedTextColor,
                                  ),
                                  DDText(
                                    title: (index + 1).toString(),
                                    size: 11,
                                    weight: FontWeight.w300,
                                    color: days[index]
                                        ? selectedTextColor
                                        : unSelectedTextColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(height: 20),
                /*Container(
                  margin: EdgeInsets.fromLTRB(margin, 10, margin, margin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Morning",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "8:30",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),*/
                FutureBuilder<MindDetailModel>(
                  future: fetchMindPlanDetail(widget.planId, dayNumber),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          padding: EdgeInsets.only(left: MySize.size14),
                          // margin: EdgeInsets.fromLTRB(0, 0, margin, margin),
                          child: ListView.builder(
                            itemCount: snapshot.data.mindPlans.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              bool isFavourite = false;
                              bool showcase = false;
                              if (index == 0) {
                                showcase = true;
                              }
                              favouriteItems.forEach((element) {
                                if (element.vidId ==
                                    snapshot.data.mindPlans[index].vidId)
                                  isFavourite = true;
                              });
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    Responsive1.isMobile(context)
                                        ? Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                            return VideoWidget(
                                                url:
                                                    '$videosBaseUrl${snapshot.data.mindPlans[index].videoFile}',
                                                play: true,
                                                videoId: snapshot.data
                                                    .mindPlans[index].vidId);
                                          }))
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 350,
                                                            right: 350,
                                                            bottom: 100,
                                                            top: 100),
                                                    child: VideoWidget(
                                                        url:
                                                            '$videosBaseUrl${snapshot.data.mindPlans[index].videoFile}',
                                                        play: true,
                                                        videoId: snapshot
                                                            .data
                                                            .mindPlans[index]
                                                            .vidId)));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          showcase
                                              ? Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, margin, 0),
                                                  height: height * 0.12,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.18,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            '$imageBaseUrl${snapshot.data.mindPlans[index].imageFile}',
                                                            // '${snapshot.data.imagePath}${snapshot.data.imagePath}',
                                                          ))),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, margin, 0),
                                                  height: height * 0.12,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.18,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            '$imageBaseUrl${snapshot.data.mindPlans[index].imageFile}',
                                                            // '${snapshot.data.imagePath}${snapshot.data.imagePath}',
                                                          ))),
                                                ),
                                          Container(
                                              height: orientation ==
                                                      Orientation.landscape
                                                  ? height * .21
                                                  : height * 0.12,
                                              width: Responsive1.isMobile(
                                                      context)
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3)
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                                .data
                                                                .mindPlans[
                                                                    index]
                                                                .title ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .grey[700],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Text(
                                                        "${snapshot.data.mindPlans[index].duration} min",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.blue,
                                                      ),
                                                      Text("")
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          showcase
                                                              ? IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    _dialog = SimpleFontelicoProgressDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDimisable:
                                                                            true);
                                                                    _dialog.show(
                                                                        message:
                                                                            "Please wait",
                                                                        type: SimpleFontelicoProgressDialogType
                                                                            .normal);
                                                                    setFavourite(snapshot
                                                                            .data
                                                                            .mindPlans[
                                                                                index]
                                                                            .vidId)
                                                                        .then((value) =>
                                                                            fetchFavourites());
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: isFavourite
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                )
                                                              : IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    _dialog = SimpleFontelicoProgressDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDimisable:
                                                                            true);
                                                                    _dialog.show(
                                                                        message:
                                                                            "Please wait",
                                                                        type: SimpleFontelicoProgressDialogType
                                                                            .normal);
                                                                    setFavourite(snapshot
                                                                            .data
                                                                            .mindPlans[
                                                                                index]
                                                                            .vidId)
                                                                        .then((value) =>
                                                                            fetchFavourites());
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: isFavourite
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
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
                                ),
                              );
                            },
                          ));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Data is not available'),
                      );
                    }

                    // By default, show a loading spinner.
                    return Shimmer.fromColors(
                      child: Padding(
                        padding: EdgeInsets.only(left: MySize.size14),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                  height: height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            widget.path,
                                            // '${snapshot.data.imagePath}${snapshot.data.imagePath}',
                                          ))),
                                ),
                                Container(
                                    height: height * 0.12,
                                    width: MediaQuery.of(context).size.width -
                                        (MediaQuery.of(context).size.width *
                                            0.3),
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
                                              'Lesson 1',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              "0 min",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              color: Colors.blue,
                                            ),
                                            Text("")
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.favorite,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
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
                      ),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
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

  Container daysRowUpdated(double margin, double height) {
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
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
