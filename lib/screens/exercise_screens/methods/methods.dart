import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/DashboardModel.dart';
import 'package:weight_loser/screens/exercise_screens/models/custom_exercise_model.dart';
import 'package:weight_loser/screens/exercise_screens/providers/customexerciseProvider.dart';

import '../../../utils/AppConfig.dart';
import '../../../notifications/getit.dart';

int userid;

Future<CustomExerciseModel> GetCustomExerciseData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(Uri.parse('$apiUrl/api/burner'));

  if (response.statusCode == 200) {
    CustomExerciseModel _data =
        CustomExerciseModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());
    var _customProvider = getit<customexerciseprovider>();
    _customProvider.setExerciseData(_data);

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
Future<List<Burners>> SearchCustomExerciseData(String exerciseName) async {
  var _customProvider = getit<customexerciseprovider>();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  List<Burners> exerciseItems = [];
  List<dynamic> data = [];
  final response =
      await get(Uri.parse('$apiUrl/api/burner/search/$exerciseName'));
  Burners _data;
  if (response.statusCode == 200) {
    if (response.body.contains("was not found")) {
      print("Item Not Found");

      return exerciseItems;
    }

    data = jsonDecode(response.body);
    data.forEach((element) {
      _data = Burners.fromJson(element);
      print("data:" + _data.name);
      exerciseItems.add(_data);
    });

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return exerciseItems;
  } else {
    throw Exception('Failed to load dairy');
  }
}
