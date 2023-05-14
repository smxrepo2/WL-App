import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/constants/constant.dart';

import 'package:weight_loser/utils/AppConfig.dart';

class MoreFoodScreen extends StatefulWidget {
  final type;

  const MoreFoodScreen({Key key, this.type}) : super(key: key);

  @override
  _MoreFoodScreenState createState() => _MoreFoodScreenState();
}

class _MoreFoodScreenState extends State<MoreFoodScreen> {
  TextEditingController _searchC = TextEditingController();
  Future<Map<String, dynamic>> _suggestedFood;
  bool isLoading = true;
  int userid,genderid;
  String restname;
  SignUpBody signUpBody;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    _suggestedFood = getSuggestedFood();
    var _data = await getAllFood();
    _allFood.clear();
    var _temp = _data['restaurantFood'];
    _allFood.addAll(_temp);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.grey[500]),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications, color: Colors.grey[500]))
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search Bar
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DDText(title: "${widget.type}", size: MySize.size14),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 15),
                        height: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: Colors.blue)),
                        child: TextField(
                          controller: _searchC,
                          onChanged: onSearchTextChanged,
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.blue),
                              contentPadding:
                                  EdgeInsets.only(top: 4, bottom: 0)),
                        ),
                      ),
                    ),
                    Transform.rotate(
                        angle: pi / 2,
                        child: Icon(Icons.tune_rounded, color: Colors.blue))
                  ],
                ),
              ),
              //Suggested
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Suggested", style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 8,
                    ),
                    FutureBuilder(
                        future: _suggestedFood,
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            List<dynamic> _userFood =
                                snapshot.data['foodPlans'];
                            _userFood!=null? _userFood.removeWhere((element) =>
                                element['MealType'].toString().toLowerCase() !=
                                widget.type.toString().toLowerCase()):widget.type.toString().toLowerCase();
                            if (_userFood==null) {
                              return Center(
                                child: Container(
                                  child: Text("No Suggestions"),
                                ),
                              );
                            } else {
                              return Container(
                                height: size.height * 0.25,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _userFood.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return foodItem(
                                        "https://weightchoper.somee.com/staticfiles/images/${_userFood[index]['FoodImage']}",
                                        _userFood[index]['Name'],
                                        "300g",
                                        "${_userFood[index]['Calories']} cal");
                                  },
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Container(
                              child: Text("No Data"),
                            ));
                          }
                            return Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                enabled: true,
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: 220,
                                      width: 105,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[300],
                                              width: 0.8)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 110,
                                            width: 105,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 100,
                                                    child: Text('Baked chicken',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black))),
                                                Text('0',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.grey[400])),
                                                Text('1',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                        }),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All", style: TextStyle(fontSize: 16)),
                  DDText(title: "Food Type", size: MySize.size14),
                ],
              ),
              isLoading
                  ? Expanded(
                      child: Shimmer.fromColors(
                        child: Container(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 15, top: 15),
                                width: double.maxFinite,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Baked chicken',
                                              style: TextStyle(fontSize: 14)),
                                          DDText(
                                            line: 2,
                                            title:
                                                "Chicken Fillet + Mayonees\nCheese + Bun + Cabbage",
                                            size: MySize.size12,
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text("10 kcal",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ],
                                              )),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              height: 70,
                                              width: 55,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        enabled: true,
                      ),
                    )
                  : Expanded(
                      child:
                          _searchResult.length != 0 || _searchC.text.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _searchResult.length,
                                  itemBuilder: (context, index) {
                                    var _item = _searchResult[index];
                                    return listFoodItem(
                                        _item['FoodName'],
                                        "yello",
                                        _item['Calories'],
                                        _item['RestaurantName'],
                                        _item['Carbs'],
                                        _item['fat'],
                                        _item['Protein'],
                                        "0",
                                        _item['FileName']);
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _allFood.length,
                                  itemBuilder: (context, index) {
                                    var _item = _allFood[index];
                                    return listFoodItem(
                                        _item['FoodName'],
                                        "yello",
                                        _item['Calories'],
                                        _item['RestaurantName'],
                                        _item['Carbs'],
                                        _item['fat'],
                                        _item['Protein'],
                                        "0",
                                        _item['FileName']);
                                  }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String dummyImageUrl =
      "https://media.istockphoto.com/photos/homemade-apple-pie-on-a-wood-surface-picture-id828145282?k=20&m=828145282&s=612x612&w=0&h=jdYJxcii5Hr8ZAsSc5n2bteH_41-9_HvZvxrGanLdjk=";

  Future<Map<String, dynamic>> getSuggestedFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid=prefs.getInt('userid');
    var url1 = "$apiUrl/api/dashboard/TodayDiet?UserId=$userid&MealType=${widget.type}";
    var url = "$apiUrl/api/restaurantfood/UserSuggestions?UserId=1&Calories=71&Carbs=100&Protein=100&fat=100";
    http.Response _res = await http.get(Uri.parse(url1));
    if (_res.statusCode == 200) {
      print(_res.body);
      var _data = jsonDecode(_res.body);
      return _data;
    } else
      throw Exception('Something Went Wrong: ${_res.statusCode}');
  }

  Widget foodItem(String imgUrl, itemName, itemQty, itemCal) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 220,
          width: 105,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Colors.grey[300], width: 0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: 105,
                child: Image.network(imgUrl, fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 100, child: Text(itemName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.black))),
                    Text(itemQty, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                    Text(itemCal, style: TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getAllFood() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    userid = pref.getInt('userid');
    genderid=pref.getInt('restId');
    restname=pref.getString('restname');
    print(genderid);
    print(restname);
    //var url = "$apiUrl/api/restaurantfood/UserFood/$userid";
   var url="$apiUrl/api/restaurant/FoodItems/$userid";
    http.Response _res = await http.get(Uri.parse(url));
    if (_res.statusCode == 200) {
      print(_res.body);
      var _data = jsonDecode(_res.body);
      return _data;
    } else
      throw Exception('Something Went Wrong: ${_res.statusCode}');
  }

  Widget listFoodItem(
      name, items, cal, restaurantName, car, fat, pro, oth, img) {
    return GestureDetector(
      onTap: () {
        _showFoodDialog(
            imageUrl: dummyImageUrl,
            title: "$name",
            quantity: "$restaurantName",
            calories: "$cal kCal",
            foodId: "1",
            carbs: car,
            fat: fat,
            protiens: pro,
            other: oth);
      },
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
              width: double.maxFinite,
              height: 1,
              color: Colors.grey[300],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(fontSize: 14)),
                        DDText(
                          line: 2,
                          title:
                              "Chicken Fillet + Mayonees\nCheese + Bun + Cabbage",
                          size: MySize.size12,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("$cal kcal",
                                    style: TextStyle(fontSize: 14)),
                                DDText(
                                  line: 2,
                                  title: restname??"$restaurantName",
                                  //title: "$restaurantName",
                                  size: MySize.size12,
                                  color: Colors.grey[500],
                                ),
                              ],
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 70,
                            width: 55,
                            child: Image.network(
                                "https://weightchoper.somee.com/staticfiles/images/$img",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFoodDialog(
      {foodId,
      title,
      imageUrl,
      quantity,
      calories,
      carbs,
      protiens,
      fat,
      other}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imageUrl))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      Text(
                                        quantity,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Text(
                                    calories,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.3,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text("Carbs"),
                                  DDText(
                                    title: "${carbs}g",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                  DDText(
                                    title: "50%",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text("Protiens"),
                                  DDText(
                                    title: "${protiens}g",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                  DDText(
                                    title: "50%",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text("Fat"),
                                  DDText(
                                    title: "${fat}g",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                  DDText(
                                    title: "50%",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text("Others"),
                                  DDText(
                                    title: "${other}g",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                  DDText(
                                    title: "50%",
                                    color: Colors.grey[500],
                                    size: MySize.size12,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 5),
                        child: GestureDetector(
                          onTap: () {},
                          child: DDText(
                            title: "Add Food",
                            size: MySize.size14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  showFoodPopUp() {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 25, right: 25),
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  child: Image.network(
                      "https://media.istockphoto.com/photos/homemade-apple-pie-on-a-wood-surface-picture-id828145282?k=20&m=828145282&s=612x612&w=0&h=jdYJxcii5Hr8ZAsSc5n2bteH_41-9_HvZvxrGanLdjk="),
                ),
                Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<dynamic> _searchResult = [];
  List<dynamic> _allFood = [];

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _allFood.forEach((userDetail) {
      if (userDetail['FoodName']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}
