import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/user_dashboard_report.dart';

import '../../utils/AppConfig.dart';
import '../../models/selfie_model.dart';
import '../../models/user_goal_data.dart';
import '../../models/user_profile_data.dart';

int userid;
Future<UserGoalData> fetchGraphData() async {
  final response = await get(Uri.parse('$apiUrl/api/history/weight/$userid'));
  if (response.statusCode == 200) {
    UserGoalData userProfileData =
        UserGoalData.fromJson(jsonDecode(response.body));
    return userProfileData;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<UserProfileData> fetchUserProfileData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(Uri.parse('$apiUrl/api/profile/getuser/$userid'));

  if (response.statusCode == 200) {
    print("User Profile Data:" + response.body);
    return UserProfileData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<UserDashboardReport> fetchDashboardReport() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response =
      await get(Uri.parse('$apiUrl/api/diary/DashboardReport/$userid'));

  if (response.statusCode == 200) {
    print("User Dashboard report:" + response.body);
    return UserDashboardReport.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<SelfieModel> fetchUserSelfies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await get(Uri.parse('$apiUrl/api/selfie/getbyuser/$userid'));
  if (response.statusCode == 200) {
    print("Selfie Data:" + response.body);

    return SelfieModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load selfies');
  }
}
