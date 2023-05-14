import 'package:flutter/cupertino.dart';
import 'package:weight_loser/models/custom_mind_provider_model.dart';

class CustomMindPlanProvider extends ChangeNotifier {
  CustomMindProviderModel customMindPlanModel;

  int selectDay;
  String selectSet;

  void setSelectedDay(int day) {
    this.selectDay = day;
    notifyListeners();
  }

  void setSelectSet(String setName) {
    this.selectSet = setName;
    notifyListeners();
  }

  void setTempCustomDietPlanData(CustomMindProviderModel model) {
    this.customMindPlanModel = model;
    notifyListeners();
  }
}
