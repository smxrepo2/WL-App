import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/models/active_mind.dart';
import 'package:weight_loser/utils/AppConfig.dart';

import '../models/to_do_task_model.dart';
import 'Local_notification.dart';

int userid;

/// Today Exercise
Future<List<dynamic>> fetchTodayExercise() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("USER ID FOR DASHBOARD IS $userid");
  final response = await get(
    Uri.parse('$apiUrl/api/dashboard/TodayExercise/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    prefs.setString("offlineWorkout/$userid",
        jsonEncode(jsonDecode(response.body)['activeExercisePlans']));
    return jsonDecode(response.body)['activeExercisePlans'];
  } else {
    throw Exception('Exercise data is not available');
  }
}

Future<List<dynamic>> fetchOfflineTodayExercise() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("Offline Fetch USER ID FOR WorkOut IS $userid");
  String data = prefs.getString("offlineWorkout/$userid");
  print("data for offline dashboard:$data");
  if (data == null) {
    return fetchTodayExercise();
  } else {
    return jsonDecode(data);
  }
}

/// Today Mind
Future<List<dynamic>> fetchMindPlanDetail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/dashboard/TodayMind/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['ctiveMindPlanVMs'];
    //return ActiveMind1.fromJson(jsonDecode(response.body)['ctiveMindPlanVMs']);
  } else {
    throw Exception('Mind data is not available');
  }
}

///Today Diet
Future<List<dynamic>> fetchTodayDiet(String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("USER ID FOR DASHBOARD IS $userid");
  final response = await get(
    Uri.parse(
        '$apiUrl/api/dashboard/TodayDiet?userId=$userid&MealType=${mealType.toLowerCase()}'),
  );
  print("response Today $mealType ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    prefs.setString("todayDiet/$mealType/$userid",
        jsonEncode(jsonDecode(response.body)['foodList']));
    return jsonDecode(response.body)['foodList'];
  } else {
    throw Exception('Diet data not avaliable');
  }
}

Future<List<dynamic>> offlinefetchTodayDiet(String mealType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("USER ID FOR DASHBOARD IS $userid");
  String data = prefs.getString("todayDiet/$mealType/$userid");
  print("data for offline fetchToday:$data");
  if (data == null) {
    return fetchTodayDiet(mealType);
  } else {
    return jsonDecode(data);
  }
}

/// fetch food suggestion
Future<List<dynamic>> fetchTodayFoodSuggestion(
    String mealType, int flag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("USER ID FOR DASHBOARD IS $userid");
  int planid = prefs.getInt('planid');
  print("Flag for suggesstions $flag");

  var url1 =
      "$apiUrl/api/restaurantfood/UserPlanSuggestions?mealType=${mealType.toLowerCase()}&userId=$userid&flag=$flag";
  // "$apiUrl/api/restaurantfood/Suggestion?Calories=100&Carbs=70&Protein=20&fat=48&Meal=${mealType.toLowerCase()}&UserId=$userid";
  var _headers = {"Content-Type": "application/json"};
  http.Response _res = await http.get(Uri.parse(url1), headers: _headers);

  print("response of ${_res.statusCode} ${_res.body}");

  if (_res.statusCode == 200) {
    return jsonDecode(_res.body)['foodList'];
    //return jsonDecode(_res.body)['foodSuggestions'];
  } else {
    throw Exception('No any Data available');
  }
}

Future<dynamic> fetchMealLodgedStatus(String mealtype) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse(
        '$apiUrl/api/history/FoodLogged?userId=$userid&type=${mealtype.toLowerCase()}'),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print("DATA ${data['response']}");
    if (data['response'] == 'Not Logged') {
      if (mealtype == "breakfast") {
        showLoggedNotification("You didn't eat breakfast yet");
      } else if (mealtype == "snacks") {
        showLoggedNotification("You didn't eat snacks yet");
      } else if (mealtype == "dinner") {
        showLoggedNotification("You didn't eat dinner yet");
      } else if (mealtype == "lunch") {
        showLoggedNotification("You didn't eat lunch yet");
      }
    } else if (data['response'] == 'Logged') {
      print("Meal add");
    }
  } else {
    throw Exception('No any Data available');
  }
}

Future<List<dynamic>> replaceFood(int eatingTime, BuildContext context) async {
  String mealType;
  eatingTime == 0
      ? mealType = "breakfast"
      : eatingTime == 1
          ? mealType = "snacks"
          : eatingTime == 2
              ? mealType = "lunch"
              : mealType = "dinner";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse(
        '$apiUrl/api/dashboard/FoodReplacement/?userId=$userid&phaseId=1&mealType=$mealType'),
  );
  print("response Today ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    print("Replace Food Response:" + response.body);
    UserDataProvider _userDataProvider = Provider.of(context, listen: false);
    _userDataProvider.itemCount = jsonDecode(response.body)['totalCount'];
    return jsonDecode(response.body)['foodList'];
  } else {
    throw Exception('Diet data not avaliable');
  }
}

getMindPlanQuote() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse('$apiUrl/api/mindqoutes/userplan/$userid'),
  );
  if (response.statusCode == 200) {
    print("Today Mind Quote:" + response.body);
    return json.decode(response.body)['todayQoute'];
  }
}

Future<UserTodoTaskModel> getTodoTasks(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await get(
    Uri.parse('$apiUrl/api/tasks/$userid'),
  );
  if (response.statusCode == 200) {
    //print("Today Mind Quote:" + response.body);
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    UserTodoTaskModel _model;
    _model = UserTodoTaskModel.fromJson(jsonDecode(response.body));
    prefs.setString("offlineTodo/$userid", jsonEncode(_model));
    provider.setAllTasks(_model);
    return _model;
  } else {
    throw Exception("Unable to fetch todo tasks");
  }
}

Future<UserTodoTaskModel> getOfflineTodoTasks(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("Offline Fetch USER ID FOR WorkOut IS $userid");
  String data = prefs.getString("offlineTodo/$userid");
  print("data for offline todo:$data");
  if (data == null) {
    return getTodoTasks(context);
  } else {
    return UserTodoTaskModel.fromJson(jsonDecode(data));
  }
}

Future<Response> saveTask(int taskId, bool completed) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("task completed:$completed");

  var response = await post(
    Uri.parse('$apiUrl/api/tasks/Complete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "UserId": userid,
      "TaskId": taskId,
      "Completed": completed
    }),
  );
  print(response.body);
  return response;
}
