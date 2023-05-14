import 'package:flutter/cupertino.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';

class CustomPlanProvider extends ChangeNotifier {
  TempCustomDietPlanModel customDietPlanModel;

  int selectDay;String selectedTime;
  void setSelectedDay(int day) {
    this.selectDay = day;
    notifyListeners();
  }
  void setSelectedTime(String time) {
    this.selectedTime = time;
    notifyListeners();
  }
  void setTempCustomDietPlanData(TempCustomDietPlanModel model) {
    this.customDietPlanModel = model;
    notifyListeners();
  }
}
