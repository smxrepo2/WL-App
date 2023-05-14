import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/sleep_details/model/sleep_detail_model.dart';

import '../../../utils/AppConfig.dart';

int userid;
Future<SleepDetailModel> fetchSleepDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  //print("Fetch USER ID FOR DASHBOARD IS $userid");
  final response =
      await get(Uri.parse('$apiUrl/api/DietQuestions/SleepScreen/$userid'));

  if (response.statusCode == 200) {
    //print("response " + response.body);
    try {
      SleepDetailModel _dbm =
          SleepDetailModel.fromJson(jsonDecode(response.body));
      print("response:" + _dbm.toString());
      return _dbm;
    } catch (e) {
      print(e);
    }
  } else {
    throw Exception('No any data available');
  }
}
