import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomPlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/stats_model.dart';
import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/food_screens/CreateCustomPlan.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:http/http.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/Shimmer/Food%20Dialog%20Shimmer.dart';

class SearchCuisines extends StatefulWidget {
  final String type;
  SearchCuisines({this.type});

  @override
  _SearchCuisinesState createState() => _SearchCuisinesState();
}

class _SearchCuisinesState extends State<SearchCuisines> {
  Future<dynamic> searchFoodByCuisines() async {
    final response = await get(
      Uri.parse(
          "https://weightchoper.somee.com/api/food/CuisineFood?cuisine=${widget.type.trimLeft()} "),
      //'$apiUrl/api/food/CuisineFood?cuisine=${widget.type}'),
    );
    print("response code for query ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to searched foods');
    }
  }

  List<dynamic> favouriteItems = [];
  List<bool> isFavorite = [];

  bool isLoadingFavourites = true;
  SimpleFontelicoProgressDialog _dialog;

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

  Future<List<dynamic>> fetchFavourites() async {
    final response = await get(
      Uri.parse('$apiUrl/api/favourites/Food/$userid'),
    );
    if (response.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      setState(() {
        favouriteItems = json.decode(response.body)['favoriteFoodVMs'];
        print("Favourite ${response.body}");
        // favouriteItems = List<Favourite_model>.from(l.map((model) => Favourite_model.fromJson(model)));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double margin = height * 0.02;
    var size = MediaQuery.of(context).size.width;
    print("type${widget.type.trimLeft()}");
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? customAppBar(
                context,
              )
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      // appBar: customAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/catering.png",
                  width: MySize.size20,
                  height: MySize.size20,
                ),
                DDText(
                  title: " Searched Food",
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
                future: searchFoodByCuisines(),
                builder: (context, snapshot) {
                  if (snapshot.hasData != null &&
                      snapshot.connectionState == ConnectionState.done) {
                    print("Length ${snapshot.data}");
                    if (snapshot.data
                        .toString()
                        .contains("{response: Food not exists}"))
                      return Center(
                        child: Text("Food not exists"),
                      );
                    else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext ctx, index) {
                            bool isFavourite = false;
                            if (favouriteItems != null)
                              for (var element in favouriteItems) {
                                if (element["FoodId"] ==
                                    snapshot.data[index]['FoodId']) {
                                  isFavourite = true;
                                }
                              }

                            // favouriteItems.forEach((element) {
                            //   if (element.foodId == snapshot.data[index]['FoodId']) isFavourite = true;
                            // });
                            return Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showFoodDialog(
                                            context,
                                            snapshot.data[index]['Name'],
                                            '${imageBaseUrl}${snapshot.data[index]['FileName']}',
                                            snapshot.data[index]['ServingSize'],
                                            snapshot.data[index]['Calories'],
                                            snapshot.data[index]['Carbs'],
                                            snapshot.data[index]['fat'],
                                            snapshot.data[index]['Protein'],
                                            snapshot.data[index]['SatFat'],
                                            snapshot.data[index]['Sodium'],
                                            snapshot.data[index]['Fiber'],
                                            snapshot.data[index],
                                            snapshot.data[index]['FoodId'],
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, margin, 0),
                                          height: height * 0.12,
                                          width: Responsive1.isMobile(context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18
                                              : size * 0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    '${imageBaseUrl}${snapshot.data[index]['FileName']}',
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
                                              : size * 0.3,
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
                                                      snapshot.data[index]
                                                          ['Name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index]['ServingSize']} Grams",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w300),
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
                                                    "${snapshot.data[index]['Calories']} kcal",
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
                                                          setFavourite(snapshot
                                                                          .data[
                                                                      index]
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
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     setState(() {
                                                      //      // addFoodItem( 1, breakfast[index], context);
                                                      //     });
                                                      //   },
                                                      //   child: Icon(
                                                      //     MdiIcons.plus,
                                                      //     color: Colors.blue,
                                                      //   ),
                                                      // )
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
                            // return ListTile(
                            //   onTap: () {
                            //     showFoodDialog(
                            //         context,
                            //         snapshot.data[index]['Name'],
                            //         '${imageBaseUrl}${snapshot.data[index]['FileName']}',
                            //         snapshot.data[index]['ServingSize'],
                            //         snapshot.data[index]['Calories'],
                            //         snapshot.data[index]['Carbs'],
                            //       snapshot.data[index]['fat'],
                            //       snapshot.data[index]['Protein'],
                            //         snapshot.data[index]['SatFat'],
                            //         snapshot.data[index]['Sodium'],
                            //         snapshot.data[index]['Fiber'],
                            //       snapshot.data[index],
                            //       snapshot.data[index]['FoodId'],
                            //     );
                            //   },
                            //   title: Text(
                            //     snapshot.data[index]['Name'],
                            //     style: darkText14Px.copyWith(
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            //   subtitle: Text(
                            //     "${snapshot.data[index]['Category'] ?? "not specified"}",
                            //     style: lightText12Px.copyWith(
                            //         color: Colors.black45),
                            //   ),
                            // );
                          });
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('unable to load data'),
                    );
                  }
                  return Center(child: const CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }

  Future<Response> createFood(
      int typeId, FoodModel _food, int userId, int servings, int foodId) {
    print(jsonEncode(<String, dynamic>{
      "userId": userId,
      "F_type_id": typeId,
      "FoodId": foodId,
      "Cons_Cal": _food.calories * servings,
      "ServingSize": _food.servingSize,
      "fat": _food.fat * servings,
      "Protein": _food.protein * servings,
      "Carbs": _food.carbs * servings
    }));

    return post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "F_type_id": typeId,
        "FoodId": foodId,
        "Cons_Cal": _food.calories * servings,
        "ServingSize": _food.servingSize,
        "fat": _food.fat * servings,
        "Protein": _food.protein * servings,
        "Carbs": _food.carbs * servings
      }),
    );
  }

  int servings = 1;
  showFoodDialog(BuildContext context, name, imageurl, serving, cal, carb, fat,
      protein, satfat, sodium, fiber, snapshot, foodId) {
    return showDialog(
      barrierColor: Color(0x01000000),
      context: context,
      builder: (BuildContext context) {
        print("Food Id ${foodId}");
        var other = satfat + sodium + fiber;
        var id = int.parse(foodId);
        print("${other}g");
        return StatefulBuilder(
          builder: (context, setState) {
            var size = MediaQuery.of(context).size.width;
            var mobile = Responsive1.isMobile(context);
            return Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: Responsive1.isMobile(context)
                    ? EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.05)
                    : EdgeInsets.only(left: 400, right: 400, top: 10),
                child: Container(
                  width: Responsive1.isMobile(context) ? double.infinity : 500,
                  height: Responsive1.isMobile(context) ? double.infinity : 560,
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
                                            // 'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                            .image,
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      name,
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.002,
                                  ),
                                  Text(
                                    '${serving} Serving, 250 grams',
                                    style: GoogleFonts.openSans(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
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
                                            widget.type,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 9,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width *
                                      //       0.02,
                                      // ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.red[100],
                                      //       borderRadius:
                                      //       BorderRadius.circular(100)),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         vertical: 4, horizontal: 10),
                                      //     child: Text(
                                      //       'Keton: Avoid',
                                      //       style: GoogleFonts.montserrat(
                                      //           fontSize: 9, color: Colors.red),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                              Visibility(
                                  visible: mobile,
                                  child: Expanded(child: SizedBox())),
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
                                      cal.toString(),
                                      style: GoogleFonts.openSans(
                                          color: Colors.black, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * .01,
                              )
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
                                      Text(
                                        '${other}g',
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
                                var ab = snapshot.data["Ingredients"];
                                var ingredient = jsonDecode(ab);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                          color: Color(
                                                              0xff4885ED)),
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                          color: Color(
                                                              0xff4885ED)),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          child:
                                            ingredientOrProcedure == 0
                                                ? snapshot.data['Ingredients']==null?"":
                                                ListView.builder(
                                                  itemCount: ingredient.length,
                                                    itemBuilder: (context,index){
                                                  return Text(ingredient[index],style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),);
                                                })
                                                : ingredientOrProcedure == 1
                                                    ? SingleChildScrollView(
                                                      child: Text(snapshot.data['Procedure']==null?"":snapshot.data['Procedure']
                                                .replaceAll("<p>", "").replaceAll("</p>", "")
                                                          .replaceAll("<ul><li>","").replaceAll("</li><li>","").replaceAll("</li></ul>","")
                                                .replaceAll("</li></ul><h4>", ""),style: GoogleFonts.montserrat(fontSize: 12,color: Colors.grey)),
                                                    )
                                                    : Text("Not Available")

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
                                final provider = Provider.of<UserDataProvider>(
                                    context,
                                    listen: false);
                                if (provider.customPlanStatusCode == 0) {
                                  print(
                                      "provider type Id ${provider.foodTypeId}");
                                  int id = provider.foodTypeId;
                                  final ProgressDialog pr =
                                      ProgressDialog(context);
                                  pr.show();
                                  createFood(
                                          id,
                                          snapshot.data,
                                          provider.userData.user.id,
                                          servings,
                                          snapshot.data['Id'])
                                      .then((value) {
                                    print(value.body);
                                    pr.hide();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarNew(3)));
                                  }).onError((error, stackTrace) {
                                    pr.hide();
                                    print(error.toString());
                                  });
                                } else if (provider.customPlanStatusCode == 1) {
                                  final tempProvider =
                                      Provider.of<CustomPlanProvider>(context,
                                          listen: false);
                                  TempCustomDietPlanModel tempModel =
                                      tempProvider.customDietPlanModel;
                                  TempDietFoodPlanItem foodItemModel =
                                      new TempDietFoodPlanItem(
                                    snapshot['Id'].toString(),
                                    tempProvider.selectDay.toString(),
                                    snapshot['Description'].toString(),
                                    tempProvider.selectedTime,
                                    snapshot['FileName'].toString(),
                                    snapshot['Calories'].toString(),
                                    snapshot['ServingSize'].toString(),
                                    snapshot['Name'].toString(),
                                  );
                                  //     new TempDietFoodPlanItem(
                                  //   snapshot.data.foodId.toString(),
                                  //   tempProvider.selectDay.toString(),
                                  //   snapshot.data.description.toString(),
                                  //   tempProvider.selectedTime,
                                  //   snapshot.data.fileName.toString(),
                                  //   snapshot.data.calories.toString(),
                                  //   snapshot.data.servingSize.toString(),
                                  //   snapshot.data.name.toString(),
                                  // );
                                  tempModel.foodItems.add(foodItemModel);
                                  tempProvider
                                      .setTempCustomDietPlanData(tempModel);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateDietCustomPlan(1)));
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
}

List<String> types = [
  'All Cuisines',
  'Indians',
  'Thai',
  'Italian',
  'Mexican',
];
//List<String> eatingTime = ['Morning', 'Lunch', 'Dinner', 'Snacks'];
int selectedIndex = 0;
int selectedEatingTime = 0;
int ingredientOrProcedure = 0;
