import 'package:flutter/cupertino.dart';
import 'package:weight_loser/models/daily_log_model.dart';

class dailylognotiprovider extends ChangeNotifier {
  DailyLogModel _dailylogs;

  setDailyLogsData(DailyLogModel noti) {
    this._dailylogs = noti;
    //notifyListeners();
  }

  getDailyLogsData() {
    return this._dailylogs;
  }
}

class todaylognotiprovider extends ChangeNotifier {
  DailyLogModel _todaylogs;

  setDailyLogsData(DailyLogModel noti) {
    this._todaylogs = noti;
    //notifyListeners();
  }

  getDailyLogsData() {
    return this._todaylogs;
  }
}
