// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timelines/timelines.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/food_screens/methods/methods.dart';
import 'package:weight_loser/screens/food_screens/models/added_items.dart';
import 'package:weight_loser/screens/food_screens/providers/add_food_provider.dart';
import 'package:weight_loser/screens/food_screens/providers/customdietProvider.dart';
import 'package:weight_loser/screens/food_screens/search/search.dart';
import 'package:weight_loser/screens/navigation_tabs/homepage/middle.dart';
import 'package:weight_loser/widget/FoodDialog.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../../Component/DDText.dart';
import '../../../CustomWidgets/SizeConfig.dart';
import '../../../constants/constant.dart';
import '../../../theme/TextStyles.dart';
import '../../utils/AppConfig.dart';
import 'models/custom_diet_model.dart';

int foodSelected = 0;

class CreateDietCustomPlan extends StatefulWidget {
  int activecode;
  CreateDietCustomPlan(this.activecode);

  @override
  State<CreateDietCustomPlan> createState() => _CreateDietCustomPlanState();
}

class _CreateDietCustomPlanState extends State<CreateDietCustomPlan> {
  TextEditingController _searchController = TextEditingController();

  int day = 1;
  int daysAdded = 1;
  List<bool> plandays = [];
  List<String> types = [];
  List<AddedFoodPlanItem> _addedList = [];
  Future<CustomDietModel> _customDietFuture;
  var _customdietProvider = getit<customdietprovider>();
  var _foodProvider = getit<addedfoodlistprovider>();
  List<FoodList> foodItems;
  List<Cuisines> _cuisines = [];
  int _selectedType = 0;
  GlobalKey<FormState> _dietCustomDays = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomSelectedFood = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomSearch = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomCuisineList = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _dietCustomSaveDiet = GlobalKey<FormState>();

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("customdietshowcaseStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 100; i++) {
      plandays.add(false);
    }
    _customDietFuture = GetCustomDietData("no", "All");
    _foodProvider.deleteAll();
    _foodProvider.deleteAllItemId();
    _customdietProvider.setPlanId(null);
    print("Plan Id:${_customdietProvider.getPlanId()}");

