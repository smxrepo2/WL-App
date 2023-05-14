import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:visibility_detector/visibility_detector.dart';
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
import '../../widget/FoodDialog.dart';
import '../maps/restaturant_location.dart';
import 'methods/helpers.dart';
import 'methods/methods.dart';
import 'models/restaurant_food_menu_model.dart';

class FavouriteRes extends StatefulWidget {
  final type;
  const FavouriteRes({Key key, this.type}) : super(key: key);

  @override
  _FavouriteResState createState() => _FavouriteResState();
}

class _FavouriteResState extends State<FavouriteRes> {
  int perPageItem = 4;
  int pageCount;
  int selectedIndex = -1;
  int selectedRes = -1;
  int selectedResId;
  int _currentItem = 0;
  Future<FavoriteRestaurant> _data;
  FavoriteRestaurant _favRestaurants;

  @override
  void initState() {
    _data = getFavoriteRest();
    super.initState();
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

  SimpleFontelicoProgressDialog _dialog;
  addMealtoDiary(
      BuildContext context,
      Function() success,
      title,
      serving,
      cal,
      carb,
      fat,
      protein,
      description,
      imageurl,
      mealtype,
      selectedEatingTime,
      foodId) async {
    var id = int.parse(foodId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Please wait", type: SimpleFontelicoProgressDialogType.normal);
    print(mealtype);
    double servingDouble = double.parse(serving.toString());
    int servings = servingDouble.toInt();
    int typeId;
    if (selectedEatingTime == 0) {
      typeId = 1;
    } else if (selectedEatingTime == 1) {
      typeId = 2;
    } else if (selectedEatingTime == 2) {
      typeId = 3;
    } else if (selectedEatingTime == 4) {
      typeId = 4;
    }
    print("typeId:$typeId");
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

      //Navigator.pop(context);
      success();
    }).onError((error, stackTrace) {
      print(error.toString());
      _dialog.hide();
      DDToast().showToast("message", error.toString(), true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => BottomBarNew(0)));
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                              'https://cdn.pixabay.com/photo/2017/06/06/22/46/mediterranean-cuisine-2378758__340.jpg')
                          .image,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  'Favourite',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(color: Color(0xffFF0404), offset: Offset(0, -3))
                      ],
                      // color: Color(0xffFF0404),
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff707070),
                      decorationThickness: 3
                      // decorationStyle: TextDecorationStyle.solid
                      ),
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // SizedBox(
              //   height: 7,
              //   child: Center(
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: pageCount,
              //       itemBuilder: (_, index) {
              //         return Padding(
              //           padding: const EdgeInsets.only(left: 5),
              //           child: GestureDetector(
              //             onTap: () {
              //               // pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              //             },
              //             child: Container(
              //               width: 7,
              //               height: 7,
              //               decoration: BoxDecoration(
              //                   border:
              //                   Border.all(color: Colors.black38, width: 1),
              //                   borderRadius:
              //                   BorderRadius.all(Radius.circular(100)),
              //                   color: index == selectedIndex
              //                       ? Colors.black87
              //                       : Colors.white),
              //               // .withOpacity(selectedIndex == index ? 1 : 0.5)),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 105,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder<FavoriteRestaurant>(
                      future: _data,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                          default:
                            if (snapshot.hasError)
                              return Center(child: Text("No Data Available"));
                            else if (snapshot.hasData) {
                              _favRestaurants = snapshot.data;
                              // selectedResId = snapshot.data!.restaurants![0].restuarantId!;
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.restaurants.length,
                                itemBuilder: (_, index) {
                                  return VisibilityDetector(
                                    onVisibilityChanged:
                                        (VisibilityInfo info) {},
                                    //   if (info.visibleFraction == 1) {
                                    //     setState(() {
                                    //       _currentItem = index;
                                    //       if ((_currentItem!) % 4 == 0) {
                                    //         if (selectedIndex < pageCount!) {
                                    //           selectedIndex++;
                                    //         }
                                    //       }
                                    //     });
                                    //   }
                                    // },
                                    key: Key(index.toString()),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 0 : 20),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                selectedRes = index;
                                                selectedResId = snapshot
                                                    .data
                                                    .restaurants[index]
                                                    .restuarantId;
                                              });
                                              await getRestaurantFoodMenu(
                                                  selectedResId);
                                            },
                                            child: Container(
                                              width: 65,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: index == selectedRes
                                                        ? Color(0xffFF0900)
                                                        : Colors.grey,
                                                    width: 1.3),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    image: DecorationImage(
                                                      // fit: BoxFit.cover,
                                                      image: Image.network(
                                                              '${snapshot.data.imagePath}${snapshot.data.restaurants[index].image}')
                                                          .image,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data.restaurants[index]
                                                .restaurantName,
                                            style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black38,
                                              // decorationStyle: TextDecorationStyle.solid
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                        }
                        //if (snapshot.connectionState == ConnectionState.done &&
                        //  snapshot.data == null)
                        return Center(
                            child: Text("No Favorite Restaurants Found"));
                      }),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() =>
                        RestaurantLocation(favrestaurants: _favRestaurants));
                  },
                  child: Text(
                    'Find Nearby Restaurants',
                    style: GoogleFonts.openSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: selectedResId == null
                          ? Container()
                          : FutureBuilder<RestaurantFoodMenuModel>(
                              future: getRestaurantFoodMenu(selectedResId),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case ConnectionState.done:
                                  default:
                                    if (snapshot.hasError)
                                      return Center(
                                          child: Text("No Data is Available"));
                                    else if (snapshot.hasData) {
                                      if (snapshot
                                          .data.foodDetails.isNotEmpty) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data.foodDetails.length,
                                          itemBuilder: (_, index) {
                                            return Container(
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 65,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: Image.network(
                                                                    '${snapshot.data.imagePath}${snapshot.data.foodDetails[index].fileName}')
                                                                .image,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 70,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data
                                                                  .foodDetails[
                                                                      index]
                                                                  .name,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black87,
                                                                // decorationStyle: TextDecorationStyle.solid
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                addMealtoDiary(
                                                                  context,
                                                                  () {
                                                                    addedmealsnackbar(
                                                                        context);
                                                                  },
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .name,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .servingSize,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .calories,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .carbs,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .fat,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .protein,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .description,
                                                                  '${snapshot.data.imagePath}${snapshot.data.foodDetails[index].fileName}',
                                                                  "Restaurant",
                                                                  0,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .foodId,
                                                                );
                                                              },
                                                              child: Text(
                                                                'Add',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade300,
                                                                  // decorationStyle: TextDecorationStyle.solid
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showRestaurantFoodDialog(
                                                                  context,
                                                                  () {
                                                                    addedmealsnackbar(
                                                                        context);
                                                                  },
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .name,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .servingSize,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .calories,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .carbs,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .fat,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .protein,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .description,
                                                                  '${snapshot.data.imagePath}${snapshot.data.foodDetails[index].fileName}',
                                                                  "Restaurant",
                                                                  0,
                                                                  snapshot
                                                                      .data
                                                                      .foodDetails[
                                                                          index]
                                                                      .foodId,
                                                                );
                                                              },
                                                              child: Text(
                                                                'Details',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade300,
                                                                  // decorationStyle: TextDecorationStyle.solid
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                      Container(
                                                        height: 70,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child: Text(
                                                                '${snapshot.data.foodDetails[index].calories}Cal',
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black54,
                                                                  // decorationStyle: TextDecorationStyle.solid
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                    thickness: .4,
                                                    indent: 70,
                                                    endIndent: 70,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: Text('No Data Found'),
                                        );
                                      }
                                    }
                                }
                                return CircularProgressIndicator();
                              }))),
            ],
          ),
        ),
      ),
    );
  }
}
