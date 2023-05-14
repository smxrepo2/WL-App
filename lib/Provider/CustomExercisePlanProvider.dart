import 'package:flutter/cupertino.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/models/custom_exercise_provider_model.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';

class CustomExercisePlanProvider extends ChangeNotifier {
  CustomExerciseProviderModel customExercisePlanModel;

  int selectDay;String selectSet;
  void setSelectedDay(int day) {
    this.selectDay = day;
    notifyListeners();
  }
  void setSelectSet(String setName) {
    this.selectSet = setName;
    notifyListeners();
  }
  void setTempCustomDietPlanData(CustomExerciseProviderModel model) {
    this.customExercisePlanModel = model;
    notifyListeners();
  }
}