    _foodProvider.addListener(() {
      if (mounted) setState(() {});
    });
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _dietCustomDays,
            _dietCustomSelectedFood,
            _dietCustomSearch,
            _dietCustomCuisineList,
            // _dietCustomAddFood,
            _dietCustomSaveDiet
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
  }

  Future addMealsToCustomPlan(int planId) {
    List<int> statusCodes = [];
    foodItems = _foodProvider.getFoodList();

    foodItems.forEach((element) async {
      print("food id ${element.foodId}");

      int check = 0;

      if (element.repeatDays.length > 0) {
        print("repeat days:${element.repeatDays.length}");
        for (var repeat in element.repeatDays) {
          await Future.delayed(const Duration(milliseconds: 500), () async {
            await http
                .post(
              Uri.parse('$apiUrl/api/plan/foodplan'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode(<String, dynamic>{
                "FoodId": element.foodId,
                "PlanId": planId,
                "Day": repeat.toString(),
                "Description": element.description,
                "MealType": element.mealType
              }),
            )
                .then((value) {
              if (value.statusCode == 200) {
                print("repeat for day:$repeat");
                statusCodes.add(value.statusCode);

                if (statusCodes.length == element.repeatDays.length) {
                  //statusCodes.add(response.statusCode);
                  _foodProvider.deleteAddedFood(int.parse(element.foodId));
                  _foodProvider.deleteAddedFoodId(int.parse(element.foodId));
                  print(
                      "Remaining Items ${_foodProvider.getFoodList().length}");
                  if (_foodProvider.getFoodList().length == 0) {
                    setState(() {
                      UIBlock.unblock(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Row(
                            children: [
                              Icon(Icons.done_all_rounded),
                              SizedBox(width: 10),
                              Text("Custom Plan for Day $day is uploaded"),
                            ],
                          )));

                      if (day <= 100) {
                        plandays.insert(day - 1, true);
                        day += 1;
                        daysAdded += 1;

                        //print(plandays[day - 1]);
                      }

                      //foodItems.clear();
                    });
                  }
                } else
                  print("Response:${value.statusCode}");
              }
            });
          });
        }
      } else {
        var response = await http.post(
          Uri.parse('$apiUrl/api/plan/foodplan'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "FoodId": element.foodId,
            "PlanId": planId,
            "Day": day.toString(),
            "Description": element.description,
            "MealType": element.mealType
          }),
        );

        if (response.statusCode == 200) {
          print("meal then ${response.statusCode}${response.body} ");
          //statusCodes.add(response.statusCode);
          _foodProvider.deleteAddedFood(int.parse(element.foodId));
          _foodProvider.deleteAddedFoodId(int.parse(element.foodId));
          print("Remaining Items ${_foodProvider.getFoodList().length}");
          if (_foodProvider.getFoodList().length == 0) {
            setState(() {
              UIBlock.unblock(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: [
                      Icon(Icons.done_all_rounded),
                      SizedBox(width: 10),
                      Text("Custom Plan for Day $day is uploaded"),
                    ],
                  )));

              if (day <= 100) {
                plandays.insert(day - 1, true);
                day += 1;
                daysAdded += 1;

                //print(plandays[day - 1]);
              }

              //foodItems.clear();
            });
          }
        } else
          print("Response:${response.statusCode}");
      }
    });

    //statusCodes.forEach((element) {
    //print("food meal codes $element");
    //});

    //return statusCodes;
  }

  Future<Response> AddPlan(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    Dio dio = new Dio();
    FormData formdata = new FormData();
    //String fileName = imageFile.path.split('/').last;
    int max = 100;

    formdata = FormData.fromMap({
      "PlanTypeId": 1,
      "Title": "${Random().nextInt(max)}",
      "Description": "",
      "Details": "",
      "duration": 7,
      "Calories": 105,
      "UserId": userid,
      //"FileName" : fileName,
      //"ImageFile": await MultipartFile.fromFile(
      //imageFile.path,
      //filename: fileName,
      //contentType: new MediaType("image", "jpeg"),
      //  ),
      "Cuisine": "",
    });
    return dio.post('$apiUrl/api/plan/addplan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<CustomDietModel>(
        future: _customDietFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError)
                return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Create Custom Plan',
                        style: TextStyle(color: Colors.black),
                      ),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body: Center(child: Text("No Internet Connectivity")));
              else if (snapshot.hasData) {
                if (_cuisines.length == 0)
                  _cuisines = _customdietProvider.getAllCuisines();

                if (_cuisines.first.id != 0) {
                  if (snapshot.data.foodList.length > 0) {
                    var firstElemet = {
                      "Id": 0,
                      "CuisineName": snapshot.data.foodList[0].cuisine,
                      "Country": "",
                      "Type": "diet",
                      "CreatedAt": "2022-06-25T07:38:04.07",
                      "ModifiedAt": null
                    };
                    _cuisines.insert(0, Cuisines.fromJson(firstElemet));
                    print("id:" + _cuisines.first.id.toString());
                  }
                }

                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Create Custom Plan',
                      style: TextStyle(color: Colors.black),
                    ),
                    elevation: 1,
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day--;
                                  if (day < 1) {
                                    day = 1;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios, size: 12.5),
                            ),
                            ShowCaseView(
                              globalKey: _dietCustomDays,
                              title: "Select Day",
                              description:
                                  "Custom plan would be saved for selected day, select another day to save diets in same plan",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Day ${day > 100 ? 100 : day}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 12,
                                  color: Color(0xcc1e1e1e),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day++;
                                  if (day > 100) {
                                    day = 100;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                            ),
                            const Spacer(),
                            ShowCaseView(
                              globalKey: _dietCustomSelectedFood,
                              title: "Selected Food",
                              description:
                                  "Number of food items selected for a day",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Food Selected: ${_foodProvider.getFoodList().length}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 10,
                                  color: Color(0x991e1e1e),
                                ),
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Select Custom Meal',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              color: const Color(0x991e1e1e),
                            ),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchCustomFood(),
                                      ),
                                    );
                                  },
                                  child: ShowCaseView(
                                    globalKey: _dietCustomSearch,
                                    title: "Search Food",
                                    description:
                                        "Search for food to add in custom plan",
                                    shapeBorder: BeveledRectangleBorder(),
                                    child: TextField(
                                      enabled: false,
                                      style: lightText12Px,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                color: Colors.black45,
                                                width: 0.1)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                color: Colors.black45,
                                                width: 0.1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                color: Colors.black45,
                                                width: 0.1)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                color: Colors.black45,
                                                width: 0.1)),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Colors.black45,
                                        ),
                                        hintText: "Search for food",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ShowCaseView(
                                globalKey: _dietCustomCuisineList,
                                title: "Cuisine List",
                                description:
                                    "Select cuisine of your choice and create a plan by adding diet from multiple cuisines",
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _cuisines.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedType = index;

                                                _customDietFuture =
                                                    GetCustomDietData(
                                                        _selectedType != 0
                                                            ? _cuisines[
                                                                    _selectedType]
                                                                .cuisineName
                                                            : "no",
                                                        "all");
                                              });
                                            },
                                            child: Card(
                                              color: _selectedType == index
                                                  ? Color(0xff4B86ED)
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                child: Text(
                                                  _cuisines[index].cuisineName,
                                                  style: TextStyle(
                                                    fontSize:
                                                        _selectedType == index
                                                            ? 12
                                                            : 10,
                                                    color:
                                                        _selectedType == index
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        _selectedType == index
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Expanded(
                                  child: CuisinePage(
                                      addedList: _addedList,
                                      notifyParent: () => setState(() {})))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: ShowCaseView(
                    globalKey: _dietCustomSaveDiet,
                    title: "Save Diet",
                    description:
                        "Tap to save diet for a specific day and a plan would be created",
                    child: FloatingActionButton.extended(
                      extendedPadding: const EdgeInsets.symmetric(
                          horizontal: 22.5, vertical: 0),
                      label: const Text('Save Diet'),
                      extendedTextStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: Color(0xffffffff),
                        height: 0.9333333333333333,
                      ),
                      backgroundColor: Colors.blueAccent,
                      onPressed: () {
                        print("Plan Day $day is: ${plandays[day - 1]}");
                        if (daysAdded <= 100 && plandays[day - 1] == false) {
                          var _foodProvider = getit<addedfoodlistprovider>();
                          List<FoodList> foodItems =
                              _foodProvider.getFoodList();
                          print("Food Items Length:" +
                              foodItems.length.toString());

                          if (foodItems.length > 0) {
                            UIBlock.block(context);

                            if (_customdietProvider.getPlanId() == null) {
                              print("Creating Plan Id");
                              AddPlan("").then((value) {
                                if (value.statusCode == 200) {
                                  _customdietProvider
                                      .setPlanId(value.data['planId']);
                                  addMealsToCustomPlan(value.data['planId']);
                                  //.then((value) {

                                  // });
                                }
                              });
                            } else {
                              addMealsToCustomPlan(
                                  _customdietProvider.getPlanId());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Row(
                                  children: [
                                    Icon(Icons.error_outline_rounded),
                                    SizedBox(width: 10),
                                    Text("Please select items to add in plan"),
                                  ],
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Row(
                                children: [
                                  Icon(Icons.error_outline_rounded),
                                  SizedBox(width: 10),
                                  Text("Already Added"),
                                ],
                              )));
                        }
                      },
                    ),
                  ),
                );
              } else
                return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}

