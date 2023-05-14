import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/food_screens/models/custom_diet_model.dart';
import 'package:weight_loser/screens/food_screens/models/custom_food_item_model.dart';
import 'package:weight_loser/screens/food_screens/models/search_food_model.dart';

import '../../../utils/AppConfig.dart';
import '../../../notifications/getit.dart';
import '../providers/customdietProvider.dart';

int userid;

Future<CustomDietModel> GetCustomDietData(
    String cuisine, String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("Cusine:$cuisine");
  print("mealtype:$mealType");

  final response = await get(Uri.parse(
      '$apiUrl/api/dashboard/CustomFood/?userId=$userid&cuisine=${cuisine.toLowerCase()}&mealType=$mealType'));

  if (response.statusCode == 200) {
    CustomDietModel _data = CustomDietModel.fromJson(jsonDecode(response.body));
    //print("response:" + response.toString());
    var _customProvider = getit<customdietprovider>();
    _customProvider.setRecipeData(_data);

    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<CustomDietModel> GetCustomInnerData(
    String cuisine, String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(Uri.parse(
      '$apiUrl/api/dashboard/CustomFood/?userId=$userid&cuisine=$cuisine&mealType=$mealType'));

  if (response.statusCode == 200) {
    CustomDietModel _data = CustomDietModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<CustomFoodItemModel> GetFoodDetail(int foodId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse('$apiUrl/api/food/$foodId'),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var _data = CustomFoodItemModel.fromJson(jsonDecode(response.body));

    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<List<FoodList>> SearchCustomDietData(String foodName) async {
  var _dietProvider = getit<customdietprovider>();
  String _cuisines = _dietProvider.getFavCuisines();
  _cuisines = _cuisines
      .replaceAll("[", "")
      .replaceAll("]", "")
      .trim()
      .toLowerCase()
      .toString();
  List<String> _cuisineList = _cuisines.split(',');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  List<FoodList> foodItems = [];
  List<dynamic> data = [];
  final response =
      await get(Uri.parse('$apiUrl/api/food/foodsearch?name=$foodName'));
  FoodList _data;
  if (response.statusCode == 200) {
    if (response.body.contains("was not found")) {
      print("Item Not Found");

      return foodItems;
    }
    print("Cuisines:" + _cuisineList.toString());
    data = jsonDecode(response.body);
    data.forEach((element) {
      _data = FoodList.fromJson(element);
      print("data:" + _data.cuisine);

      if (_cuisineList.contains(_data.cuisine.toLowerCase().toString()))
        foodItems.add(_data);
    });

    print("foodItems:" + foodItems.toList().toString());

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return foodItems;
  } else {
    throw Exception('Failed to load dairy');
  }
}
