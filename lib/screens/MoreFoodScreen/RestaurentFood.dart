import 'dart:convert';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';

import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../../models/favorite_restaurant.dart';
import '../maps/restaturant_location.dart';

class RestaurentFood extends StatefulWidget {
  final type;

  const RestaurentFood({Key key, this.type}) : super(key: key);

  @override
  _RestaurentFoodState createState() => _RestaurentFoodState();
}

class _RestaurentFoodState extends State<RestaurentFood> {
  TextEditingController _searchC = TextEditingController();

  bool isLoading = true;
  int userid, genderid;
  String restname;
  SignUpBody signUpBody;
  FavoriteRestaurant restaurants;
  Future<FavoriteRestaurant> _getFavoriteRestaurant;

  @override
  void initState() {
    super.initState();
    _allFood.clear();
    _getFavoriteRestaurant = getSuggestRest();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? customAppBar(
                context,
                elevation: 0.0,
              )
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      drawer: CustomDrawer(),
      body: Container(
        height: size.height,
        width: size.width,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Favourite Restaurant",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 8,
                        ),
                        FutureBuilder<FavoriteRestaurant>(
                            future: _getFavoriteRestaurant,
                            builder: (context, snapshot) {
                              print("restaurant activity:" +
                                  snapshot.data.toString());
                              if (snapshot.hasData) if (snapshot
                                      .data.restaurants.length ==
                                  0) {
                                return Center(
                                  child: Container(
                                    child: Text("No any Favourite Restaurent"),
                                  ),
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * 0.17,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data.restaurants.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          print("REst ${snapshot.data}");
                                          return foodItem(
                                              snapshot.data.restaurants[index]
                                                  .restaurantName,
                                              '$imageBaseUrl${snapshot.data.restaurants[index].image}');
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("All",
                                            style: TextStyle(fontSize: 16)),
                                        DDText(
                                            title: "Food Type",
                                            size: MySize.size14),
                                      ],
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            snapshot.data.restaurants.length,
                                        itemBuilder: (context, index) {
                                          return FutureBuilder(
                                              future: getAllFood(snapshot
                                                  .data
                                                  .restaurants[index]
                                                  .restuarantId),
                                              builder: (context, snapshot) {
                                                print(snapshot.data);
                                                if (snapshot.hasData &&
                                                    snapshot.connectionState ==
                                                        ConnectionState.done) {
                                                  print(
                                                      "Length ${snapshot.data.length}");
                                                  if (snapshot.data
                                                      .toString()
                                                      .contains(
                                                          "{response: Food not exists}"))
                                                    return Center(
                                                      child: Text(
                                                          "Food not exists"),
                                                    );
                                                  else {
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          snapshot.data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return listFoodItem(
                                                            snapshot.data[index]
                                                                ['FoodId'],
                                                            snapshot.data[index]
                                                                ['Name'],
                                                            snapshot.data[index]
                                                                ['Description'],
                                                            snapshot.data[index]
                                                                ['ServingSize'],
                                                            snapshot.data[index]
                                                                ['Calories'],
                                                            snapshot.data[index]
                                                                [
                                                                'RestaurantName'],
                                                            snapshot.data[index]
                                                                ['Carbs'],
                                                            snapshot.data[index]
                                                                ['fat'],
                                                            snapshot.data[index]
                                                                ['Protein'],
                                                            snapshot.data[index]
                                                                ['SatFat'],
                                                            snapshot.data[index]
                                                                ['Sodium'],
                                                            snapshot.data[index]
                                                                ['Sugar'],
                                                            '${imageBaseUrl}${snapshot.data[index]['FileName']}');
                                                      },
                                                    );
                                                  }
                                                } else if (snapshot.hasError) {
                                                  print(snapshot.error);
                                                  return Center(
                                                    child: Text(
                                                        'No Internet Connectivity'),
                                                  );
                                                }
                                                return Center(
                                                    child: Container());
                                              });
                                        })
                                  ],
                                );
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
                                                      child: Text(
                                                          'Baked chicken',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black))),
                                                  Text('0',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey[400])),
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
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RestaurantLocation(
                                        favrestaurants: restaurants)));
                              },
                              child: Text("Find Nearby Restaurants")),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FavoriteRestaurant> getSuggestRest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/dietquestions/restaurant/$userid'),
    );
    //print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      if (json
          .decode(response.body)
          .toString()
          .contains("Data with the id: $userid was not found")) {
        print("hello");
        return restaurants;
      } else {
        restaurants = FavoriteRestaurant.fromJson(json.decode(response.body));
        return restaurants;
      }
    } else {
      throw Exception('Failed to load plans');
    }
  }

  Widget foodItem(itemName, String image) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 105,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Colors.grey[300], width: 0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(image, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 100,
                    child: Text(itemName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ))),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 5),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //           width: 100,
              //           child: Text(itemName,
              //               overflow: TextOverflow.ellipsis,
              //               textAlign: TextAlign.center,
              //               style:
              //                   TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500,))),
              //       // Text(itemQty, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
              //       // Text(itemCal, style: TextStyle(fontSize: 12, color: Colors.black)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getAllFood(int restID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var url = "$apiUrl/api/restaurant/FoodItems/$restID";
    http.Response _res = await http.get(Uri.parse(url));
    if (_res.statusCode == 200) {
      print(_res.body);
      var _data = jsonDecode(_res.body)['foodDetails'];
      return _data;
    } else
      throw Exception('Something Went Wrong: ${_res.statusCode}');
  }

  Widget listFoodItem(foodId, name, description, serving, cal, restaurantName,
      car, fat, pro, satfat, sodium, sugar, img) {
    var oth = satfat + sodium + sugar;
    var desc = description.split(",");
    print("DEsc ${desc.length}");
    print(desc[0].replaceAll("[", "").replaceAll("]", ""));
    return GestureDetector(
      onTap: () {
        _showFoodDialog(
            imageUrl: img,
            title: "$name",
            quantity: "$restaurantName",
            calories: "$cal ",
            foodId: foodId,
            carbs: car,
            fat: fat,
            protiens: pro,
            serving: serving,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontSize: 14)),
                      SizedBox(
                        //height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: desc.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(desc.length);
                            return DDText(
                              line: desc.length,
                              title: desc[index]
                                  .replaceAll("[", "")
                                  .replaceAll("\"", "")
                                  .replaceAll("]", ""),
                              size: MySize.size12,
                              color: Colors.grey[500],
                            );
                          },
                        ),
                      ),

                      // DDText(
                      //   line: 2,
                      //   title: description
                      //       .replaceAll("[", "")
                      //       .replaceAll("]", ""),
                      //   //"Chicken Fillet + Mayonees\nCheese + Bun + Cabbage",
                      //   size: MySize.size12,
                      //   color: Colors.grey[500],
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("$cal kcal", style: TextStyle(fontSize: 14)),
                            DDText(
                              line: 2,
                              title: "$restaurantName" ?? "",
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
                        child: Image.network(img, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int selectedEatingTime = 0;
  Future<void> _showFoodDialog(
      {foodId,
      title,
      imageUrl,
      quantity,
      calories,
      carbs,
      protiens,
      fat,
      serving,
      other}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            var size = MediaQuery.of(context).size.width;
            var mobile = Responsive1.isMobile(context);
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
                height: mobile
                    ? MediaQuery.of(context).size.height * 0.60
                    : size * 0.30,
                width: mobile ? MediaQuery.of(context).size.width : 500,
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
                                    '${calories}kCal',
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
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
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
                                "FoodId": foodId,
                                "Cons_Cal": int.parse(calories),
                                "ServingSize": serving,
                                "fat": fat,
                                "Protein": protiens,
                                "Carbs": carbs
                              }),
                            ).then((value) {
                              print(value.body);
                              Navigator.pop(context, true);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomBarNew(3)));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString}");
                              DDToast()
                                  .showToast("message", error.toString(), true);
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
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Response> createFood(
      int typeId, int userId, foodId, cal, serving, fat, protein, carb) {
    print(jsonEncode(<String, dynamic>{
      "userId": userId,
      "F_type_id": typeId,
      "FoodId": foodId,
      "Cons_Cal": cal,
      "ServingSize": serving,
      "fat": fat,
      "Protein": protein,
      "Carbs": carb
    }));
    print("Helena");
    return post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "F_type_id": typeId,
        "FoodId": foodId,
        "Cons_Cal": cal,
        "ServingSize": serving.toInt(),
        "fat": fat,
        "Protein": protein,
        "Carbs": carb
      }),
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
