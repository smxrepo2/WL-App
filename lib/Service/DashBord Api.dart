import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/models/food_recipe_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:http/http.dart' as http;

int userid;

///get DashbordData
Future<DashboardModel> fetchDashboardData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("Fetch USER ID FOR DASHBOARD IS $userid");
  final response = await get(
    Uri.parse('$apiUrl/api/dashboard/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    DashboardModel _dbm = DashboardModel.fromJson(jsonDecode(response.body));
    prefs.setString("offlineDashboard/$userid", jsonEncode(_dbm));
    return _dbm;
  } else {
    throw Exception('No any data available');
  }
}

Future<DashboardModel> fetchOfflineDashboardData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("Offline Fetch USER ID FOR DASHBOARD IS $userid");
  String data = prefs.getString("offlineDashboard/$userid");
  print("data for offline dashboard:$data");
  if (data == null) {
    return fetchDashboardData();
  } else {
    DashboardModel _dbm = DashboardModel.fromJson(jsonDecode(data));
    return _dbm;
  }
}

///fetch Goal Food Exercise data
Future<Dairy> fetchDairy() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt('userid') != null) {
    userid = prefs.getInt('userid');
    print('hello $userid');
  }
  var datetime = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch,
      isUtc: true);
  print(DateTime.now());
  final response = await get(
    Uri.parse(
        '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return Dairy.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}

/// api for active plan food
Future<List<dynamic>> fetchRecipe(int foodId) async {
  final response = await get(
    Uri.parse('$apiUrl/api/FoodDetails/FoodDetail?FoodId=$foodId'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
    // Iterable l = json.decode(response.body);
    // return List<FoodRecipeModel>.from(
    //     l.map((model) => FoodRecipeModel.fromJson(model)));
  } else {
    throw Exception('Failed to load plan');
  }
}

///get food details -latest
///api for suggestion food
Future<Map<String, dynamic>> fetchRecipe1(int foodId) async {
  print("foodId $foodId");
  final response = await get(
    Uri.parse('$apiUrl/api/fooddetails/detail/$foodId'),
  );
  print("fetchrecipe1:" + response.body.toString());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load plan');
  }
}

Future<Map<String, dynamic>> fetchOtherDetail(int foodId) async {
  final response = await get(
    Uri.parse('$apiUrl/api/food/$foodId'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body)['foodDetails'];
  } else {
    throw Exception('Failed to load plan');
  }
}

Future<List<dynamic>> getFoodDetail(String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse(
        '$apiUrl/api/dashboard/TodayDiet?UserId=$userid&MealType=${mealType.toLowerCase()}'),
  );
  print("response ${response.statusCode} ${response.body}");

  var url1 =
      "$apiUrl/api/restaurantfood/Suggestion?Calories=100&Carbs=70&Protein=20&fat=48&Meal=${mealType.toLowerCase()}&UserId=$userid";
  var _headers = {"Content-Type": "application/json"};

  http.Response _res = await http.get(Uri.parse(url1), headers: _headers);

  if (response.statusCode == 200 && response.body == null) {
    return jsonDecode(response.body)['foodPlans'];
    // return ActiveFoodPlans.fromJson(jsonDecode(response.body));
  } else if (_res.statusCode == 200) {
    return jsonDecode(_res.body)['foodSuggestions'];
  } else {
    throw Exception('No food items');
  }
}
