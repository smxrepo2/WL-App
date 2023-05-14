import 'package:flutter/cupertino.dart';
import 'package:weight_loser/watches/models/connected_watch_model.dart';
import 'package:weight_loser/watches/models/fitbit.dart';

class connectedwatchprovider extends ChangeNotifier {
  ConnectedWatchModel _watchModel;

  setConnectedWatch(ConnectedWatchModel noti) {
    this._watchModel = noti;
    //notifyListeners();
  }

  getConnectedWatch() {
    return this._watchModel;
  }
}
