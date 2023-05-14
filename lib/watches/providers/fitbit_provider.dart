import 'package:flutter/cupertino.dart';
import 'package:weight_loser/watches/models/fitbit.dart';

class fitbitActivityprovider extends ChangeNotifier {
  FitBitActivity _fitBitActivity;

  setFitBitActivity(FitBitActivity noti) {
    this._fitBitActivity = noti;
    notifyListeners();
  }

  getFitBitActivity() {
    return this._fitBitActivity;
  }
}
