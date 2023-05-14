import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/models/daily_log_model.dart';
import 'package:weight_loser/screens/Daily%20Log/Daily_log.dart';

import '../../utils/AppConfig.dart';
import '../../notifications/getit.dart';
import 'daily_log_noti_provider.dart';

int userid;
Future<DailyLogModel> fetchPreviousDairy(DateTime datetime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  print("fetch data for date:" + datetime.toIso8601String());
  final response = await get(
    Uri.parse(
        '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var _data = DailyLogModel.fromJson(jsonDecode(response.body));
    var _logProvider = getit<dailylognotiprovider>();
    _logProvider.setDailyLogsData(_data);

    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future<DailyLogModel> fetchTodayDairy() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  var datetime = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch,
      isUtc: true);
  print("fetch data for date:" + datetime.toIso8601String());
  final response = await get(
    Uri.parse(
        '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return DailyLogModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}