class CuisinePage extends StatefulWidget {
  CuisinePage({Key key, this.notifyParent, this.addedList}) : super(key: key);
  final List<AddedFoodPlanItem> addedList;
  final Function() notifyParent;
  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  var _customdietProvider = getit<customdietprovider>();

  List<FoodList> _foodList = [];
  List<FoodList> _breakfast = [];
  List<FoodList> _lunch = [];
  List<FoodList> _dinner = [];
  List<FoodList> _snacks = [];
  int selectedViewAll = 0;
  bool viewAll = false;
  int size = 2;

  int selectedIndex = 0;
  List<String> timeFilter = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  List<List<FoodList>> data = [];
  //List<List<String>> data = [];
  List<String> time = ['Morning', 'Lunch', 'Dinner', 'Snacks'];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodList = _customdietProvider.getFoodList();
    print("added list length: ${widget.addedList.length}");
    data.clear();
    _dinner.clear();
    _breakfast.clear();
    _snacks.clear();
    _lunch.clear();
    _foodList.forEach((element) {
      if (element.mealType == "Breakfast")
        _breakfast.add(element);
      else if (element.mealType == "Lunch")
        _lunch.add(element);
      else if (element.mealType == "Snacks")
        _snacks.add(element);
      else
        _dinner.add(element);
    });

    data = [
      [..._foodList.toSet().toList()],
      [..._breakfast.toSet().toList()],
      [..._lunch.toSet().toList()],
      [..._dinner.toSet().toList()],
      [..._snacks.toSet().toList()]
    ];

    print(
        "Total List: ${data[0].length}:BF List: ${data[1].length}:dinner List: ${data[2].length}:lunch List: ${data[3].length}::snacks List: ${data[4].length}");
  }

  @override
  Widget build(BuildContext context) {
    return _foodList.length == 0
        ? Text("No Data for this Cuisine")
        : Column(
            children: [
              viewAll
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < timeFilter.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                  selectedViewAll = i - 1;
                                  size = data[selectedIndex].length;
                                });
                              },
                              child: Text(
                                timeFilter[i],
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: selectedIndex == i
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 12,
                                    color: selectedIndex == i
                                        ? Colors.blueAccent
                                        : const Color(0xff363738)),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const SizedBox(height: 10),
              const Divider(indent: 50, endIndent: 50, thickness: 2, height: 0),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: viewAll ? 1 : data.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) {
                    return index == time.length
                        ? const SizedBox(height: 50)
                        : Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  viewAll
                                      ? selectedViewAll == -1
                                          ? 'All'
                                          : time[selectedViewAll]
                                      : time[index],
                                  style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                    color: Color(0xff23233c),
                                  ),
                                  softWrap: false,
                                ),
                              ),
                              const SizedBox(height: 20),
                              for (int i = 0; i < size; i++)
                                FoodTile(
                                  addedList: widget.addedList,
                                  listItem: viewAll
                                      ? data[selectedIndex][i]
                                      : data[index + 1][i],
                                  notifyParent: () => widget.notifyParent(),
                                ),
                              viewAll
                                  ? Container()
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            viewAll = !viewAll;
                                            if (viewAll) {
                                              selectedViewAll = index;
                                              selectedIndex =
                                                  selectedViewAll + 1;
                                              size = data[selectedIndex].length;
                                            } else {
                                              size = 2;
                                            }
                                          });
                                        },
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.75),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 10),
                            ],
                          );
                  },
                ),
              ),
            ],
          );
  }
}

class FoodTile extends StatefulWidget {
  FoodTile({
    Key key,
    this.addedList,
    this.listItem,
    this.notifyParent,
  }) : super(key: key);
  final List<AddedFoodPlanItem> addedList;
  final FoodList listItem;
  final Function() notifyParent;

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  bool isSelected = false;

  int selectedEatingTime = 0;
  int ingredientOrProcedure = 0;
  List<FoodList> foodItems;
  List<int> foodItemsId;
  var _foodProvider = getit<addedfoodlistprovider>();

  @override
  void initState() {
    super.initState();
    print("Food Id of widget item : ${widget.listItem.foodId}");
    foodItems = _foodProvider.getFoodList();
    foodItemsId = _foodProvider.getFoodListId();
    if (widget.listItem.mealType == "Breakfast")
      selectedEatingTime = 0;
    else if (widget.listItem.mealType == "Lunch")
      selectedEatingTime = 1;
    else if (widget.listItem.mealType == "Dinner")
      selectedEatingTime = 2;
    else
      selectedEatingTime = 3;

    _foodProvider.addListener(() {
      if (mounted) setState(() {});
    });
  }

