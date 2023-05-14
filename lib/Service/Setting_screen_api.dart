import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/utils/AppConfig.dart';

int userid;

///personal data
Future<Map<String, dynamic>> getPersonalDetail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/dietquestions/user/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['dietQuestion'];
  } else {
    throw Exception('No any data available');
  }
}

///Mind Data
Future<Map<String, dynamic>> getHabitData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/mind/user/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['dietQuestion'];
  } else {
    throw Exception('No any data available');
  }
}

///Meal diet Data
Future<Map<String, dynamic>> getMealData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/dietquestions/user/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['dietQuestion'];
  } else {
    throw Exception('No any data available');
  }
}

///Exercise Data
Future<Map<String, dynamic>> getExerciseData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/burner/User/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['dietQuestion'];
  } else {
    throw Exception('No any data available');
  }
}

Future<Map<String, dynamic>> getUserExpiry() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(
    Uri.parse('$apiUrl/api/user/expiry/$userid'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('No any data available');
  }
}
