import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/exercise_screens/models/custom_exercise_model.dart';
import 'package:weight_loser/screens/food_screens/models/added_items.dart';

class customexerciseprovider extends ChangeNotifier {
  CustomExerciseModel _exeModel;
  int planId = null;

  setPlanId(int planId) {
    this.planId = planId;
  }

  getPlanId() {
    return this.planId;
  }

  setExerciseData(CustomExerciseModel data) {
    this._exeModel = data;
  }

  CustomExerciseModel getAllData() {
    return this._exeModel;
  }

  List<Burners> getExerciseList() {
    return this._exeModel.burners;
  }

  String getImagePath() {
    return this._exeModel.imagePath;
  }
}
