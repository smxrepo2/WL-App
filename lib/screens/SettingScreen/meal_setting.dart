import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/rest_id.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/Service/UpdateApi_service.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/all_restaurants.dart';
import 'package:weight_loser/models/favorite_restaurant.dart';
import 'package:weight_loser/screens/Questions_screen/favorite_restaurants.dart';
import 'package:weight_loser/screens/SettingScreen/search.dart';
import 'package:weight_loser/widget/Choice%20Chip%20Dialog.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:http/http.dart' as http;
import '../../utils/AppConfig.dart';
import '../Questions_screen/models/all_questions_model.dart';
import 'components.dart';

class MealSetting extends StatefulWidget {
  const MealSetting({Key key}) : super(key: key);

  @override
  _MealSettingState createState() => _MealSettingState();
}

class _MealSettingState extends State<MealSetting> {
  final favCusineController = TextEditingController();
  final nonFavCusineController = TextEditingController();
  final nonFavController = TextEditingController();

  List foodCuisines = [];
  List<String> allRestaurents = [];
  List<int> allRestaurentsIds = [];
  List<String> foodWhichNotEat = [];
  List<String> foodNotEat;
  List<String> type;

  List allcusines = [];
  List<String> selectedNonFAv;
  int resid;
  String selectedType;
  List<String> selectedFoodCusinies;
  List<String> selectedNonCusinies;
  int selectedResId = -1;

