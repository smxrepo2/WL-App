import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/MoreFoodScreen/models/restaurant_food_menu_model.dart';

import '../../../utils/AppConfig.dart';
import '../../../models/favorite_restaurant.dart';

Future<RestaurantFoodMenuModel> getRestaurantFoodMenu(int restID) async {
  var url = "$apiUrl/api/restaurant/FoodItems/$restID";
  http.Response _res = await http.get(Uri.parse(url));
  if (_res.statusCode == 200) {
    print(_res.body);

    RestaurantFoodMenuModel _data =
        RestaurantFoodMenuModel.fromJson(jsonDecode(_res.body));
    return _data;
  } else
    throw Exception('Something Went Wrong: ${_res.statusCode}');
}

Future<FavoriteRestaurant> getFavoriteRest() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FavoriteRestaurant restaurants;
  int userid = prefs.getInt('userid');
  final response = await http.get(
    Uri.parse('$apiUrl/api/dietquestions/restaurant/$userid'),
  );
  //print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    if (json
        .decode(response.body)
        .toString()
        .contains("Data with the id: $userid was not found")) {
      print("hello");
      return restaurants;
    } else {
      restaurants = FavoriteRestaurant.fromJson(json.decode(response.body));
      return restaurants;
    }
  } else {
    throw Exception('Failed to load plans');
  }
}
