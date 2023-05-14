import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/food_plans_model.dart';
import 'package:weight_loser/models/food_recipe_model.dart';
import 'package:weight_loser/models/search_model.dart';
import 'package:weight_loser/models/user_food_items_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import 'DashBord Api.dart';

///fetch diet Plan
Future<PlanModel> fetchDietPlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    // Uri.parse('$apiUrl/api/plan/user?planTypeId=1&userId=$userid'),
    Uri.parse('$apiUrl/api/plan/1'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return PlanModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plans');
  }
}

Future<List<ActivePlanModel>> fetchActivePlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/activeplans/Diet/$userid'),
  );
  print("response ${response.statusCode}");
  if (response.statusCode == 200) {
    var ab = json.decode(response.body);
    Iterable l = json.decode(response.body);
    List<ActivePlanModel> posts = List<ActivePlanModel>.from(
        l.map((model) => ActivePlanModel.fromJson(model)));
    print("Plan Active ${ab[0]['PlanId']}");
    prefs.setInt('planid', ab[0]['PlanId']);
    return posts;
  } else {
    throw Exception('Failed to load plan');
  }
}

Future<PlanModel> fetchCustomDietPlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/plan/getbyuser/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return PlanModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plans');
  }
}

///fetch recipe for diet plan food
// Future<List<FoodRecipeModel>> fetchRecipe(String foodId) async {
//   final response = await get(
//     Uri.parse('$apiUrl/api/FoodDetails/FoodDetail?FoodId=$foodId'),
//   );
//   if (response.statusCode == 200) {
//     Iterable l = json.decode(response.body);
//     return List<FoodRecipeModel>.from(
//         l.map((model) => FoodRecipeModel.fromJson(model)));
//   } else {
//     throw Exception('Failed to load plan');
//   }
// }

///get search food item
Future<UserFoodItems> getFoodItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/food/getbyuser/$userid'),
  );
  if (response.statusCode == 200) {
    return UserFoodItems.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load items');
  }
}

Future<SearchFoodModel> fetchSearchedItems(String search) async {
  final response = await get(
    Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?query=${search}&pageSize=10&api_key=IaCUAbCKvabTmfqvw2BuZtPxP6EjW8hxzG8Ng0fl&servingSize&servingSizeUnit'),
  );
  print("response code for query ${response.statusCode}");
  if (response.statusCode == 200) {
    return SearchFoodModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to searched foods');
  }
}

///search food by cuinies

Future<dynamic> searchFoodByCuisines(String type) async {
  final response = await get(
    Uri.parse("$apiUrl/api/food/CuisineFood?cuisine=${type} "),
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

///search desi food
Future<dynamic> searchDesiFood() async {
  final response = await get(
    Uri.parse('$apiUrl/api/food/CuisineFood?cuisine=desi'),
  );
  print("response code for query ${response.statusCode}");
  print(response.body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to searched foods');
  }
}

//get food detail
Future<dynamic> getFoodDetail1(String foodId) async {
  final response = await get(
    Uri.parse('$apiUrl/api/food/$foodId'),
    // ${widget.foodId}
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return (jsonDecode(response.body))['foodDetails'];
  } else {
    throw Exception('Failed to load food detail');
  }
}