  List<bool> repeatDays = [false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.network(
                                  '$imageBaseUrl${widget.listItem.fileName}')
                              .image,
                          fit: BoxFit.cover)),
                ),
              ),
              //SizedBox(
              //width: MediaQuery.of(context).size.width * 0.03,
              //),

              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        widget.listItem.name,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      Text(
                        '${widget.listItem.servingSize} garams',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: const Color(0xffafafaf),
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          showFoodDialog(context, widget.listItem);
                        },
                        child: const Text(
                          'Details',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 10,
                            color: const Color(0xff4885ed),
                            fontWeight: FontWeight.w300,
                          ),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //const Spacer(),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Column(
                    children: [
                      Text(
                        '${widget.listItem.calories} kcal',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                        ),
                        softWrap: false,
                      ),
                      IconButton(
                        onPressed: () {
                          if (!foodItemsId
                              .contains(int.parse(widget.listItem.foodId))) {
                            //isSelected = true;
                            foodSelected++;
                            _foodProvider.setListItem(widget.listItem);
                            _foodProvider.setAddedItemId(
                                int.parse(widget.listItem.foodId));
                          } else {
                            //isSelected = false;
                            foodSelected--;
                            _foodProvider.deleteAddedFood(
                                int.parse(widget.listItem.foodId));
                            _foodProvider.deleteAddedFoodId(
                                int.parse(widget.listItem.foodId));
                          }
                          //widget.notifyParent();
                        },
                        icon: foodItemsId
                                .contains(int.parse(widget.listItem.foodId))
                            ? const Icon(Icons.check, color: Colors.blueAccent)
                            : const Icon(Icons.add, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }

  showFoodDialog(BuildContext context, FoodList foodItem) {
    var _foodProvider = getit<addedfoodlistprovider>();
    List<FoodList> foodList;
    List<int> foodListId;
    foodList = _foodProvider.getFoodList();
    foodListId = _foodProvider.getFoodListId();

    List<String> recipe = [];
    String recipeString = foodItem.ingredients
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("\"", "")
        .trim()
        .toLowerCase()
        .toString();
    recipe = recipeString.split(',');

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width * 0.05),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(
                                              '$imageBaseUrl${foodItem.fileName}')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  foodItem.name,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '1 Serving, ${foodItem.servingSize} grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          foodItem.cuisine,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    /*
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 10),
                                        child: Text(
                                          'Keton: Avoid',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.red),
                                        ),
                                      ),
                                    )
                                    */
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
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
                                    '${foodItem.calories}',
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
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
                                      '${foodItem.carbs}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
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
                                      '${foodItem.fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
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
                                      '${foodItem.protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
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
                                    Text(
                                      '0g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              ingredientOrProcedure = 0;
                            });
                          },
                          child: Text(
                            'Recipe',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: ingredientOrProcedure == 0
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < recipe.length; i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    '${recipe[i]}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
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
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${foodItem.servingSize}',
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
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  //selectedEatingTime = 0;
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  //selectedEatingTime = 1;
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  //selectedEatingTime = 2;
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  //selectedEatingTime = 3;
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Repeat on these days',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    repeatDays[index] = !repeatDays[index];
                                    foodItem.repeatDays.add(index + 1);
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 30,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: repeatDays[index]
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    border: Border.all(
                                      color: repeatDays[index]
                                          ? Colors.blueAccent
                                          : Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: repeatDays[index]
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (!foodListId.contains(
                                  int.parse(foodItem.foodId.toString()))) {
                                _foodProvider.setListItem(foodItem);
                                _foodProvider
                                    .setAddedItemId(int.parse(foodItem.foodId));
                                Navigator.pop(context);
                              } else {
                                _foodProvider.deleteAddedFood(
                                    int.parse(foodItem.foodId));
                                _foodProvider.deleteAddedFoodId(
                                    int.parse(foodItem.foodId));
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: !foodListId.contains(
                                          int.parse(foodItem.foodId.toString()))
                                      ? Color(0xff4885ED)
                                      : Colors.red),
                              child: Center(
                                child: !foodListId.contains(
                                        int.parse(foodItem.foodId.toString()))
                                    ? Text(
                                        'Add',
                                        style: GoogleFonts.openSans(
                                            fontSize: 15, color: Colors.white),
                                      )
                                    : Text(
                                        'Remove',
                                        style: GoogleFonts.openSans(
                                            fontSize: 15, color: Colors.white),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/*
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as Get;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomPlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';
import 'package:weight_loser/notifications/getit.dart';

import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/SettingScreen/search.dart';
import 'package:weight_loser/screens/SettingScreen/search_food.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/food_screens/MyPlans.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/screens/food_screens/methods/methods.dart';
import 'package:weight_loser/screens/food_screens/providers/customdietProvider.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/dialog_with_input_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';



import 'package:timelines/timelines.dart';
import 'package:weight_loser/screens/navigation_tabs/homepage/middle.dart';
import 'package:weight_loser/widget/FoodDialog.dart';

import '../../../Component/DDText.dart';
import '../../../CustomWidgets/SizeConfig.dart';
import '../../../constants/constant.dart';
import 'methods/methods.dart';
import '../../../theme/TextStyles.dart';
import 'models/custom_diet_model.dart';

class CreateDietCustomPlan extends StatefulWidget {
  int activecode;
  CreateDietCustomPlan(this.activecode);

  @override
  State<CreateDietCustomPlan> createState() => _CreateDietCustomPlanState();
}

class _CreateDietCustomPlanState extends State<CreateDietCustomPlan>
    with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();

  int day = 1;

  List<String> types = [];
  Future<CustomDietModel> _customDietFuture;
  var _customdietProvider = getit<customdietprovider>();
  List<Cuisines> _cuisines = [];
  int _selectedType = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _customDietFuture = GetCustomDietData("no", "All");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<CustomDietModel>(
        future: _customDietFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError)
                return Text("No Internet Connectivity");
              else if (snapshot.hasData) {
                if (_cuisines.length == 0)
                  _cuisines = _customdietProvider.getAllCuisines();

                if (_cuisines.first.id != 0) {
                  var firstElemet = {
                    "Id": 0,
                    "CuisineName": snapshot.data.foodList[0].cuisine,
                    "Country": "",
                    "Type": "diet",
                    "CreatedAt": "2022-06-25T07:38:04.07",
                    "ModifiedAt": null
                  };
                  _cuisines.insert(0, Cuisines.fromJson(firstElemet));
                  print("id:" + _cuisines.first.id.toString());
                }

                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Create Custom Plan',
                      style: TextStyle(color: Colors.black),
                    ),
                    elevation: 1,
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day--;
                                  if (day < 1) {
                                    day = 1;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios, size: 12.5),
                            ),
                            Text(
                              'Day $day',
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 12,
                                color: Color(0xcc1e1e1e),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day++;
                                  if (day > 7) {
                                    day = 7;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Select Custom Meal',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              color: const Color(0x991e1e1e),
                            ),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: lightText12Px,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.black45,
                                              width: 0.1)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.black45,
                                              width: 0.1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.black45,
                                              width: 0.1)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.black45,
                                              width: 0.1)),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        size: 20,
                                        color: Colors.black45,
                                      ),
                                      hintText: "Search for food"),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _cuisines.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedType = index;

                                              _customDietFuture =
                                                  GetCustomDietData(
                                                      _selectedType != 0
                                                          ? _cuisines[
                                                                  _selectedType]
                                                              .cuisineName
                                                          : "no",
                                                      "all");
                                            });
                                          },
                                          child: Card(
                                            color: _selectedType == index
                                                ? Color(0xff4B86ED)
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                              child: Text(
                                                _cuisines[index].cuisineName,
                                                style: TextStyle(
                                                  fontSize:
                                                      _selectedType == index
                                                          ? 12
                                                          : 10,
                                                  color: _selectedType == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight:
                                                      _selectedType == index
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              CuisinePage(OnTap: () {})
                              //RecipeBoxList(
                              //  scrollController: _scrollController, time: time)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    extendedPadding: const EdgeInsets.symmetric(
                        horizontal: 22.5, vertical: 0),
                    label: const Text('Save Diet'),
                    extendedTextStyle: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                      color: Color(0xffffffff),
                      height: 0.9333333333333333,
                    ),
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        day++;
                      });
                    },
                  ),
                );
              } else
                return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}

class CuisinePage extends StatefulWidget {
  CuisinePage({Key key, @required this.OnTap}) : super(key: key);
  final Function OnTap;
  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  var _customdietProvider = getit<customdietprovider>();
  List<FoodList> _foodList = [];
  List<FoodList> _breakfast = [];
  List<FoodList> _lunch = [];
  List<FoodList> _dinner = [];
  List<FoodList> _snacks = [];
  int selectedViewAll = 0;
  bool viewAll = false;
  int size = 2;

  int selectedIndex = 0;
  List<String> timeFilter = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  //List<List<FoodList>> data = [];
  List<List<String>> data = [
    ['palak paneer', 'aloo chat', 'desert'],
    ['chanay', 'bread', 'pan cake'],
    ['biryani', 'pulao', 'kunafa'],
    ['bbq', 'shwarma', 'burger'],
    ['fires', 'nuggets', 'samosya', 'bisuit'],
  ];
  List<String> time = ['Morning', 'Lunch', 'Dinner', 'Snacks'];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodList = _customdietProvider.getFoodList();
    //print("Food List:" + _foodList.length.toString());
    //data.clear();
    _dinner.clear();
    _breakfast.clear();
    _snacks.clear();
    _lunch.clear();
    _foodList.forEach((element) {
      if (element.mealType == "Breakfast")
        _breakfast.add(element);
      else if (element.mealType == "Lunch")
        _lunch.add(element);
      else if (element.mealType == "Snacks")
        _snacks.add(element);
      else
        _dinner.add(element);
    });
    /*
    data = [
      [..._foodList],
      [..._breakfast],
      [..._lunch],
      [..._dinner],
      [..._snacks]
    ];
    */

    print(
        "Total List: ${data[0].length}:BF List: ${data[1].length}:dinner List: ${data[2].length}:lunch List: ${data[3].length}::snacks List: ${data[4].length}");
  }

  @override
  Widget build(BuildContext context) {
    return _foodList.length == 0
        ? Text("Food Cuisine Locked! You can view it after you unlock")
        : Expanded(
            child: Column(children: [
              viewAll
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < timeFilter.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                  selectedViewAll = i - 1;
                                  size = data[selectedIndex].length;
                                });
                              },
                              child: Text(
                                timeFilter[i],
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: selectedIndex == i
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 12,
                                    color: selectedIndex == i
                                        ? Colors.blueAccent
                                        : const Color(0xff363738)),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const SizedBox(height: 10),
              const Divider(indent: 50, endIndent: 50, thickness: 2, height: 0),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: viewAll ? 1 : data.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) {
                    return index == time.length
                        ? const SizedBox(height: 50)
                        : Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  viewAll
                                      ? selectedViewAll == -1
                                          ? 'All'
                                          : time[selectedViewAll]
                                      : time[index],
                                  style: const TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                    color: Color(0xff23233c),
                                  ),
                                  softWrap: false,
                                ),
                              ),
                              const SizedBox(height: 20),
                              for (int i = 0; i < size; i++)
                                FoodTile(
                                  title: viewAll
                                      ? data[selectedIndex][i]
                                      : data[index + 1][i],
                                ),
                              viewAll
                                  ? Container()
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            viewAll = !viewAll;
                                            if (viewAll) {
                                              selectedViewAll = index;
                                              selectedIndex =
                                                  selectedViewAll + 1;
                                              size = data[0].length;
                                            } else {
                                              size = 2;
                                            }
                                          });
                                        },
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.75),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 10),
                            ],
                          );
                  },
                ),
              ),
            ]),
          );
  }
}

