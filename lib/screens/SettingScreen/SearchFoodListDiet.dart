import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/search_model.dart';
import 'package:weight_loser/screens/SettingScreen/NewAddFoodScreen.dart';

import 'package:weight_loser/screens/food_screens/NewAddFood.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';

class SearchedFoodListDiet extends StatefulWidget {
  String searchText;

  SearchedFoodListDiet(this.searchText);

  @override
  _SearchedFoodListDietState createState() => _SearchedFoodListDietState();
}

class _SearchedFoodListDietState extends State<SearchedFoodListDiet> {
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
            child: FutureBuilder(
              future: searchFoodByCuisines(widget.searchText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0)
                    return Center(
                      child: Text('Nothing found'),
                    );
                  else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ListTile(
                            onTap: () {
                              double protein = 0, fat = 0, carbs = 0;
                              int calories = 0;
                              // for(int i=0;i<snapshot.data.length;i++){
                              //   if(snapshot.data[index]=="Protein"){
                              //     protein=double.parse(snapshot.data.foods[index].foodNutrients[i].value.toString());
                              //   }
                              //   if(snapshot.data.foods[index].foodNutrients[i].nutrientName=="Carbohydrate, by difference"){
                              //     carbs=double.parse(snapshot.data.foods[index].foodNutrients[i].value.toString());
                              //   }
                              //   if(snapshot.data.foods[index].foodNutrients[i].nutrientName=="Total lipid (fat)"){
                              //     fat=double.parse(snapshot.data.foods[index].foodNutrients[i].value.toString());
                              //   }
                              //   if(snapshot.data.foods[index].foodNutrients[i].nutrientName=="Energy"){
                              //     double calorieDouble = double.parse(snapshot.data.foods[index].foodNutrients[i].value.toString());
                              //     calories = calorieDouble.toInt();
                              //
                              //   }
                              //
                              // }
                              FoodModel _food = new FoodModel();
                              _food.id = 0;
                              _food.foodId = "";
                              _food.fileName = "";
                              double servingDouble = 0.0;
                              int serving = 0;
                              print(
                                  "serving seize ${snapshot.data[index]['ServingSize']}");
                              if (snapshot.data[index]['ServingSize'] != null) {
                                servingDouble = double.parse(snapshot
                                    .data[index]['ServingSize']
                                    .toString());
                                serving = servingDouble.toInt();
                              }

                              int houseServing = 0;
                              if (snapshot.data[index]['HouseHoldServing']
                                      .toString() ==
                                  null) {
                                double houseServingDouble = double.parse(
                                    snapshot.data[index]['HouseHoldServing']
                                        .toString());
                                houseServing = houseServingDouble.toInt();
                              }

                              _food.name = snapshot.data[index]['Description'];
                              _food.description =
                                  snapshot.data[index]['Category'];
                              _food.servingSize =
                                  snapshot.data[index]['ServingSize'];
                              _food.fat = snapshot.data[index]['fat'];
                              _food.protein = snapshot.data[index]['Protein'];
                              _food.carbs = snapshot.data[index]['Carbs'];
                              _food.calories = snapshot.data[index]['Calories'];
                              print(
                                  "food id = ${snapshot.data[index]['FoodId'].toString()}");
                              post(
                                Uri.parse('$apiUrl/api/food'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "Name": snapshot.data[index]['Name'],
                                  "Description": snapshot.data[index]
                                      ['Description'],
                                  "FoodId":
                                      snapshot.data[index]['FoodId'].toString(),
                                  "FileName": snapshot.data[index]['FileName'],
                                  "ServingSize": serving,
                                  "HouseHoldServing": houseServing,
                                  "fat": fat,
                                  "Protein": protein,
                                  "Carbs": carbs,
                                  "Calories": calories
                                }),
                              ).then((value) => print(
                                  "res after save food   ${value.statusCode}"));
                              Get.to(() => NewAddFood(
                                  snapshot.data[index]['FoodId'].toString()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //   return AddFoodScreen(snapshot.data.foods[index].fdcId.toString());
                              // }));
                            },
                            title: Text(
                              snapshot.data[index]['Description'] ??
                                  "not specified",
                              style: darkText14Px.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "${snapshot.data[index]['Category'] ?? "not specified"}",
                              style:
                                  lightText12Px.copyWith(color: Colors.black45),
                            ),
                          );
                        });
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('unable to load data'),
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