  Future<GetAllQuestionsModel> GetAllQueestions() async {
    final response = await get(Uri.parse('$apiUrl/api/Questionair'));

    if (response.statusCode == 200) {
      GetAllQuestionsModel _data =
          GetAllQuestionsModel.fromJson(jsonDecode(response.body));
      print("response:" + response.statusCode.toString());
      foodNotEat = _data.questoins[10].options
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .split(",");
      type = _data.questoins[6].options
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("\"", "")
          .split(",");
      return _data;
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  Future<dynamic> getCuisines() async {
    final response = await get(Uri.parse("$apiUrl/api/cuisine"));
    print(response.body);
    if (response.statusCode == 200) {
      allcusines = json.decode(response.body);

      allcusines.forEach((element) {
        foodCuisines.add(element['CuisineName']);
      });
      // return json.decode(response.body);
    } else {
      throw Exception('Failed to load Cuisines');
    }
  }

  List selectedOptions = [];
  List<RestId> restId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCuisines();
    GetAllQueestions();
  }

  final restController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    print("tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Meal',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            FutureBuilder(
                future: getMealData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var p =
                        Provider.of<UserDataProvider>(context, listen: false);
                    var checking = snapshot.data['FavCuisine'];
                    checking = checking
                        .replaceAll("[", "")
                        .replaceAll("]", "")
                        .replaceAll(" ", "");
                    var restFood = snapshot.data['RestrictedFood'];
                    restFood = restFood
                        .replaceAll("[", "")
                        .replaceAll("]", "")
                        .replaceAll(" ", "");
                    var check = snapshot.data['NoCuisine'];
                    check = check
                        .replaceAll("[", "")
                        .replaceAll("]", "")
                        .replaceAll(" ", "");
                    selectedFoodCusinies = checking.split(',');
                    selectedNonCusinies = check.split(',');
                    selectedNonFAv = restFood.split(',');
                    selectedFoodCusinies =
                        selectedFoodCusinies.toSet().toList();
                    selectedNonCusinies = selectedNonCusinies.toSet().toList();
                    selectedNonFAv = selectedNonFAv.toSet().toList();
                    p.updateFavCuisines(selectedFoodCusinies);
                    p.updateDislikedCuisines(selectedNonCusinies);
                    p.updateDislikedFood(selectedNonFAv);
                    p.updateDietType(snapshot.data['FoodType']);
                    selectedType = snapshot.data['FoodType'];
                    return Consumer<UserDataProvider>(
                      builder: (BuildContext context, value, Widget child) {
                        return Column(
                          children: [
                            listTileComponent(
                                context: context,
                                title: 'Favourite Type Of Cuisines',
                                subtitle: value.favCuisines
                                    .toString()
                                    .replaceAll("[", '')
                                    .replaceAll(']', ''),
                                image: 'assets/svg_icons/favourite_svg.svg',
                                oNTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            insetPadding: EdgeInsets.all(0),
                                            content: Container(
                                              width: 300,
                                              height: 500,
                                              child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount:
                                                      foodCuisines.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.5,
                                                          horizontal: 30),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (!selectedFoodCusinies
                                                                .contains(
                                                                    foodCuisines[
                                                                        index])) {
                                                              if (selectedFoodCusinies
                                                                      .length <
                                                                  3) {
                                                                selectedFoodCusinies.add(
                                                                    foodCuisines[
                                                                        index]);
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      "You can select only 3 cuisines"),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ));
                                                              }
                                                            } else {
                                                              selectedFoodCusinies
                                                                  .remove(
                                                                      foodCuisines[
                                                                          index]);
                                                            }
                                                          });
                                                        },
                                                        child: ListTile(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: selectedFoodCusinies.contains(
                                                                        foodCuisines[
                                                                            index])
                                                                    ? const Color(
                                                                        0xff4885ED)
                                                                    : const Color(
                                                                        0xffdfdfdf),
                                                                width: selectedFoodCusinies
                                                                        .contains(
                                                                            foodCuisines[index])
                                                                    ? 2
                                                                    : 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          minLeadingWidth: 0,
                                                          title: Text(
                                                            foodCuisines[index],
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff23233c),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("Update"),
                                                onPressed: () {
                                                  if (selectedFoodCusinies
                                                      .isNotEmpty) {
                                                    updateFavCusine(
                                                        selectedFoodCusinies
                                                            .toString());
                                                    value.updateFavCuisines(
                                                        selectedFoodCusinies);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                      });
                                }),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.02,
                            // ),
                            // listTileComponent(
                            //     context: context,
                            //     title: 'Disliked Cuisines',
                            //     subtitle: value.dislikedCuisines.toString()
                            //     .replaceAll("[", '')
                            //     .replaceAll(']', ''),
                            //     image: 'assets/svg_icons/disliked_svg.svg',
                            //     oNTap: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (_) {
                            //             return StatefulBuilder(
                            //                 builder: (context, setState) {
                            //                   return AlertDialog(
                            //                     insetPadding: EdgeInsets.all(0),
                            //                     content: Container(
                            //                       height: 500,
                            //                       width: 300,
                            //                       child: ListView.builder(
                            //                           physics: const BouncingScrollPhysics(),
                            //                           itemCount: foodCuisines.length,
                            //                           itemBuilder: (context, index) {
                            //                             return Padding(
                            //                               padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                            //                               child: InkWell(
                            //                                 onTap: () {
                            //                                   setState(() {
                            //                                     if(!selectedNonCusinies.contains(foodCuisines[index])){
                            //                                       selectedNonCusinies.add(foodCuisines[index]);
                            //                                     }else{
                            //                                       print('already exist');
                            //                                     }
                            //                                   });
                            //                                 },
                            //                                 child: ListTile(
                            //                                   shape: RoundedRectangleBorder(
                            //                                     side: BorderSide(
                            //                                         color: selectedNonCusinies.contains(foodCuisines[index])
                            //                                             ? const Color(0xff4885ED)
                            //                                             : const Color(0xffdfdfdf),
                            //                                         width: selectedNonCusinies.contains(foodCuisines[index]) ? 2 : 1),
                            //                                     borderRadius: BorderRadius.circular(10),
                            //                                   ),
                            //                                   minLeadingWidth: 0,
                            //                                   title: Text(
                            //                                     foodCuisines[index],
                            //                                     style: const TextStyle(
                            //                                       fontFamily: 'Open Sans',
                            //                                       fontSize: 15,
                            //                                       color: Color(0xff23233c),
                            //                                       letterSpacing: -0.44999999999999996,
                            //                                       fontWeight: FontWeight.w500,
                            //                                     ),
                            //                                     softWrap: false,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             );
                            //                           }),
                            //                     ),
                            //                     actions: [
                            //                       TextButton(
                            //                         child: Text("Cancel"),
                            //                         onPressed: () {
                            //                           Navigator.pop(context);
                            //                         },
                            //                       ),
                            //                       TextButton(
                            //                         child: Text("Update"),
                            //                         onPressed: () {
                            //                           if(selectedNonCusinies.isNotEmpty){
                            //                             updateNonFavCusine(
                            //                                 selectedNonCusinies
                            //                                     .toString());
                            //                             value.updateDislikedCuisines(selectedNonCusinies);
                            //                             Navigator.pop(context);
                            //                           }
                            //                         },
                            //                       ),
                            //                     ],
                            //                   );
                            //                 });
                            //           });
                            //     }),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            FutureBuilder<FavoriteRestaurant>(
                                future: getSuggestRest(),
                                builder: (context, snapshot) {
                                  var subtitle = '';
                                  if (snapshot.data != null)
                                    snapshot.data.restaurants.forEach(
                                      (element) {
                                        subtitle = element.restaurantName +
                                            ',' +
                                            subtitle;
                                      },
                                    );
                                  var p = Provider.of<UserDataProvider>(context,
                                      listen: false);
                                  p.updateLikedRes(subtitle);
                                  return FutureBuilder<AllRestaurant>(
                                    future: getRestuarants(),
                                    builder: (context, snapshot1) {
                                      AllRestaurant allRestaurant =
                                          snapshot1.data;
                                      return Consumer<UserDataProvider>(
                                        builder: (BuildContext context, val,
                                            Widget child) {
                                          return listTileComponent(
                                              context: context,
                                              title: 'Liked Restaurants',
                                              subtitle: snapshot.data == null
                                                  ? "None"
                                                  : val.likedRes.substring(0,
                                                      val.likedRes.length - 1),
                                              image:
                                                  'assets/svg_icons/favouriterest_svg.svg',
                                              oNTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return AlertDialog(
                                                          insetPadding:
                                                              EdgeInsets.all(0),
                                                          content: Container(
                                                            height: 500,
                                                            width: 300,
                                                            child: ListView
                                                                .builder(
                                                                    physics:
                                                                        const BouncingScrollPhysics(),
                                                                    itemCount:
                                                                        allRestaurents
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                12.5,
                                                                            horizontal:
                                                                                30),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              selectedResId = index;
                                                                            });
                                                                          },
                                                                          child:
                                                                              ListTile(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              side: BorderSide(color: selectedResId == index ? const Color(0xff4885ED) : const Color(0xffdfdfdf), width: selectedResId == index ? 2 : 1),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            minLeadingWidth:
                                                                                0,
                                                                            title:
                                                                                Text(
                                                                              allRestaurents[index],
                                                                              style: const TextStyle(
                                                                                fontFamily: 'Open Sans',
                                                                                fontSize: 15,
                                                                                color: Color(0xff23233c),
                                                                                letterSpacing: -0.44999999999999996,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              child: Text(
                                                                  "Cancel"),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                  "Update"),
                                                              onPressed: () {
                                                                if (selectedResId !=
                                                                    -1) {
                                                                  val.updateLikedRes(
                                                                      allRestaurents[
                                                                          selectedResId]);
                                                                  updateFavRest(
                                                                      allRestaurentsIds[
                                                                          selectedResId]);
                                                                  // setState((){
                                                                  //   getSuggestRest();
                                                                  // });
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                    });
                                              });
                                        },
                                      );
                                    },
                                  );
                                }),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.02,
                            // ),
                            // listTileComponent(
                            //     context: context,
                            //     title: 'Diet Type',
                            //     subtitle: value.dietType,
                            //     image: 'assets/svg_icons/diettype_svg.svg',
                            //     oNTap: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (_) {
                            //             return StatefulBuilder(
                            //                 builder: (context, setState) {
                            //                   return AlertDialog(
                            //                     insetPadding: EdgeInsets.all(0),
                            //                     content: Container(
                            //                       height: 400,
                            //                       width: 300,
                            //                       child: ListView.builder(
                            //                           physics: const BouncingScrollPhysics(),
                            //                           itemCount: type.length,
                            //                           itemBuilder: (context, index) {
                            //                             return Padding(
                            //                               padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 30),
                            //                               child: InkWell(
                            //                                 onTap: () {
                            //                                   setState(() {
                            //                                     selectedType = type[index];
                            //                                   });
                            //                                 },
                            //                                 child: ListTile(
                            //                                   shape: RoundedRectangleBorder(
                            //                                     side: BorderSide(
                            //                                         color: selectedType == type[index]
                            //                                             ? const Color(0xff4885ED)
                            //                                             : const Color(0xffdfdfdf),
                            //                                         width: selectedType == type[index] ? 2 : 1),
                            //                                     borderRadius: BorderRadius.circular(10),
                            //                                   ),
                            //                                   title: Text(
                            //                                     type[index],
                            //                                     style: const TextStyle(
                            //                                       fontFamily: 'Open Sans',
                            //                                       fontSize: 15,
                            //                                       color: Color(0xff23233c),
                            //                                       letterSpacing: -0.44999999999999996,
                            //                                       fontWeight: FontWeight.w500,
                            //                                     ),
                            //                                     softWrap: false,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             );
                            //                           }),
                            //                     ),
                            //                     actions: [
                            //                       TextButton(
                            //                         child: Text("Cancel"),
                            //                         onPressed: () {
                            //                           Navigator.pop(context);
                            //                         },
                            //                       ),
                            //                       TextButton(
                            //                         child: Text("Update"),
                            //                         onPressed: () {
                            //                           value.updateDietType(selectedType);
                            //                           Navigator.pop(context);
                            //                         },
                            //                       ),
                            //                     ],
                            //                   );
                            //                 });
                            //           });
                            //     }
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            listTileComponent(
                                context: context,
                                title: 'Food You Can not eat',
                                subtitle: value.dislikedFood
                                        .toString()
                                        .replaceAll("[", " ")
                                        .replaceAll("]", " ") ??
                                    "",
                                image: 'assets/svg_icons/youcanteat_svg.svg',
                                oNTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            insetPadding: EdgeInsets.all(0),
                                            content: Container(
                                              height: 500,
                                              width: 300,
                                              child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: foodNotEat.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.5,
                                                          horizontal: 30),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (!selectedNonFAv
                                                                .contains(
                                                                    foodNotEat[
                                                                        index])) {
                                                              selectedNonFAv.add(
                                                                  foodNotEat[
                                                                      index]);
                                                            } else {
                                                              selectedNonFAv
                                                                  .remove(
                                                                      foodNotEat[
                                                                          index]);
                                                            }
                                                          });
                                                        },
                                                        child: ListTile(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: selectedNonFAv.contains(
                                                                        foodNotEat[
                                                                            index])
                                                                    ? const Color(
                                                                        0xff4885ED)
                                                                    : const Color(
                                                                        0xffdfdfdf),
                                                                width: selectedNonFAv
                                                                        .contains(
                                                                            foodNotEat[index])
                                                                    ? 2
                                                                    : 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          minLeadingWidth: 0,
                                                          title: Text(
                                                            foodNotEat[index],
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff23233c),
                                                              letterSpacing:
                                                                  -0.44999999999999996,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("Update"),
                                                onPressed: () {
                                                  if (selectedNonFAv
                                                      .isNotEmpty) {
                                                    updateAllergicFood(
                                                        selectedNonFAv
                                                            .toString());
                                                    value.updateDislikedFood(
                                                        selectedNonFAv);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                      });
                                }),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('unable to load data'),
                    );
                  }
                  // By default, show a loading spinner.
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer(context, FavoriteRestaurant data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200.0, // Change as per your requirement
          width: 200.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.restaurants.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedOptions
                            .contains(data.restaurants[index].restaurantName)) {
                          selectedOptions
                              .remove(data.restaurants[index].restaurantName);
                          restId.remove(RestId(
                              RestuarantId:
                                  data.restaurants[index].restuarantId));
                        } else {
                          selectedOptions
                              .add(data.restaurants[index].restaurantName);
                          restId.add(RestId(
                              RestuarantId:
                                  data.restaurants[index].restuarantId));
                        }
                        //gender = allMovies[index]['Name'];
                        //genderid = allMovies[index]['Id'];
                      });
                    },
                    child: Text(
                      '${data.restaurants[index].restaurantName}',
                      style: TextStyle(
                        color: selectedOptions.contains(
                                data.restaurants[index].restaurantName)
                            ? primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10)
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<AllRestaurant> getRestuarants() async {
    var client = http.Client();
    try {
      var url = Uri.parse('https://weightchoper.somee.com/api/restaurant');
      var response = await client.get(url, headers: {
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
        'User-Agent': 'PostmanRuntime/7.28.4',
      });
      AllRestaurant data;
      if (response != null && response.statusCode == 200) {
        //print("Restaurants ${response.body}");

        data = AllRestaurant.fromJson(json.decode(response.body));
        data.restaurants.forEach((element) {
          print("element:" + element.name);
          allRestaurents.add(element.name);
          allRestaurentsIds.add(element.id);
        });
        return data;
      } else {
        return data;
        print(response.statusCode);
        print(response.body);
      }
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  Future<FavoriteRestaurant> getSuggestRest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
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
        return null;
      } else {
        return FavoriteRestaurant.fromJson(json.decode(response.body));
        //return restaurants;
      }
    } else {
      throw Exception('Failed to load plans');
    }
  }
}