class FoodTile extends StatefulWidget {
  FoodTile({
    Key key,
    @required this.title,
  }) : super(key: key);
  //final FoodList listItem;
  final String title;
  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  bool isSelected = false;
  //FoodList _listItem;
  String title;
  int selectedEatingTime = 0;
  int ingredientOrProcedure = 0;

  List<bool> repeatDays = [false, false, false, false, false, false, false];
  @override
  void initState() {
    super.initState();
    //this._listItem = widget.listItem;
    this.title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: Image.network('$imageBaseUrl${title}').image,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    '$title',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                      color: const Color(0xff2b2b2b),
                      fontWeight: FontWeight.w300,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.002,
                  ),
                  const Text(
                    '250 garams',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 11,
                      color: const Color(0xffafafaf),
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      showFoodDialog(context);
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        color: const Color(0xff4885ed),
                        fontWeight: FontWeight.w300,
                      ),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: Column(
                  children: [
                    const Text(
                      '320 kcal',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: const Color(0xff2b2b2b),
                      ),
                      softWrap: false,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      icon: isSelected
                          ? const Icon(Icons.check, color: Colors.blueAccent)
                          : const Icon(Icons.add, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }

  showFoodDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width * 0.05),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: Image.network(
                                              'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Palak Paneer',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15, color: Colors.black),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.002,
                                ),
                                Text(
                                  '1 Serving, 250 grams',
                                  style: GoogleFonts.openSans(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          types[selectedIndex],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 10),
                                        child: Text(
                                          'Keton: Avoid',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9, color: Colors.red),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
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
                                    '320',
                                    style: GoogleFonts.openSans(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
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
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
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
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
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
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
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
                                    Text(
                                      '250g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '17g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              ingredientOrProcedure = 0;
                            });
                          },
                          child: Text(
                            'Recipe',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: ingredientOrProcedure == 0
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 cup fat free milk',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 cup oats',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '1 tbsp chopped walnuts',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
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
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '250',
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
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Repeat on these days',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    repeatDays[index] = !repeatDays[index];
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 30,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: repeatDays[index]
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    border: Border.all(
                                      color: repeatDays[index]
                                          ? Colors.blueAccent
                                          : Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: repeatDays[index]
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add to custom',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CreateDietCustomPlanDiscarded extends StatefulWidget {
  int activeCode;

  CreateDietCustomPlanDiscarded(this.activeCode);

  @override
  _CreateDietCustomPlanDiscardedState createState() =>
      _CreateDietCustomPlanDiscardedState();
}

class _CreateDietCustomPlanDiscardedState
    extends State<CreateDietCustomPlanDiscarded> with TickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];
  List<bool> days = [];

