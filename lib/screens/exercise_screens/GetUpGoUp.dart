import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/exercise_plan_model.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/screens/navigation_tabs/ExerciseSceen.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

class GetUpGoUp extends StatefulWidget {
  int planId;
  String name, path;
  int days;

  GetUpGoUp(this.path, this.name, this.planId, this.days);

  @override
  _GetUpGoUpState createState() => _GetUpGoUpState();
}

class _GetUpGoUpState extends State<GetUpGoUp> with TickerProviderStateMixin {
  List<Burners> sets = [];
  SimpleFontelicoProgressDialog _dialog;
  bool loadingData = true;
  GlobalKey<FormState> _exeDays = GlobalKey<FormState>();
  GlobalKey<FormState> _exeFoodDetails = GlobalKey<FormState>();
  GlobalKey<FormState> _exeReplace = GlobalKey<FormState>();
  GlobalKey<FormState> _exeFavorite = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _exeAddMeal = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("singleexeshowcaseStatus");
  }

  fetchBurners(int id, int day) async {
    setState(() {
      loadingData = true;
    });
    print("plan $id");
    print("plan day $day");
    print(
        "plan hit URLLL ${'$apiUrl/api/plan/ExercisePlan?planId=$id&day=$day'}");
    final response = await get(
      Uri.parse('$apiUrl/api/plan/ExercisePlan?planId=$id&day=$day'),
    );

    if (response.statusCode == 200) {
      int setId = 0;
      ExercisePlanModel model =
          ExercisePlanModel.fromJson(jsonDecode(response.body));
      setState(() {
        sets = model.burners;

        /*sets.add([]);
        sets[setId].add(model.burners[0]);
        for(int i=1;i<model.burners.length;i++){
          print("compare ${sets[setId][sets[setId].length-1].title} != ${model.burners[i].title}");
          if(sets[setId][sets[setId].length-1].title!=model.burners[i].title){
            print("up");
            setId=setId+1;
            sets.add([]);
            print("up $setId");
            sets[setId].add(model.burners[i]);
          }
          else{
            print("down");
            sets[setId].add(model.burners[i]);
          }

        }
        print("set all list ${sets.length}");
        sets.forEach((element) {
          element.forEach((burner) {
            print("set list ${element.length} ${burner.title}");
          });

        });*/
      });
    } else {
      setState(() {
        loadingData = false;
      });
      throw Exception('No exercises');
    }
  }

  addExercise(int typeId, Burners burner, BuildContext context) {
    print("calories ${burner.calories}");
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "Duration": burner.duration,
        "BurnerId": burner.burnerId,
        "Burn_Cal": burner.calories
      }),
    ).then((value) {
      if (value.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text(
            'Exercise Added',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text(
            "Unable to add exercise",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

/*
  Stream<bool> fetchFavourite(int burnerId) async* {
    List<FavouriteExerciseModel> favourites = [];
    bool isFavourite = false;
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Exercise/1'),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      favourites = List<FavouriteExerciseModel>.from(
          l.map((model) => FavouriteExerciseModel.fromJson(model)));
      favourites.forEach((element) {
        if (element.burnerId == burnerId) {
          isFavourite = true;
        }
      });
      yield isFavourite;
    } else {
      throw Exception('Failed to load favourite');
    }
    _dialog.hide();
  }
*/
  FavouriteExerciseModel favmodel;
  List<FavoriteExerciseVMs> favouriteItems = [];
  List<bool> isFavorite = [];

  bool isLoadingFavourites = true;

  fetchFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Exercise/$userid'),
    );
    if (response.statusCode == 200) {
      var l = json.decode(response.body);
      favmodel = FavouriteExerciseModel.fromJson(l);

      setState(() {
        favouriteItems = favmodel.favoriteExerciseVMs;
        //favouriteItems = List<FavouriteExerciseModel>.from(
        //  l.map((model) => FavouriteExerciseModel.fromJson(model)));
        isLoadingFavourites = false;
      });
    } else {
      setState(() {
        isLoadingFavourites = false;
      });
      throw Exception('Failed to load favourites');
    }
    _dialog.hide();
  }

  Future<Response> setFavourite(int burnerId) {
    return post(
      Uri.parse('$apiUrl/api/favourites/Exercise'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, dynamic>{"userId": userid, "ExerciseId": burnerId}),
    );
  }

  List<bool> days = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.days; i++) {
      if (i == 0) {
        days.add(true);
      } else
        days.add(false);
    }
    fetchBurners(widget.planId, 1);
    fetchActivePlans();
    fetchFavourites();
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _exeDays,
            _exeFoodDetails,
            _exeFavorite,
            // _dietCustomAddFood,
            _exeAddMeal
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
        print("active list item id ${element.planId} == ${widget.planId}");
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

  /* @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(2);
  }
*/
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;

  bool isFavourite = false;
  bool isAdded = false;
  int dayNumber = 1;
  int userid;
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
        "Type": "exercise"
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double margin = height * 0.01;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        /*bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          shape: CircularNotchedRectangle(),
          notchMargin: MySize.size10,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MySize.size20),
                  topRight: Radius.circular(MySize.size20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: MySize.size2,
                  offset: Offset(
                    0,
                    0,
                  ), // Shadow position
                ),
              ],
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    minWidth: MySize.size50,
                    onPressed: () {
                      setState(
                        () {
                          // currentScreen = DashboardScreen();
                          // _selectedIndex = 0;
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MySize.size4, left: MySize.size6),
                      child: Image.asset(
                        "assets/icons/home.png",
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    minWidth: MySize.size50,
                    onPressed: () {
                      setState(
                        () {
                          // _selectedIndex = 1;
                          // currentScreen = DiaryView();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.size4),
                      child: Image.asset(
                        "assets/icons/diaryy.png",
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    hoverColor: Colors.transparent,
                    minWidth: MySize.size50,
                    onPressed: () {
                      setState(
                        () {
                          // _selectedIndex = 2;
                          // currentScreen = LiveTrackingView();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.size4),
                      child: Image.asset(
                        "assets/icons/watch.png",
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    minWidth: MySize.size50,
                    onPressed: () {
                      setState(
                        () {
                          // currentScreen = FavouriteTabInnerPage();
                          // _selectedIndex = 3;
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.size4),
                      child: Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(MySize.size8),
                  child: Container(
                    width: MySize.size44,
                    height: MySize.size44,
                    decoration: BoxDecoration(
                      color: Color(0xff4885ED),
                      border: Border.all(
                        color: Color(0xff4885ED),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(MySize.size30),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        print("add pressed");
                        setState(
                          () {
                            // _selectedIndex = 4;
                          },
                        );
                      },
                      icon: Icon(
                        MdiIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),*/
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
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(15.0),
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
                        Image.network(
                          widget.path,
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                        ),
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
                                  Navigator.pop(context, true);
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

                Container(
                  margin: EdgeInsets.fromLTRB(margin, 10, 0, 10),
                  child: Text(
                    "Days",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: height * 0.025,
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
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
                              sets = [];
                              fetchBurners(widget.planId, dayNumber);
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
                if (sets.length == 0 && !loadingData)
                  Center(
                    child: Text("No Exercises"),
                  ),
                Container(
                    margin: EdgeInsets.fromLTRB(margin, 0, margin, margin),
                    child: ListView.builder(
                      itemCount: sets.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        bool showcase = false;
                        bool isFavourite = false;
                        if (index == 0) {
                          showcase = true;
                        }
                        favouriteItems.forEach((element) {
                          if (element.burnerId == sets[index].burnerId)
                            isFavourite = true;
                        });
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      /* VideoPlayerController videoController= VideoPlayerController.network('$videosBaseUrl${sets[index].videoFile}');

                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return VideoItem(videoPlayerController: videoController,
                                          looping: false,
                                          autoplay: true,
                                        );
                                      }));*/
                                      Responsive1.isMobile(context)
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    ExerciseScreen(sets, index),
                                              ),
                                            )
                                          : showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 300,
                                                              right: 300,
                                                              bottom: 50,
                                                              top: 50),
                                                      child: ExerciseScreen(
                                                          sets, index)));
                                    },
                                    child: showcase
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
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      '$imageBaseUrl${sets[index].fileName}',
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
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      '$imageBaseUrl${sets[index].fileName}',
                                                    ))),
                                          ),
                                  ),
                                  Container(
                                      height: height * 0.12,
                                      width: Responsive1.isMobile(context)
                                          ? MediaQuery.of(context).size.width -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.31)
                                          : MediaQuery.of(context).size.width *
                                              0.3,
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
                                                "${sets[index].name}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                "${sets[index].duration} minutes",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w300),
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
                                                "${sets[index].calories.toStringAsFixed(1)} kcal",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  showcase
                                                      ? IconButton(
                                                          onPressed: () {
                                                            _dialog =
                                                                SimpleFontelicoProgressDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDimisable:
                                                                        true);
                                                            _dialog.show(
                                                                message:
                                                                    "Please wait",
                                                                type:
                                                                    SimpleFontelicoProgressDialogType
                                                                        .normal);
                                                            setFavourite(sets[
                                                                        index]
                                                                    .burnerId)
                                                                .then((value) =>
                                                                    fetchFavourites());
                                                          },
                                                          icon: Icon(
                                                            Icons.favorite,
                                                            color: isFavourite
                                                                ? Colors.red
                                                                : Colors.grey,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            _dialog =
                                                                SimpleFontelicoProgressDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDimisable:
                                                                        true);
                                                            _dialog.show(
                                                                message:
                                                                    "Please wait",
                                                                type:
                                                                    SimpleFontelicoProgressDialogType
                                                                        .normal);
                                                            setFavourite(sets[
                                                                        index]
                                                                    .burnerId)
                                                                .then((value) =>
                                                                    fetchFavourites());
                                                          },
                                                          icon: Icon(
                                                            Icons.favorite,
                                                            color: isFavourite
                                                                ? Colors.red
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  showcase
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              addExercise(
                                                                  5,
                                                                  sets[index],
                                                                  context);
                                                            });
                                                          },
                                                          child: Icon(
                                                            MdiIcons.plus,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              addExercise(
                                                                  5,
                                                                  sets[index],
                                                                  context);
                                                            });
                                                          },
                                                          child: Icon(
                                                            MdiIcons.plus,
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
                    ))
                /*ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sets.length,
                  itemBuilder: (BuildContext context,int index){
                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(margin, 10, margin, margin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sets[index].title,
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ],
                            )
                        ),


                      ],
                    );
                  },*/
                //),
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
