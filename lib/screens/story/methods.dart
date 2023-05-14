import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/story/story_model.dart';

import '../../utils/AppConfig.dart';
import '../../models/DashboardModel.dart';

int userid;

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
    return _dbm;
  } else {
    throw Exception('No any data available');
  }
}

Future<StoryModel> fetchStoryData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  //print("Fetch USER ID FOR DASHBOARD IS $userid");
  final response = await get(
    Uri.parse('$apiUrl/api/diary/Story/$userid'),
  );

  if (response.statusCode == 200) {
    print("response " + response.body);
    StoryModel _dbm = StoryModel.fromJson(jsonDecode(response.body));

    return _dbm;
  } else {
    throw Exception('No any data available');
  }
}

Future<Response> updateName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await post(
    Uri.parse('$apiUrl/api/profile/Name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "Name": name}),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    return response;
    //throw Exception('Failed to Update.');
  }
}

Future<Response> updatePassword(String Password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser = _auth.currentUser;

  final response = await post(
    Uri.parse('$apiUrl/api/Login/ChangePassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"Id": userid, "Password": Password}),
  );
  if (response.statusCode == 200) {
    await _currentUser.updatePassword(Password);
    return response;
  } else {
    return response;
    //throw Exception('Failed to Update.');
  }
}

Future<Response> updateDob(String date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await post(
    Uri.parse('$apiUrl/api/profile/dob'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "dOB": date}),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    return response;
    //throw Exception('Failed to Update.');
  }
}