  List<TempDietFoodPlanItem> foodItems = [];
  int dayNumber = 1;
  var selectDaysController = TextEditingController();
  var titleController = TextEditingController();
  var morningController = TextEditingController();
  var dinnerController = TextEditingController();
  var lunchController = TextEditingController();
  var snackController = TextEditingController();
  var selectedImage;
  int userid;
  // #################################### GETTING IMAGE FROM GALLERY ################################

  Future getImageFromGallery() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  List<XFile> _imageFileList;
  dynamic _pickImageError;

// #################################### GETTING IMAGE FROM CAMERA ################################
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }

  Future<Response> upload(var imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    pr.show();
    Dio dio = new Dio();
    FormData formdata = new FormData();
    String fileName = imageFile.path.split('/').last;
    print("file data ${titleController.text} ${days.length}");
    print("file data ${imageFile.path} ${imageFile.name}");
    formdata = FormData.fromMap({
      "PlanTypeId": 1,
      "Title": titleController.text == "" ? "unnamed" : titleController.text,
      "Description": "",
      "Details": "",
      "duration": days.length,
      "Calories": 105,
      "UserId": userid,
      //"FileName" : fileName,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        //contentType: new MediaType("image", "jpeg"),
      ),
      "Cuisine": "",
    });
    return dio.post('$apiUrl/api/plan/addplan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  _selectTime(BuildContext context, TextEditingController _controller) async {
    TimeOfDay time = TimeOfDay.now();
    time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null)
      setState(() {
        _controller.text = time.format(context);
      });
  }

  addMealsToCustomPlan(int planId) {
    List<int> statusCodes = [];
    foodItems.forEach((element) {
      print("food id ${element.FoodId}");
      http
          .post(
        Uri.parse('$apiUrl/api/plan/foodplan'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "FoodId": element.FoodId,
          "PlanId": planId,
          "Day": element.day,
          "Description": element.description,
          "MealType": element.mealType
        }),
      )
          .then((value) {
        print("meal then ${value.statusCode}${value.body} ");
        statusCodes.add(value.statusCode);
      }).onError((error, stackTrace) {
        print("error $error");
      });
    });
    statusCodes.forEach((element) {
      print("food meal codes $element");
    });
    _showDialog("Successfully Added", "Your custom diet plan has been created");
  }

  dialogForCamera() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: Responsive1.isMobile(context) ? null : 300,
            height: MySize.size240,
            child: SizedBox.expand(
                child: Column(
              children: [
                SizedBox(
                  height: MySize.size20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DDText(
                      title: "Choose an Action",
                      size: MySize.size16,
                      weight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                Divider(
                  color: primaryColor,
                  thickness: 2,
                ),
                Container(
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20)
                              // primary: Colors.transparent,

                              ),
                          icon: Icon(FontAwesomeIcons.images),
                          onPressed: () async {
                            getImageFromGallery().then((value) {
                              setState(() {
                                selectedImage = value;
                              });
                              Navigator.pop(context);
                            });
                          },
                          label: DDText(
                            title: "Choose From Gallery",
                          )),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    TextButton.icon(
                        style:
                            ElevatedButton.styleFrom(padding: EdgeInsets.all(20)
                                // primary: Colors.transparent,

                                ),
                        icon: Icon(FontAwesomeIcons.camera),
                        onPressed: () async {
                          getImageFromCamera().then((value) {
                            setState(() {
                              selectedImage = value;
                            });
                            Navigator.pop(context);
                          });
                        },
                        label: DDText(
                          title: "Capture From Camera",
                        )),
                  ],
                ),

                // Divider(),
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(1);
    if (widget.activeCode == 1) {
      final provider = Provider.of<CustomPlanProvider>(context, listen: false);
      setState(() {
        titleController.text = provider.customDietPlanModel.title;
        selectDaysController.text = provider.customDietPlanModel.duration;
        foodItems = provider.customDietPlanModel.foodItems;
        selectedImage = provider.customDietPlanModel.imageFile;
      });
      for (int i = 0;
          i < int.parse(provider.customDietPlanModel.duration);
          i++) {
        if (i == 0) {
          days.add(true);
        } else
          days.add(false);
      }
    } else {
      for (int i = 0; i < 7; i++) {
        if (i == 0) {
          days.add(true);
        } else
          days.add(false);
      }
    }
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
                if (title == "Successfully Added") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPlansView()));
                  //BottomBarNew(0)));
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomBarNew(0)));
    return true; // return true if the route to be popped
  }

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    pr = ProgressDialog(context);

    int initialIndex;

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double margin = height * 0.02;
    var orientation = MediaQuery.of(context).orientation;

    /// Find a person in the list using indexWhere method.
    void findPersonUsingIndexWhere(
        List<TempDietFoodPlanItem> people, String personName) {
      // Find the index of person. If not found, index = -1
      final index = people.indexWhere((element) => element.name == personName);
      if (index >= 0) {
        print('Using indexWhere: ${people[index].name}');
        var a = '${people[index].name}';
        people.removeWhere((element) => element.FoodId == a);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? titleAppBar(context: context, title: "Create Custom Plan")
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      body: Padding(
        padding: Responsive1.isDesktop(context)
            ? const EdgeInsets.all(15.0)
            : const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: height * 0.26,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        dialogForCamera();
                      },
                      child: selectedImage == null
                          ? Image.asset(
                              'assets/images/Diet.png',
                              fit: BoxFit.cover,
                              height: height * 0.3,
                              width: MediaQuery.of(context).size.width,
                            )
                          : Image.file(
                              File(selectedImage.path),
                              fit: BoxFit.cover,
                              height: height * 0.3,
                              width: MediaQuery.of(context).size.width,
                            ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: titleController,
                          readOnly: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  DialogWithInputFieldWidget((text) {
                                setState(() {
                                  titleController.text = text;
                                });
                              }, titleController.text, "Name"),
                            );
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // counterStyle: TextStyle(color: Colors.red),
                            hintText: "Name",

                            hintStyle: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size30,
              ),
              headingView("Select Days", MySize.size0),
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
                    itemCount: days.length,
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
                      );
                    },
                  )),
              //daysRowUpdated(margin, height),
              SizedBox(
                height: MySize.size20,
              ),
              leftRightheading("Morning", "Select Time", morningController),
              SizedBox(height: MySize.size10),
              if (widget.activeCode == 1)
                foodItems.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          // findPersonUsingIndexWhere(
                          //     foodItems, foodItems[index].name);
                          // List<TempDietFoodPlanItem> people;
                          // String name = '${foodItems[index].name}';
                          // final index1 =
                          //     foodItems.where((element) => element.name == name);
                          if (foodItems[index].mealType == "Breakfast" &&
                              int.parse(foodItems[index].day) == dayNumber) {
                            return gridSectionforAddFood(
                                foodItems[index], index);
                          } else {
                            return Container();
                          }
                        },
                      )
                    : Container(),
              InkWell(
                onTap: () {
                  final tempProvider =
                      Provider.of<CustomPlanProvider>(context, listen: false);
                  final provider =
                      Provider.of<UserDataProvider>(context, listen: false);

                  TempCustomDietPlanModel tempModel =
                      new TempCustomDietPlanModel(
                          "",
                          "",
                          "",
                          titleController.text,
                          days.length.toString(),
                          foodItems,
                          selectedImage);
                  provider.setCustomPlanStatusCode(1);
                  tempProvider.setTempCustomDietPlanData(tempModel);
                  tempProvider.setSelectedTime("Breakfast");
                  tempProvider.setSelectedDay(dayNumber);
                  Responsive1.isMobile(context)
                      ? Get.Get.to(() => SearchFoodData(true))
                      : showDialog(
                          barrierColor: Color(0x01000000),
                          context: context,
                          builder: (BuildContext context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 300, right: 300, bottom: 50, top: 50),
                                child: SearchFoodData(true),
                              ));
                  // SearchFood(true)));
                },
                child: Container(
                  height: 90,
                  width: 60,
                  margin: EdgeInsets.fromLTRB(
                      10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/food_add.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Divider(),
              leftRightheading("Snack", "Select Time", snackController),
              SizedBox(height: MySize.size10),
              if (widget.activeCode == 1)
                foodItems.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (foodItems[index].mealType == "snack" &&
                              int.parse(foodItems[index].day) == dayNumber) {
                            return Column(
                              children: [
                                gridSectionforAddFood(foodItems[index], index),
                                SizedBox(height: 10)
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    : Container(),
              InkWell(
                onTap: () {
                  final tempProvider =
                      Provider.of<CustomPlanProvider>(context, listen: false);
                  final provider =
                      Provider.of<UserDataProvider>(context, listen: false);

                  TempCustomDietPlanModel tempModel =
                      new TempCustomDietPlanModel(
                          "",
                          "",
                          "",
                          titleController.text,
                          days.length.toString(),
                          foodItems,
                          selectedImage);
                  provider.setCustomPlanStatusCode(1);
                  tempProvider.setTempCustomDietPlanData(tempModel);
                  tempProvider.setSelectedTime("snack");
                  tempProvider.setSelectedDay(dayNumber);
                  Get.Get.to(() => SearchFoodData(true));
                },
                child: Container(
                  height: 90,
                  width: 60,
                  margin: EdgeInsets.fromLTRB(
                      10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/food_add.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Divider(),
              leftRightheading("Lunch", "Select Time", lunchController),
              SizedBox(height: MySize.size10),
              if (widget.activeCode == 1)
                foodItems.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(foodItems.length);
                          if (foodItems[index].mealType == "lunch" &&
                              int.parse(foodItems[index].day) == dayNumber) {
                            return gridSectionforAddFood(
                                foodItems[index], index);
                          } else {
                            return Container();
                          }
                        },
                      )
                    : Container(),
              InkWell(
                onTap: () {
                  final tempProvider =
                      Provider.of<CustomPlanProvider>(context, listen: false);
                  final provider =
                      Provider.of<UserDataProvider>(context, listen: false);

                  TempCustomDietPlanModel tempModel =
                      new TempCustomDietPlanModel(
                          "",
                          "",
                          "",
                          titleController.text,
                          days.length.toString(),
                          foodItems,
                          selectedImage);
                  provider.setCustomPlanStatusCode(1);
                  tempProvider.setTempCustomDietPlanData(tempModel);
                  tempProvider.setSelectedTime("lunch");
                  tempProvider.setSelectedDay(dayNumber);
                  Get.Get.to(() => SearchFoodData(true));
                },
                child: Container(
                  height: 90,
                  width: 60,
                  margin: EdgeInsets.fromLTRB(
                      10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/food_add.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Divider(),
              leftRightheading("Dinner", "Select Time", dinnerController),
              SizedBox(height: MySize.size10),
              if (widget.activeCode == 1)
                foodItems.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (foodItems[index].mealType == "dinner" &&
                              int.parse(foodItems[index].day) == dayNumber) {
                            return gridSectionforAddFood(
                                foodItems[index], index);
                          } else {
                            return Container();
                          }
                        },
                      )
                    : Container(),
              InkWell(
                onTap: () {
                  final tempProvider =
                      Provider.of<CustomPlanProvider>(context, listen: false);
                  final provider =
                      Provider.of<UserDataProvider>(context, listen: false);

                  TempCustomDietPlanModel tempModel =
                      new TempCustomDietPlanModel(
                          "",
                          "",
                          "",
                          titleController.text,
                          days.length.toString(),
                          foodItems,
                          selectedImage);
                  provider.setCustomPlanStatusCode(1);
                  tempProvider.setTempCustomDietPlanData(tempModel);
                  tempProvider.setSelectedTime("dinner");
                  tempProvider.setSelectedDay(dayNumber);
                  Get.Get.to(() => SearchFoodData(true));
                },
                child: Container(
                  height: 90,
                  width: 60,
                  margin: EdgeInsets.fromLTRB(
                      10, 0, MediaQuery.of(context).size.width * 0.8, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/food_add.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: MySize.size50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      if (selectedImage == null) {
                        _showDialog("No Image", "Please upload an image");
                        //DDToast().showToast("No Image", "Please upload an image", true);
                      } else if (foodItems.length == 0) {
                        _showDialog("No meal", "Please add atleast one meal");
                        //DDToast().showToast("No meal", "Please add atleast one meal", true);
                      } else {
                        upload(selectedImage).then((value) {
                          pr.hide();
                          print(
                              "dio response data ${value.data['planId']} code ${value.statusCode} message ${value.statusMessage}");
                          addMealsToCustomPlan(value.data['planId']);
                          pr.hide();
                        }).onError((error, stackTrace) {
                          pr.hide();
                          print("dio response error ${error.toString()}");
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: DDText(
                        title: "Save",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container gridSectionforAddFood(TempDietFoodPlanItem foodItem, int index) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image:
                              NetworkImage("$imageBaseUrl${foodItem.filename}"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  padding: EdgeInsets.only(left: MySize.size16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DDText(
                          title: foodItem.name,
                          size: MySize.size15,
                          weight: FontWeight.w300),
                      DDText(
                        title: foodItem.servingSize + " grams",
                        size: MySize.size11,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: MySize.size14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DDText(title: "${foodItem.calories} cal"),
                InkWell(
                  onTap: () {
                    setState(() {
                      foodItems.removeAt(index);
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.trashAlt,
                    size: MySize.size16,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headingView(title, bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size16, bottom: bottomPadding),
      child: Container(
        // margin: const EdgeInsets.only(right: 100, left: 10),
        child: TextField(
          controller: selectDaysController,
          keyboardType: TextInputType.number,
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => DialogWithInputFieldWidget((text) {
                setState(() {
                  selectDaysController.text = text;
                  days.clear();
                  for (int i = 0;
                      i < int.parse(selectDaysController.text);
                      i++) {
                    if (i == 0) {
                      days.add(true);
                    } else
                      days.add(false);
                  }
                });
              }, selectDaysController.text, "Days"),
            );
          },
          style: GoogleFonts.openSans(
              fontSize: MySize.size15, color: Colors.black),
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: 'Select Days',
            hintStyle: GoogleFonts.openSans(
                fontSize: MySize.size15, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget leftRightheading(
      left, right, TextEditingController _editingController) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              readOnly: true,
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
              readOnly: true,
              onTap: () {
                _selectTime(context, _editingController);
              },
              controller: _editingController,
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
}
*/
