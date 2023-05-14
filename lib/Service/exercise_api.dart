import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/food_plans_model.dart';
import 'package:weight_loser/screens/groupExercise/models/individual_exercise_model.dart';
import 'package:weight_loser/utils/AppConfig.dart';

int userid;

Future<PlanModel> fetchExercisePlans() async {
  final response = await get(
    Uri.parse('$apiUrl/api/plan/2'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return PlanModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plans');
  }
}

Future<IndividualExerciseModel> fetchIndividualExercisePlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  IndividualExerciseModel data;
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/dashboard/ExerciseDuration/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return data = IndividualExerciseModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plans');
  }
}

Future<List<ActivePlanModel>> fetchActivePlans() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/activeplans/Exercise/$userid'),
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

Future<PlanModel> fetchCustomExercisePlans() async {
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
