import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/FoodDialog.dart';
import 'package:weight_loser/widget/Shimmer/Food%20Dialog%20Shimmer.dart';

class FavouriteTabInnerPage extends StatefulWidget {
  const FavouriteTabInnerPage({Key key}) : super(key: key);

  @override
  _FavouriteTabInnerPageState createState() => _FavouriteTabInnerPageState();
}

class _FavouriteTabInnerPageState extends State<FavouriteTabInnerPage>
    with TickerProviderStateMixin {
  SimpleFontelicoProgressDialog _dialog;

  List<bool> days = [false, false, false, false, false, false, false];
  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[300];
  Color unSelectedTextColor = Colors.black;

  bool myDietisFavourite = false;
  bool myDietisAdded = false;

  bool myWorkoutisFavourite = false;
  bool myWorkoutisAdded = false;
  TabController _controller;
  int _activeTabIndex;

  void _setActiveTabIndex() {
    _activeTabIndex = _controller.index;
    setState(() {});
    print(_activeTabIndex);
  }

  TabController _tabController;
  int userid;
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
    _controller = TabController(vsync: this, length: 3);

    _controller.addListener(_setActiveTabIndex);
    fetchFoodFavourites();
    fetchExerciseFavourites();
    fetchMindFavourites();
  }

  addFoodItem(
      int typeId, foodId, cal, carb, fat, protein, serv, BuildContext context) {
    UIBlock.block(context);
    double servingDouble = double.parse(serv.toString());
    int serving = servingDouble.toInt();
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "FoodId": foodId,
        "Cons_Cal": cal,
        "ServingSize": serving,
        "fat": fat,
        "Protein": protein,
        "Carbs": carb
      }),
    ).then((value) {
      UIBlock.unblock(context);
      print("add meal plan item response ${value.statusCode} ${value.body}");
      final snackBar = SnackBar(
        content: Text(
          'Meal Added',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      UIBlock.unblock(context);
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
  addFoodItem(int typeId, Favourite_model food) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    double servingDouble = double.parse(food.servingSize.toString());
    int serving = servingDouble.toInt();
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "FoodId": "${food.foodId}",
        "Cons_Cal": food.calories,
        "ServingSize": serving,
        "fat": food.fat,
        "Protein": food.protein,
        "Carbs": food.carbs
      }),
    ).then((value) {
      print("add meal plan item response ${value.statusCode} ${value.body}");
      final snackBar = SnackBar(
        content: Text(
          'Meal Added',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
*/
  List<dynamic> favouriteFoodItems = [];
  List<dynamic> favouriteExerciseItems = [];
  List<dynamic> favouriteMindItems = [];

  bool isLoadingMindFavourites = true;
  bool isLoadingFavourites = true;
  bool isLoadingExerciseFavourites = true;

  Future<List<dynamic>> fetchFoodFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Food/$userid'),
    );
    if (response.statusCode == 200) {
      //Iterable l = json.decode(response.body);
      setState(() {
        favouriteFoodItems = json.decode(response.body)['favoriteFoodVMs'];
        //favouriteFoodItems = List<Favourite_model>.from(l.map((model) => Favourite_model.fromJson(model)));
        isLoadingFavourites = false;
      });
    } else {
      setState(() {
        isLoadingFavourites = false;
      });
      throw Exception('failed to load');
    }
    _dialog.hide();
  }

  Stream<bool> fetchExerciseFavourite(var burnerId) async* {
    List<FavouriteExerciseModel> favourites = [];
    bool isFavourite = false;
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Exercise/$userid'),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      favourites = List<FavouriteExerciseModel>.from(
          l.map((model) => FavouriteExerciseModel.fromJson(model)));
      favourites.forEach((element) {
        print(
            "favourite status ${element.favoriteExerciseVMs[0].burnerId}==$burnerId ");
        if (element.favoriteExerciseVMs[0].burnerId == burnerId) {
          setState(() {
            isFavourite = true;
          });
        }
      });
      yield isFavourite;
    } else {
      throw Exception('Failed to load favourite');
    }
    _dialog.hide();
  }

  Stream<bool> fetchFoodFavourite(String foodId) async* {
    List<Favourite_model> favourites = [];
    bool isFavourite = false;
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Food/1'),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      favourites = List<Favourite_model>.from(
          l.map((model) => Favourite_model.fromJson(model)));
      favourites.forEach((element) {
        if (element.foodId == foodId) {
          isFavourite = true;
        }
      });
      yield isFavourite;
    } else {
      throw Exception('Failed to load favourite');
    }
    _dialog.hide();
  }

  Future<Response> setFoodFavourite(String foodId) {
    return post(
      Uri.parse('$apiUrl/api/favourites/Food'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{"userId": userid, "FoodId": foodId}),
    );
  }

  addExercise(int typeId, FavouriteExerciseModel burner) {
    print("calories ${burner.favoriteExerciseVMs[0].calories}");
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "Duration": burner.favoriteExerciseVMs[0].duration,
        "BurnerId": burner.favoriteExerciseVMs[0].burnerId,
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

  Future<List<dynamic>> fetchExerciseFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Exercise/$userid'),
    );
    if (response.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      setState(() {
        favouriteExerciseItems =
            json.decode(response.body)['favoriteExerciseVMs'];
        //favouriteExerciseItems = List<FavouriteExerciseModel>.from(l.map((model) => FavouriteExerciseModel.fromJson(model)));
        isLoadingExerciseFavourites = false;
      });
    } else {
      setState(() {
        isLoadingFavourites = false;
      });
      throw Exception('Failed to load plan');
    }
    _dialog.hide();
  }

  Future<Response> setExerciseFavourite(var burnId) {
    return post(
      Uri.parse('$apiUrl/api/favourites/Exercise'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode(<String, dynamic>{"userId": userid, "ExerciseId": burnId}),
    );
  }

  Future<Response> setMindFavourite(int videoId) {
    print(userid.toString() + " : " + videoId.toString());
    return post(
      Uri.parse('$apiUrl/api/favourites/Mind'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{"userId": userid, "VidId": videoId}),
    );
  }

  Future<List<dynamic>> fetchMindFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Mind/$userid'),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      //Iterable l = json.decode(response.body);
      setState(() {
        favouriteMindItems = json.decode(response.body)['favoriteMindVMs'];
        // favouriteMindItems = List<FavouriteMindModel>.from(l.map((model) => FavouriteMindModel.fromJson(model)));
        isLoadingMindFavourites = false;
      });
    } else {
      setState(() {
        isLoadingMindFavourites = false;
      });
      throw Exception('Failed to load plan');
    }

    _dialog.hide();
  }

  Stream<bool> fetchMindFavourite(int vidId) async* {
    List<FavouriteMindModel> favourites = [];
    bool isFavourite = false;
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Mind/1'),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      favourites = List<FavouriteMindModel>.from(
          l.map((model) => FavouriteMindModel.fromJson(model)));
      favourites.forEach((element) {
        if (element.vidId == vidId) {
          isFavourite = true;
        }
      });
      yield isFavourite;
    } else {
      throw Exception('Failed to load favourite');
    }
    _dialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double heightOfTabBar = MediaQuery.of(context).size.height * 0.04;
    double heightOfBottomBar = MediaQuery.of(context).size.height * 0.07;
    double margin = height * 0.02;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? titleAppBar(context: context, title: "Favourites")
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      // appBar: titleAppBar(context: context, title: "Favourites"),
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
                      // ############### for changing the image of tab ###############
                      // _activeTabIndex == 0
                      //     ? 'assets/images/cognitive_1.png'
                      //     : _activeTabIndex == 1
                      //         ? 'assets/images/cognitive_2.png'
                      //         : _activeTabIndex == 2
                      //             ? "assets/images/cognitive_3.png"
                      //             : "assets/images/1.png",
                      "assets/images/fav.png",
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      height: heightOfTabBar,
                      child: TabBar(
                        controller: _controller,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.2, color: Colors.blue),
                          ),
                        ),
                        /*indicator:  UnderlineTabIndicator(
                            borderSide: BorderSide(width: 0.0,color: Colors.white),
                            insets: EdgeInsets.symmetric(horizontal:16.0)
                        ),*/
                        labelColor: Colors.blue,
                        labelStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: 'My Diets'),
                          Tab(text: 'Mind'),
                          Tab(text: 'My Workouts'),
                        ],
                      ),
                    ),
                    Container(
                      height: height -
                          (AppBar().preferredSize.height +
                              heightOfTabBar +
                              heightOfBottomBar),
                      child: TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          //favourite diet tab
                          favouriteFoodItems == null
                              ? Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  alignment: Alignment.topCenter,
                                  child: const Text("No favourites"),
                                )
                              : myDietSection(margin, height),
                          // Mind Tab View
                          favouriteMindItems.length == 0
                              ? Container(
                                  margin: EdgeInsets.only(top: 50),
                                  alignment: Alignment.topCenter,
                                  child: Text("No favourites"),
                                )
                              : mindSection(margin, height),

                          //favourite workout tab
                          favouriteExerciseItems.length == 0
                              ? Container(
                                  margin: EdgeInsets.only(top: 50),
                                  alignment: Alignment.topCenter,
                                  child: Text("No favourites"),
                                )
                              : myWorkoutsSection(margin, height),
                        ],
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
  }

  Widget leftRightheading({left, right}) {
    return Container(
      padding: EdgeInsets.only(
        // left: MySize.size2,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: TextField(
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: left,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.openSans(
                  fontSize: MySize.size15, color: Colors.black),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: right,
                hintStyle: GoogleFonts.openSans(
                    fontSize: MySize.size15, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container myWorkoutsSection(double margin, double height) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size20, right: MySize.size10),
      // margin: EdgeInsets.fromLTRB(margin, 0, margin, margin),
      child: ListView.builder(
        itemCount: favouriteExerciseItems.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPlansExercise()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoWidget(
                              url:
                                  '$videosBaseUrl${favouriteExerciseItems[index]['VideoFile']}',
                              play: true,
                              //videoId: favouriteExerciseItems[index]['Id'],
                            )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                        height: height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '$imageBaseUrl${favouriteExerciseItems[index]['FileName']}',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      favouriteExerciseItems[index]['Name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "${favouriteExerciseItems[index]['duration']} minutes",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${favouriteExerciseItems[index]['Calories'].toStringAsFixed(1)} kcal",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _dialog =
                                              SimpleFontelicoProgressDialog(
                                                  context: context,
                                                  barrierDimisable: true);
                                          _dialog.show(
                                              message: "Please wait",
                                              type:
                                                  SimpleFontelicoProgressDialogType
                                                      .normal);
                                          setExerciseFavourite(
                                                  favouriteExerciseItems[index]
                                                      ['burnerId'])
                                              .then((value) {
                                            print(
                                                "fav result ${value.statusCode} ${value.body}");
                                            fetchExerciseFavourites();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            addExercise(5,
                                                favouriteExerciseItems[index]);
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
                              ),
                            )
                          ],
                        ),
                      ),
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
      ),
    );
  }

  Container mindSection(double margin, double height) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: MySize.size20, right: MySize.size10),
            child: ListView.builder(
              itemCount: favouriteMindItems.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMindPlansView()));
                      Responsive1.isMobile(context)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoWidget(
                                      url:
                                          '$videosBaseUrl${favouriteMindItems[index]['VideoFile']}',
                                      play: true,
                                      videoId: favouriteMindItems[index]
                                          ['vidId'])))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 100,
                                            right: 100,
                                            top: 50,
                                            bottom: 50),
                                        child: VideoWidget(
                                            url:
                                                '$videosBaseUrl${favouriteMindItems[index]['VideoFile']}',
                                            play: true,
                                            videoId: favouriteMindItems[index]
                                                ['vidId']),
                                      )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                  height: height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.network(
                                      '$imageBaseUrl${favouriteMindItems[index]['ImageFile']}',
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              favouriteMindItems[index]
                                                      ['Title'] ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              favouriteMindItems[index]
                                                          ['duration']
                                                      .toString() +
                                                  " sec",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _dialog =
                                                      SimpleFontelicoProgressDialog(
                                                          context: context,
                                                          barrierDimisable:
                                                              true);
                                                  _dialog.show(
                                                      message: "Please wait",
                                                      type:
                                                          SimpleFontelicoProgressDialogType
                                                              .normal);
                                                  setMindFavourite(
                                                          favouriteMindItems[
                                                              index]['vidId'])
                                                      .then((value) =>
                                                          fetchMindFavourites());
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  MdiIcons.plus,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
            ),
          ),
        ],
      ),
    );
  }

  Container myDietSection(double margin, double height) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size20, right: MySize.size10),
      // margin: EdgeInsets.fromLTRB(
      //     margin, 0, margin, margin),
      child: ListView.builder(
        itemCount: favouriteFoodItems.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _dialog = SimpleFontelicoProgressDialog(
                        context: context, barrierDimisable: true);
                    _dialog.show(
                        message: "Please wait",
                        type: SimpleFontelicoProgressDialogType.normal);
                    print("Id ${favouriteFoodItems[index]['FoodId']}");
                    fetchRecipe(int.parse(favouriteFoodItems[index]['FoodId']))
                        .then((value) {
                      _dialog.hide();
                      showFoodDialog(
                        context,
                        favouriteFoodItems[index]['Name'],
                        favouriteFoodItems[index]['ServingSize'],
                        favouriteFoodItems[index]['Calories'],
                        favouriteFoodItems[index]['Carbs'],
                        favouriteFoodItems[index]['fat'],
                        favouriteFoodItems[index]['Protein'],
                        favouriteFoodItems[index]['Description'],
                        '${imageBaseUrl}${favouriteFoodItems[index]['FileName']}',
                        favouriteFoodItems[index]['Cuisine'],
                        favouriteFoodItems[index]['FoodId'],
                      );
                    }).onError((error, stackTrace) {
                      _dialog.hide();
                      _showDialog("Error", error);
                    });
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return MyPlansView();
                    // }));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                        height: height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '$imageBaseUrl${favouriteFoodItems[index]['FileName']}',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      favouriteFoodItems[index]['Name'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  /*
                                  Container(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "${favouriteFoodItems[index]['ServingSize']} grams",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  */
                                  /*
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.blue,
                                  )
                                  */
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${favouriteFoodItems[index]['Calories']} kcal",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _dialog =
                                              SimpleFontelicoProgressDialog(
                                                  context: context,
                                                  barrierDimisable: true);
                                          _dialog.show(
                                              message: "Please wait",
                                              type:
                                                  SimpleFontelicoProgressDialogType
                                                      .normal);
                                          setFoodFavourite(
                                                  favouriteFoodItems[index]
                                                      ['FoodId'])
                                              .then((value) =>
                                                  fetchFoodFavourites());
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("Favorite Food:" +
                                              favouriteFoodItems[index]
                                                  .toString());
                                          setState(() {
                                            addFoodItem(
                                                3,
                                                favouriteFoodItems[index]
                                                    ['FoodId'],
                                                favouriteFoodItems[index]
                                                    ['Calories'],
                                                favouriteFoodItems[index]
                                                    ['Carbs'],
                                                favouriteFoodItems[index]
                                                    ['fat'],
                                                favouriteFoodItems[index]
                                                    ['Protein'],
                                                favouriteFoodItems[index]
                                                    ['ServingSize'],
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey, thickness: 0.3)
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
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
  }
}

int selectedEatingTime = 0;

showFoodDialog(BuildContext context, title, serving, cal, carb, fat, protein,
    description, imageurl, mealtype, foodId) {
  SimpleFontelicoProgressDialog _dialog;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      var id = int.parse(foodId);
      print(id);
      var other;
      return StatefulBuilder(
        builder: (context, setState) {
          var size = MediaQuery.of(context).size.width;
          var mobile = Responsive1.isMobile(context);
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: mobile
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.only(left: 400, right: 400, top: 10),
              child: Container(
                width: mobile ? double.infinity : 500,
                height: mobile ? double.infinity : 560,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            mobile ? EdgeInsets.all(8.0) : EdgeInsets.all(2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.20
                                  : size * 0.15,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(imageurl)
                                          //'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  title,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '${serving} Serving, ${serving} grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  // width:55,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: FutureBuilder(
                                      future: fetchOtherDetail(id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.done) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              snapshot.data['Cuisine'] ??
                                                  "indian",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        } else if (snapshot.hasData &&
                                            snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.grey[100],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "indian",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "             ",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        );
                                      }),
                                ),
                                // Row(
                                //   children: [
                                //     Container(
                                //       // width:55,
                                //       height: 25,
                                //       decoration: BoxDecoration(
                                //           border:
                                //               Border.all(color: Colors.grey),
                                //           borderRadius:
                                //               BorderRadius.circular(100)),
                                //       child: FutureBuilder(
                                //           future: fetchOtherDetail(id),
                                //           builder: (context, snapshot) {
                                //             return Padding(
                                //               padding:
                                //                   const EdgeInsets.all(4.0),
                                //               child: Text(
                                //                 snapshot.data['Cuisine'],
                                //                 style: GoogleFonts.montserrat(
                                //                     fontSize: 12,
                                //                     color: Colors.grey),
                                //               ),
                                //             );
                                //           }),
                                //     ),
                                //     SizedBox(
                                //       width: MediaQuery.of(context).size.width *
                                //           0.02,
                                //     ),
                                //     Container(
                                //       decoration: BoxDecoration(
                                //           color: Colors.red[100],
                                //           borderRadius:
                                //               BorderRadius.circular(100)),
                                //       child: Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: 4, horizontal: 10),
                                //         child: Text(
                                //           'Keton: Avoid',
                                //           style: GoogleFonts.montserrat(
                                //               fontSize: 9, color: Colors.red),
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              height: mobile
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : size * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey, width: .5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cals',
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  Text(
                                    "${cal.toString()}",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mobile
                                  ? MediaQuery.of(context).size.width * 0.03
                                  : size * .02,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: Responsive1.isMobile(context),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${carb}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 15,
                                      child: FutureBuilder(
                                          future: fetchOtherDetail(id),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.done) {
                                              return Text(
                                                '${snapshot.data['SatFat'] + snapshot.data['Sodium'] + snapshot.data['Fiber']}g',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              );
                                            } else if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
                                                child: Text(
                                                  // '${other ?? 0}g',
                                                  '0g',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              );
                                            }
                                            return Text(
                                              // '${other ?? 0}g',
                                              '0g',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            );
                                          }),
                                    ),
                                    // Text(
                                    //   '${other??0}g',
                                    //   style: GoogleFonts.montserrat(
                                    //       fontSize: 12, color: Colors.grey),
                                    // ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: mobile
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 2;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEatingTime = 3;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              serving.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      FutureBuilder(
                          future: fetchRecipe1(id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var desc =
                                  snapshot.data['Ingredients'].split(",");
                              print("Desc ${desc.length}");
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 0;
                                                });
                                              },
                                              child: Text(
                                                'Ingredients',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                0
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 0
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  ingredientOrProcedure = 1;
                                                });
                                              },
                                              child: Text(
                                                'Procedure',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        ingredientOrProcedure ==
                                                                1
                                                            ? Colors.black
                                                            : Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.001,
                                            ),
                                            ingredientOrProcedure == 1
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xff4885ED)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: .5)),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: ingredientOrProcedure == 1
                                              ? Text(
                                                  snapshot.data['Procedure']
                                                      .replaceAll("<p>", "")
                                                      .replaceAll("</p>", ""),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                )
                                              : ingredientOrProcedure == 0
                                                  ? ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: desc.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        print(desc.length);
                                                        return Text(
                                                          desc[index]
                                                              .replaceAll(
                                                                  "[", "")
                                                              .replaceAll(
                                                                  "\"", "")
                                                              .replaceAll(
                                                                  "]", ""),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                        );
                                                      },
                                                    )
                                                  : Text(
                                                      "Not Avaliable",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                    )
                                          // child: Text(
                                          //   ingredientOrProcedure == 1
                                          //       ? snapshot.data['Procedure']
                                          //       .replaceAll("<p>", "")
                                          //       .replaceAll("</p>", "")
                                          //       : ingredientOrProcedure == 0
                                          //       ? snapshot.data['Description']
                                          //       .replaceAll("[", "")
                                          //       .replaceAll("]", "")
                                          //       : "Not Available",
                                          //   style: GoogleFonts.montserrat(
                                          //       fontSize: 12, color: Colors.grey),
                                          // ),
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return FoodDialogShimmer();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _dialog = SimpleFontelicoProgressDialog(
                                  context: context, barrierDimisable: true);
                              _dialog.show(
                                  message: "Please wait",
                                  type:
                                      SimpleFontelicoProgressDialogType.normal);
                              print(mealtype);
                              double servingDouble =
                                  double.parse(serving.toString());
                              int servings = servingDouble.toInt();
                              var typeId;
                              if (selectedEatingTime == 0) {
                                typeId = 1;
                              } else if (selectedEatingTime == 1) {
                                typeId = 2;
                              } else if (selectedEatingTime == 2) {
                                typeId = 3;
                              } else if (selectedEatingTime == 3) {
                                typeId = 4;
                              }
                              post(
                                Uri.parse('$apiUrl/api/diary'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "userId": userid,
                                  "F_type_id": typeId,
                                  "FoodId": id.toString(),
                                  "Cons_Cal": cal,
                                  "ServingSize": servings,
                                  "fat": fat,
                                  "Protein": protein,
                                  "Carbs": carb
                                }),
                              ).then((value) {
                                _dialog.hide();
                                print(value.body);

                                /*final snackBar = SnackBar(
                                        content: Text(
                                          'Meal Added',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.lightGreen,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);*/
                                Navigator.pop(context, true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarNew(0)));
                              }).onError((error, stackTrace) {
                                _dialog.hide();
                                print("Error ${error.toString}");
                                DDToast().showToast(
                                    "message", error.toString(), false);
                                // "message", error.toString(), true);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    },
  );
}
