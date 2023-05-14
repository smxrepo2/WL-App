import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/grocery_model.dart';
import 'package:weight_loser/models/selfie_model.dart';
import 'package:weight_loser/models/stats_model.dart';
import 'package:weight_loser/models/user_food_items_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:http/http.dart';

int userid;

///fetch ultimate selfie
Future<SelfieModel> fetchSelfies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(Uri.parse('$apiUrl/api/selfie/getbyuser/$userid'));
  if (response.statusCode == 200) {
    return SelfieModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load selfies');
  }
}

///food graph detail
Future<StatsModel> fetchStats(String duration) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse(
        '$apiUrl/api/history/foodbycal?userId=$userid&duration=${duration.toLowerCase()}'),
  );

  if (response.statusCode == 200) {
    return StatsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}

///fetch grocery
Stream<GroceryListModel> fetchGroceries() async* {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  // final response = await http.get(Uri.parse('$apiUrl/api/activeplans/grocery/$userid'));
  final response =
      await get(Uri.parse('$apiUrl/api/activeplans/grocery/$userid'));
  if (response.statusCode == 200) {
    yield GroceryListModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load grocery');
  }
}

Future<List> fetchGrocery() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response =
      await get(Uri.parse('$apiUrl/api/activeplans/grocerylist/$userid'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    List<dynamic> data1 = jsonDecode(data['Grocery']);
    return data1;
  } else {
    throw Exception('Failed to load grocery');
  }
}
