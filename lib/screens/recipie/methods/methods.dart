import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/recipie/model/food_item_model.dart';
import 'package:weight_loser/screens/recipie/model/search_recipe_model.dart';
import 'package:weight_loser/screens/recipie/provider/favorite_food_provider.dart';

import '../../../utils/AppConfig.dart';
import '../../../notifications/getit.dart';
import '../model/favorite_food_model.dart';
import '../model/recipe_model.dart';
import '../provider/recipe_provider.dart';

int userid;
Future<RecipeModel> GetRecipeData(String cuisine, String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(Uri.parse(
      '$apiUrl/api/dashboard/FoodRecipie/?userId=$userid&cuisine=$cuisine&mealType=$mealType'));

  if (response.statusCode == 200) {
    RecipeModel _data = RecipeModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());
    var _recipeProvider = getit<recipeprovider>();
    _recipeProvider.setRecipeData(_data);
    //print("Length of foodItems:" + _data.foodList.length.toString());
    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<Response> setFoodFavourite(String foodId) async {
  //print(userid.toString() + " : " + foodId.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  var response = await post(
    Uri.parse('$apiUrl/api/favourites/Food'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "FoodId": foodId}),
  );
  return response;
}

Future<FavouriteFoodModel> fetchFoodFavourites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  //print("fetch favourite for Uid:" + userid.toString());
  FavouriteFoodModel favouriteItems;
  final response = await get(
    Uri.parse('$apiUrl/api/favourites/Food/$userid'),
  );
  if (response.statusCode == 200) {
    //Iterable l = json.decode(response.body);
    //print("Favourite Items:" +
    //  json.decode(response.body)['favoriteFoodVMs'].toString());

    //favouriteItems = List<Favourite_model>.from(l.map((model) => Favourite_model.fromJson(model)));
    //if (response.body.contains("was not found")) {
    //print("not found");
    //return favouriteItems;
    //}
    var provider = getit<favoritefoodprovider>();
    favouriteItems = FavouriteFoodModel.fromJson(json.decode(response.body));
    provider.setRecipeData(favouriteItems);
    return favouriteItems;
  } else {
    throw Exception('Failed to load plan');
  }
}

Future<List<FoodList>> GetRecipeInnerData(
    String cuisine, String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(Uri.parse(
      '$apiUrl/api/dashboard/FoodRecipie/?userId=$userid&cuisine=$cuisine&mealType=$mealType'));

  if (response.statusCode == 200) {
    RecipeModel _data = RecipeModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return _data.foodList;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<FoodItemModel> GetFoodDetail(int foodId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse('$apiUrl/api/food/$foodId'),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var _data = FoodItemModel.fromJson(jsonDecode(response.body));

    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<List<SearchRecipeModel>> SearchRecipeData(String foodName) async {
  var _recipeProvider = getit<recipeprovider>();
  String _cuisines = _recipeProvider.getFavCuisines();
  _cuisines = _cuisines
      .replaceAll("[", "")
      .replaceAll("]", "")
      .trim()
      .toLowerCase()
      .toString();
  List<String> _cuisineList = _cuisines.split(',');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  List<SearchRecipeModel> foodItems = [];
  List<dynamic> data = [];
  final response =
      await get(Uri.parse('$apiUrl/api/food/foodsearch?name=$foodName'));
  SearchRecipeModel _data;
  if (response.statusCode == 200) {
    if (response.body.contains("was not found")) {
      print("Item Not Found");

      return foodItems;
    }
    print("Cuisines:" + _cuisineList.toString());
    data = jsonDecode(response.body);
    data.forEach((element) {
      _data = SearchRecipeModel.fromJson(element);

      if (_cuisineList.contains(_data.cuisine.trim().toLowerCase().toString()))
        foodItems.add(_data);
    });

    print("foodItems:" + foodItems.toList().toString());

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return foodItems;
  } else {
    throw Exception('Failed to load dairy');
  }
}
