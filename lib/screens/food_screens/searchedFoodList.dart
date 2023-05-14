import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/search_model.dart';

import 'package:weight_loser/screens/food_screens/NewAddFood.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';

class SearchedFoodList extends StatefulWidget {
  String searchText;

  SearchedFoodList(this.searchText);

  @override
  _SearchedFoodListState createState() => _SearchedFoodListState();
}

class _SearchedFoodListState extends State<SearchedFoodList> {
  Future<SearchFoodModel> fetchSearchedItems() async {
    final response = await get(
      Uri.parse(
          'https://api.nal.usda.gov/fdc/v1/foods/search?query=${widget.searchText}&pageSize=10&api_key=IaCUAbCKvabTmfqvw2BuZtPxP6EjW8hxzG8Ng0fl&servingSize&servingSizeUnit'),
    );
    print("response code for query ${response.statusCode}");
    if (response.statusCode == 200) {
      return SearchFoodModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to searched foods');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
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
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<SearchFoodModel>(
              future: fetchSearchedItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.foods.length == 0)
                    return Center(
                      child: Text('Nothing found'),
                    );
                  else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.foods.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ListTile(
                            onTap: () {
                              double protein = 0, fat = 0, carbs = 0;
                              int calories = 0;
                              for (int i = 0;
                                  i <
                                      snapshot.data.foods[index].foodNutrients
                                          .length;
                                  i++) {
                                if (snapshot.data.foods[index].foodNutrients[i]
                                        .nutrientName ==
                                    "Protein") {
                                  protein = double.parse(snapshot
                                      .data.foods[index].foodNutrients[i].value
                                      .toString());
                                }
                                if (snapshot.data.foods[index].foodNutrients[i]
                                        .nutrientName ==
                                    "Carbohydrate, by difference") {
                                  carbs = double.parse(snapshot
                                      .data.foods[index].foodNutrients[i].value
                                      .toString());
                                }
                                if (snapshot.data.foods[index].foodNutrients[i]
                                        .nutrientName ==
                                    "Total lipid (fat)") {
                                  fat = double.parse(snapshot
                                      .data.foods[index].foodNutrients[i].value
                                      .toString());
                                }
                                if (snapshot.data.foods[index].foodNutrients[i]
                                        .nutrientName ==
                                    "Energy") {
                                  double calorieDouble = double.parse(snapshot
                                      .data.foods[index].foodNutrients[i].value
                                      .toString());
                                  calories = calorieDouble.toInt();
                                }
                              }
                              FoodModel _food = new FoodModel();
                              _food.id = 0;
                              _food.foodId = "";
                              _food.fileName = "";
                              double servingDouble = 0.0;
                              int serving = 0;
                              print(
                                  "serving seize ${snapshot.data.foods[index].servingSize}");
                              if (snapshot.data.foods[index].servingSize !=
                                  null) {
                                servingDouble = double.parse(snapshot
                                    .data.foods[index].servingSize
                                    .toString());
                                serving = servingDouble.toInt();
                              }

                              int houseServing = 0;
                              if (snapshot.data.foods[index]
                                      .householdServingFullText
                                      .toString() ==
                                  null) {
                                double houseServingDouble = double.parse(
                                    snapshot.data.foods[index]
                                        .householdServingFullText
                                        .toString());
                                houseServing = houseServingDouble.toInt();
                              }

                              _food.name =
                                  snapshot.data.foods[index].description;
                              _food.description =
                                  snapshot.data.foods[index].foodCategory;
                              _food.servingSize =
                                  snapshot.data.foods[index].servingSize;
                              _food.fat = fat;
                              _food.protein = protein;
                              _food.carbs = carbs;
                              _food.calories = calories;
                              print(
                                  "food id = ${snapshot.data.foods[index].fdcId.toString()}");
                              post(
                                Uri.parse('$apiUrl/api/food'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "Name":
                                      snapshot.data.foods[index].description,
                                  "Description":
                                      snapshot.data.foods[index].foodCategory,
                                  "FoodId": snapshot.data.foods[index].fdcId
                                      .toString(),
                                  "FileName": "",
                                  "ServingSize": serving,
                                  "HouseHoldServing": houseServing,
                                  "fat": fat,
                                  "Protein": protein,
                                  "Carbs": carbs,
                                  "Calories": calories
                                }),
                              ).then((value) => print(
                                  "res after save food   ${value.statusCode}"));
                              Responsive1.isMobile(context)
                                  ? Get.to(() => NewAddFood(snapshot
                                      .data.foods[index].fdcId
                                      .toString()))
                                  : showDialog(
                                      context: context,
                                      builder: (context) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 400,
                                              right: 400,
                                              bottom: 50,
                                              top: 50),
                                          child: NewAddFood(snapshot
                                              .data.foods[index].fdcId
                                              .toString())));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //   return AddFoodScreen(snapshot.data.foods[index].fdcId.toString());
                              // }));
                            },
                            title: Text(
                              snapshot.data.foods[index].description ??
                                  "not specified",
                              style: darkText14Px.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "${snapshot.data.foods[index].foodCategory ?? "not specified"}",
                              style:
                                  lightText12Px.copyWith(color: Colors.black45),
                            ),
                          );
                        });
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('No Internet Connectivity'),
                  );
                }

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
