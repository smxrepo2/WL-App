import 'dart:convert';

// import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/mind_screens/models/custom_mind_model.dart';
import 'package:weight_loser/screens/mind_screens/providers/custommindProvider.dart';

import '../../../utils/AppConfig.dart';
import '../../../notifications/getit.dart';

int userid;

Future<CustomMindModel> GetCustomMindData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(Uri.parse('$apiUrl/api/mind/videos'));

  if (response.statusCode == 200) {
    CustomMindModel _data = CustomMindModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());
    var _customProvider = getit<custommindprovider>();
    _customProvider.setMindData(_data);

    return _data;
  } else {
    throw Exception('Failed to load data');
  }
}

/*
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
*/
Future<List<VideosData>> SearchCustomMindData(String mindName) async {
  var _customProvider = getit<custommindprovider>();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  List<VideosData> mindItems = [];
  List<dynamic> data = [];
  final response = await get(Uri.parse('$apiUrl/api/video/search/$mindName'));
  VideosData _data;
  if (response.statusCode == 200) {
    if (response.body.contains("was not found")) {
      print("Item Not Found");

      return mindItems;
    }

    data = jsonDecode(response.body)['videos'];
    data.forEach((element) {
      _data = VideosData.fromJson(element);
      print("data:" + _data.title);
      mindItems.add(_data);
    });

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return mindItems;
  } else {
    throw Exception('Failed to load dairy');
  }
}
