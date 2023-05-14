import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/AuthService.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/food_plan_model.dart';
import 'package:weight_loser/models/food_recipe_model.dart';
import 'package:weight_loser/models/stats_model.dart';
import 'package:weight_loser/screens/food_screens/replaceDietPlan.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/FoodDialog.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

class DietInnerTab extends StatefulWidget {
  int planId;
  int days;
  String path;
  String name;

  DietInnerTab(this.path, this.name, this.planId, this.days);

  @override
  _DietInnerTabState createState() => _DietInnerTabState();
}

List<bool> days = [];
Color selectedBgColor = Colors.blue;
Color selectedTextColor = Colors.white;
Color unSelectedBgColor = Colors.grey[100];
Color unSelectedTextColor = Colors.black;
int userid;

class _DietInnerTabState extends State<DietInnerTab>
    with TickerProviderStateMixin {
  SimpleFontelicoProgressDialog _dialog;
  GlobalKey<FormState> _dietDays = GlobalKey<FormState>();
  GlobalKey<FormState> _dietFoodDetails = GlobalKey<FormState>();
  GlobalKey<FormState> _dietReplace = GlobalKey<FormState>();
  GlobalKey<FormState> _dietFavorite = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _dietAddMeal = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("singledietshowcaseStatus");
  }

  addedmealsnackbar(context) {
    final snackBar = SnackBar(
      content: Text(
        'Meal Added',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.lightGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Stream<bool> fetchFavourite(String foodId) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    List<Favourite_model> favourites = [];
    bool isFavourite = false;
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Food/$userid'),
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

  // Future<List<FoodRecipeModel>> fetchRecipe(String foodId) async {
  //   final response = await get(
  //     Uri.parse('$apiUrl/api/FoodDetails/FoodDetail?FoodId=$foodId'),
  //   );
  //   if (response.statusCode == 200) {
  //     Iterable l = json.decode(response.body);
  //     return List<FoodRecipeModel>.from(l.map((model) => FoodRecipeModel.fromJson(model)));
  //   } else {
  //     throw Exception('Failed to load plan');
  //   }
  // }

  List<dynamic> favouriteItems = [];
  List<bool> isFavorite = [];

  Future<List<FoodRecipeModel>> fetchRecipe(String foodId) async {
    final response = await get(
      Uri.parse('$apiUrl/api/FoodDetails/FoodDetail?FoodId=$foodId'),
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<FoodRecipeModel>.from(
          l.map((model) => FoodRecipeModel.fromJson(model)));
    } else {
      throw Exception('Failed to load plan');
    }
  }

  bool isLoadingFavourites = true;
  Color color = Colors.blue;

  Future fetchFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    print("fetch favourite for Uid:" + userid.toString());

    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Food/$userid'),
    );
    if (response.statusCode == 200) {
      //Iterable l = json.decode(response.body);
      print("Favourite Items:" +
          json.decode(response.body)['favoriteFoodVMs'].toString());

      setState(() {
        //favouriteItems = List<Favourite_model>.from(l.map((model) => Favourite_model.fromJson(model)));
        favouriteItems = json.decode(response.body)['favoriteFoodVMs'];

        isLoadingFavourites = false;
      });
    } else {
      setState(() {
        isLoadingFavourites = false;
      });
      throw Exception('Failed to load plan');
    }
    _dialog.hide();
  }

  int dayNumber = 1;
  List<bool> days = [];
  int userid;
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.days; i++) {
      if (i == 0) {
        days.add(true);
      } else
        days.add(false);
    }
    fetchFoodPlanDetail(widget.planId, dayNumber);
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
            _dietDays,
            _dietFoodDetails,

            _dietFavorite,
            // _dietCustomAddFood,
            _dietAddMeal
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
  }

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

  bool isAdded = false;

  Future<Response> setPlanActive() {
    return post(
      Uri.parse('$apiUrl/api/activeplans/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "PlanId": widget.planId,
        "Type": "diet"
      }),
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

  Future<Response> setFavourite(String foodId) async {
    print(userid.toString() + " : " + foodId.toString());
    var response = await post(
      Uri.parse('$apiUrl/api/favourites/Food'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{"userId": userid, "FoodId": foodId}),
    );
    return response;
  }

  List<dynamic> breakfast = [];
  List<dynamic> lunch = [];
  List<dynamic> dinner = [];
  List<dynamic> snacks = [];

  fetchFoodPlanDetail(int id, int day) async {
    //_dialog =
    //  SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    //_dialog.show(
    //  message: "Please wait", type: SimpleFontelicoProgressDialogType.normal);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    //setState(() {
    breakfast.clear();
    lunch.clear();
    dinner.clear();
    snacks.clear();
    //});
    print("plan $id");
    UIBlock.block(context);
    final response = await get(
      Uri.parse(
          '$apiUrl/api/plan/UserFoodPlan?planId=$id&day=$day&userId=$userid'),
      // Uri.parse('$apiUrl/api/plan/FoodPlan?planId=$id&day=$day'),
    );
    print("Diet Deatil ${response.body}");
    if (response.statusCode == 200) {
      //_dialog.hide();
      UIBlock.unblock(context);
      List<dynamic> model = jsonDecode(response.body)['foodList'];
      model.forEach((element) {
        if (element['MealType'].toString().toLowerCase() == "breakfast")
          //setState(() {
          breakfast.add(element);
        //});
        else if (element['MealType'].toString().toLowerCase() == "dinner") {
          //setState(() {
          dinner.add(element);
          //});
        } else if (element['MealType'].toString().toLowerCase() == "snacks") {
          //setState(() {
          snacks.add(element);
          //});
        } else {
          //setState(() {
          lunch.add(element);
          //});
        }
      });
      setState(() {});
    } else {
      print("meal response ${response.statusCode} ${response.body}");
      throw Exception('No meal plans');
    }
  }

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // double heightOfTabBar = MediaQuery.of(context).size.height * 0.04;
    // double heightOfBottomBar = MediaQuery.of(context).size.height * 0.07;
    double margin = height * 0.02;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //bottomNavigationBar: CustomStaticBottomNavigationBar(),
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(context)
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        body: !isLoadingFavourites
            ? Padding(
                padding: Responsive1.isMobile(context)
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.all(10.0),
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      headerSection(context, height),
                      !isActive
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {
                                      UIBlock.block(context);
                                      setPlanActive().then((value) {
                                        UIBlock.unblock(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Plan has been Activated")));
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
                      // SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.fromLTRB(margin, 0, 0, 10),
                        child: Text(
                          "Days",
                          style: TextStyle(fontSize: 15, color: black),
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
                                    fetchFoodPlanDetail(
                                        widget.planId, dayNumber);
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Morning",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                            ],
                          )),
                      if (breakfast.length == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Meals",
                              style: TextStyle(fontSize: 15, color: black),
                            ),
                          ],
                        ),
                      ListView.builder(
                        itemCount: breakfast.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isFavourite = false;
                          if (favouriteItems != null)
                            favouriteItems.forEach((element) {
                              if (breakfast[index]['FoodId'] ==
                                  (element['FoodId'])) isFavourite = true;
                            });

                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _dialog = SimpleFontelicoProgressDialog(
                                            context: context,
                                            barrierDimisable: true);
                                        _dialog.show(
                                            message: "Please wait",
                                            type:
                                                SimpleFontelicoProgressDialogType
                                                    .normal);
                                        // fetchRecipe(breakfast[index].foodId)
                                        //     .then((value) => _showRecipeDialog(breakfast[index], value))
                                        //     .onError((error, stackTrace) => _showDialog("Error", error));
                                        print(
                                            "Id ${breakfast[index]['FoodId']}");
                                        fetchRecipe(breakfast[index]['FoodId'])
                                            .then((value) {
                                          _dialog.hide();
                                          showFoodDialog(
                                            context,
                                            () {
                                              addedmealsnackbar(context);
                                            },
                                            breakfast[index]['Name'],
                                            breakfast[index]['ServingSize'],
                                            breakfast[index]['Calories'],
                                            breakfast[index]['Carbs'],
                                            breakfast[index]['fat'],
                                            breakfast[index]['Protein'],
                                            breakfast[index]['Description'],
                                            '${imageBaseUrl}${breakfast[index]['FileName']}',
                                            breakfast[index]['MealType'],
                                            0,
                                            breakfast[index]['FoodId'],
                                          );
                                        }).onError((error, stackTrace) =>
                                                _showDialog("Error", error));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, 0, margin, 0),
                                        height: height * 0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  '${imageBaseUrl}${breakfast[index]['FileName']}',
                                                ))),
                                      ),
                                    ),
                                    Container(
                                        height: height * 0.12,
                                        width: Responsive1.isMobile(context)
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    breakfast[index]['Name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Text(
                                                  "${breakfast[index]['ServingSize']} Grams",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                isActive
                                                    ? IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ReplaceDietPlan(
                                                                        eatingTime:
                                                                            0,
                                                                        foodId:
                                                                            int.parse(breakfast[index]['FoodId'].toString()),
                                                                        planId:
                                                                            int.parse(breakfast[index]['PlanId'].toString()),
                                                                        reLoad:
                                                                            () {
                                                                          print(
                                                                              "reload Changes Now");
                                                                          setState(
                                                                              () {
                                                                            fetchFoodPlanDetail(widget.planId,
                                                                                dayNumber);
                                                                          });
                                                                        },
                                                                      )));
                                                        },
                                                        icon: Icon(
                                                            Icons.find_replace),
                                                      )
                                                    :
                                                    // Icon(
                                                    //   Icons.play_arrow,
                                                    //   color: Colors.blue,
                                                    // )
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
                                                  "${breakfast[index]['Calories']} kcal",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),

                                                    IconButton(
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
                                                        setFavourite(
                                                                breakfast[index]
                                                                    ['FoodId'])
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        //setState(() {

                                                        addFoodItem(
                                                            1,
                                                            breakfast[index]
                                                                ['FoodId'],
                                                            breakfast[index]
                                                                ['Calories'],
                                                            breakfast[index]
                                                                ['Carbs'],
                                                            breakfast[index]
                                                                ['fat'],
                                                            breakfast[index]
                                                                ['Protein'],
                                                            breakfast[index]
                                                                ['ServingSize'],
                                                            context);
                                                        //});
                                                      },
                                                      child: Icon(
                                                        MdiIcons.plus,
                                                        color: primaryColor,
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
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Snacks",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                            ],
                          )),
                      if (snacks.length == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Meals",
                              style: TextStyle(fontSize: 15, color: black),
                            ),
                          ],
                        ),
                      ListView.builder(
                        itemCount: snacks.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isFavourite = false;
                          if (favouriteItems != null)
                            favouriteItems.forEach((element) {
                              if (snacks[index]['FoodId'] ==
                                  (element['FoodId'])) {
                                print("snack fav id:" + element['FoodId']);
                                isFavourite = true;
                              }
                            });
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _dialog = SimpleFontelicoProgressDialog(
                                            context: context,
                                            barrierDimisable: true);
                                        _dialog.show(
                                            message: "Please wait",
                                            type:
                                                SimpleFontelicoProgressDialogType
                                                    .normal);

                                        // fetchRecipe(snacks[index].foodId)
                                        //     .then((value) => _showRecipeDialog(snacks[index], value))
                                        //     .onError((error, stackTrace) => _showDialog("Error", error));
                                        print("Id ${snacks[index]['FoodId']}");
                                        fetchRecipe(snacks[index]['FoodId'])
                                            .then((value) {
                                          _dialog.hide();
                                          showFoodDialog(
                                            context,
                                            () {
                                              addedmealsnackbar(context);
                                            },
                                            snacks[index]['Name'],
                                            snacks[index]['ServingSize'],
                                            snacks[index]['Calories'],
                                            snacks[index]['Carbs'],
                                            snacks[index]['fat'],
                                            snacks[index]['Protein'],
                                            snacks[index]['Description'],
                                            '${imageBaseUrl}${snacks[index]['FileName']}',
                                            snacks[index]['MealType'],
                                            1,
                                            snacks[index]['FoodId'],
                                          );
                                        }).onError((error, stackTrace) =>
                                                _showDialog("Error", error));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, 0, margin, 0),
                                        height: height * 0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  '${imageBaseUrl}${snacks[index]['FileName']}',
                                                ))),
                                      ),
                                    ),
                                    Container(
                                        height: height * 0.12,
                                        width: Responsive1.isMobile(context)
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    snacks[index]['Name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Text(
                                                  "${snacks[index]['ServingSize']} Grams",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                isActive
                                                    ? IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ReplaceDietPlan(
                                                                        eatingTime:
                                                                            1,
                                                                        foodId: int.parse(snacks[index]
                                                                            [
                                                                            'FoodId']),
                                                                        planId:
                                                                            int.parse(snacks[index]['PlanId'].toString()),
                                                                        reLoad:
                                                                            () {
                                                                          print(
                                                                              "reload Changes Now");
                                                                          setState(
                                                                              () {
                                                                            fetchFoodPlanDetail(widget.planId,
                                                                                dayNumber);
                                                                          });
                                                                        },
                                                                      )));
                                                        },
                                                        icon: Icon(
                                                            Icons.find_replace),
                                                      )
                                                    :
                                                    // Icon(
                                                    //   Icons.play_arrow,
                                                    //   color: Colors.blue,
                                                    // )
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
                                                  "${snacks[index]['Calories']} kcal",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),

                                                    IconButton(
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
                                                        setFavourite(
                                                                snacks[index]
                                                                    ['FoodId'])
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          addFoodItem(
                                                              4,
                                                              snacks[index]
                                                                  ['FoodId'],
                                                              snacks[index]
                                                                  ['Calories'],
                                                              snacks[index]
                                                                  ['Carbs'],
                                                              snacks[index]
                                                                  ['fat'],
                                                              snacks[index]
                                                                  ['Protein'],
                                                              snacks[index][
                                                                  'ServingSize'],
                                                              context);
                                                        });
                                                      },
                                                      child: Icon(
                                                        MdiIcons.plus,
                                                        color: primaryColor,
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
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lunch",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                            ],
                          )),
                      if (lunch.length == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Meals",
                              style: TextStyle(fontSize: 15, color: black),
                            ),
                          ],
                        ),
                      ListView.builder(
                        itemCount: lunch.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isFavourite = false;
                          if (favouriteItems != null)
                            favouriteItems.forEach((element) {
                              if (lunch[index]['FoodId'] == (element['FoodId']))
                                isFavourite = true;
                              print(
                                  "lunch favourite:" + isFavourite.toString());
                            });
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _dialog = SimpleFontelicoProgressDialog(
                                            context: context,
                                            barrierDimisable: true);
                                        _dialog.show(
                                            message: "Please wait",
                                            type:
                                                SimpleFontelicoProgressDialogType
                                                    .normal);
                                        // fetchRecipe(lunch[index].foodId)
                                        //     .then((value) => _showRecipeDialog(lunch[index], value))
                                        //     .onError((error, stackTrace) => _showDialog("Error", error));
                                        print("Id ${lunch[index]['FoodId']}");
                                        fetchRecipe(lunch[index]['FoodId'])
                                            .then((value) {
                                          _dialog.hide();
                                          showFoodDialog(context, () {
                                            addedmealsnackbar(context);
                                          },
                                              lunch[index]['Name'],
                                              lunch[index]['ServingSize'],
                                              lunch[index]['Calories'],
                                              lunch[index]['Carbs'],
                                              lunch[index]['fat'],
                                              lunch[index]['Protein'],
                                              lunch[index]['Description'],
                                              '${imageBaseUrl}${lunch[index]['FileName']}',
                                              lunch[index]['MealType'],
                                              2,
                                              lunch[index]['FoodId']);
                                        }).onError((error, stackTrace) =>
                                                _showDialog("Error", error));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, 0, margin, 0),
                                        height: height * 0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  '${imageBaseUrl}${lunch[index]['FileName']}',
                                                ))),
                                      ),
                                    ),
                                    Container(
                                        height: height * 0.12,
                                        width: Responsive1.isMobile(context)
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    lunch[index]['Name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Text(
                                                  "${lunch[index]['ServingSize']} Grams",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                isActive
                                                    ? IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ReplaceDietPlan(
                                                                        eatingTime:
                                                                            2,
                                                                        foodId:
                                                                            int.parse(lunch[index]['FoodId'].toString()),
                                                                        planId:
                                                                            int.parse(lunch[index]['PlanId'].toString()),
                                                                        reLoad:
                                                                            () {
                                                                          print(
                                                                              "reload Changes Now");
                                                                          setState(
                                                                              () {
                                                                            fetchFoodPlanDetail(widget.planId,
                                                                                dayNumber);
                                                                          });
                                                                        },
                                                                      )));
                                                        },
                                                        icon: Icon(
                                                            Icons.find_replace),
                                                      )
                                                    :
                                                    // Icon(
                                                    //   Icons.play_arrow,
                                                    //   color: Colors.blue,
                                                    // )
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
                                                  "${lunch[index]['Calories']} kcal",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),

                                                    IconButton(
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
                                                        setFavourite(
                                                                lunch[index]
                                                                    ['FoodId'])
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          addFoodItem(
                                                              2,
                                                              lunch[index]
                                                                  ['FoodId'],
                                                              lunch[index]
                                                                  ['Calories'],
                                                              lunch[index]
                                                                  ['Carbs'],
                                                              lunch[index]
                                                                  ['fat'],
                                                              lunch[index]
                                                                  ['Protein'],
                                                              lunch[index][
                                                                  'ServingSize'],
                                                              context);
                                                        });
                                                      },
                                                      child: Icon(
                                                        MdiIcons.plus,
                                                        color: primaryColor,
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
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dinner",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                            ],
                          )),
                      if (dinner.length == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Meals",
                              style: TextStyle(fontSize: 15, color: black),
                            ),
                          ],
                        ),
                      ListView.builder(
                        itemCount: dinner.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isFavourite = false;
                          if (favouriteItems != null)
                            favouriteItems.forEach((element) {
                              if (dinner[index]['FoodId'] ==
                                  (element['FoodId'])) isFavourite = true;
                            });
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _dialog = SimpleFontelicoProgressDialog(
                                            context: context,
                                            barrierDimisable: true);
                                        _dialog.show(
                                            message: "Please wait",
                                            type:
                                                SimpleFontelicoProgressDialogType
                                                    .normal);
                                        // fetchRecipe(dinner[index].foodId)
                                        //     .then((value) => _showRecipeDialog(dinner[index], value))
                                        //     .onError((error, stackTrace) => _showDialog("Error", error));
                                        print("Id ${dinner[index]['FoodId']}");
                                        fetchRecipe(dinner[index]['FoodId'])
                                            .then((value) {
                                          _dialog.hide();
                                          showFoodDialog(
                                            context,
                                            () {
                                              addedmealsnackbar(context);
                                            },
                                            dinner[index]['Name'],
                                            dinner[index]['ServingSize'],
                                            dinner[index]['Calories'],
                                            dinner[index]['Carbs'],
                                            dinner[index]['fat'],
                                            dinner[index]['Protein'],
                                            dinner[index]['Description'],
                                            '${imageBaseUrl}${dinner[index]['FileName']}',
                                            dinner[index]['MealType'],
                                            3,
                                            dinner[index]['FoodId'],
                                          );
                                        }).onError((error, stackTrace) =>
                                                _showDialog("Error", error));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, 0, margin, 0),
                                        height: height * 0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  '${imageBaseUrl}${dinner[index]['FileName']}',
                                                ))),
                                      ),
                                    ),
                                    Container(
                                        height: height * 0.12,
                                        width: Responsive1.isMobile(context)
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    dinner[index]['Name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Text(
                                                  "${dinner[index]['ServingSize']} Grams",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                isActive
                                                    ? IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ReplaceDietPlan(
                                                                        eatingTime:
                                                                            3,
                                                                        foodId:
                                                                            int.parse(dinner[index]['FoodId'].toString()),
                                                                        planId:
                                                                            int.parse(dinner[index]['PlanId'].toString()),
                                                                        reLoad:
                                                                            () {
                                                                          print(
                                                                              "reload Changes Now");
                                                                          setState(
                                                                              () {
                                                                            fetchFoodPlanDetail(widget.planId,
                                                                                dayNumber);
                                                                          });
                                                                        },
                                                                      )));
                                                        },
                                                        icon: Icon(
                                                            Icons.find_replace),
                                                      )
                                                    :
                                                    // Icon(
                                                    //   Icons.play_arrow,
                                                    //   color: Colors.blue,
                                                    // )
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
                                                  "${dinner[index]['Calories']} kcal",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),

                                                    IconButton(
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
                                                        setFavourite(
                                                                dinner[index]
                                                                    ['FoodId'])
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          addFoodItem(
                                                              3,
                                                              dinner[index]
                                                                  ['FoodId'],
                                                              dinner[index]
                                                                  ['Calories'],
                                                              dinner[index]
                                                                  ['Carbs'],
                                                              dinner[index]
                                                                  ['fat'],
                                                              dinner[index]
                                                                  ['Protein'],
                                                              dinner[index][
                                                                  'ServingSize'],
                                                              context);
                                                        });
                                                      },
                                                      child: Icon(
                                                        MdiIcons.plus,
                                                        color: primaryColor,
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
                      ),
                    ],
                  ),
                ),
              )
            : Shimmer.fromColors(
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      headerSection(context, height),
                      !isActive
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {
                                      UIBlock.block(context);
                                      setPlanActive().then((value) {
                                        UIBlock.unblock(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Plan has been Activated")));
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
                      // SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.fromLTRB(margin, 0, 0, 10),
                        child: Text(
                          "Days",
                          style: TextStyle(fontSize: 15, color: black),
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
                            itemCount: 7,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
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
                                    color: unSelectedBgColor),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DDText(
                                        title: "Day",
                                        size: 11,
                                        weight: FontWeight.w300,
                                        color: unSelectedTextColor,
                                      ),
                                      DDText(
                                        title: (index + 1).toString(),
                                        size: 11,
                                        weight: FontWeight.w300,
                                        color: unSelectedTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Morning",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 15, color: black),
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                  height: height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
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
                                            Container(
                                              width: 150,
                                              child: Text(
                                                'TEXAS',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Text(
                                              "3 Grams",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            // Icon(
                                            //   Icons.play_arrow,
                                            //   color: Colors.blue,
                                            // )
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
                                              "0 kcal",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.grey,
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  MdiIcons.plus,
                                                  color: Colors.blue,
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
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin:
                              EdgeInsets.fromLTRB(margin, 10, margin, margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Snacks",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          )),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, margin, 0),
                                  height: height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
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
                                            Container(
                                              width: 150,
                                              child: Text(
                                                'BERTAGNI',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            Text(
                                              "1 Grams",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            // Icon(
                                            //   Icons.play_arrow,
                                            //   color: Colors.blue,
                                            // )
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
                                              "300 kcal",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //future: fetchFavourite(snapshot.data.foods[index].foodId.toString()),

                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.grey,
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  MdiIcons.plus,
                                                  color: Colors.blue,
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
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
              ),
      ),
    );
  }

  Container headerSection(BuildContext context, double height) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: height * 0.26,
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
                  "${widget.name}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> _showRecipeDialog(
      Foods food, List<FoodRecipeModel> model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "$imageBaseUrl${food.fileName}"))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   food.name,
                                  //   style: TextStyle(color: Colors.black, fontSize: 15),
                                  // ),
                                  Text(
                                    "${food.servingSize} grams",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                              Text(
                                "${food.calories} kcal",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.3,
                          ),
                          Text(
                            "Recipe",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10.0, bottom: 10),
                            child: Text(
                              "${model[index].servingSize} gram ${model[index].name}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
