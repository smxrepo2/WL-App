import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/MindPlanDashboardModel.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/food_plans_model.dart';
import 'package:weight_loser/models/mind_plan_model.dart';

import 'package:weight_loser/utils/AppConfig.dart';

int userid;

Future<MindPlanDashboardModel> fetchMindPlan() async {
  final response = await get(
    Uri.parse('$apiUrl/api/mind/'),
  );
  if (response.statusCode == 200) {
    print("mind data in fetch:" + response.body);
    return MindPlanDashboardModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load dashboard');
  }
}

Future<MindModel> fetchMindPlans() async {
  final response = await get(
    Uri.parse('$apiUrl/api/plan/4'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return MindModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plans');
  }
}

Future<PlanModel> fetchCustomMindPlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
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

Future<List<ActivePlanModel>> fetchActivePlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/activeplans/Mind/$userid'),
  );
  print("response ${response.statusCode}");
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<ActivePlanModel> posts = List<ActivePlanModel>.from(
        l.map((model) => ActivePlanModel.fromJson(model)));
    return posts;
  } else {
    throw Exception('Failed to load plan');
  }
}

Future<Response> setFavourite(int videoId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print(userid.toString() + " : " + videoId.toString());

  return post(
    Uri.parse('$apiUrl/api/favourites/Mind'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "VidId": videoId}),
  );
}
