import 'package:flutter/cupertino.dart';

import 'package:weight_loser/screens/groupExercise/models/user_exercise_model.dart';

class exerciseuserprovider extends ChangeNotifier {
  ExerciseUserModel _data;

  setExerciseUser(ExerciseUserModel data) {
    this._data = data;
  }

  ExerciseUserModel getExerciseUser() {
    return this._data;
  }

  List<ExerciseGroupInfoVM> getGroupExerciseInfo() {
    return this._data.exerciseGroupInfoVM;
  }

  ExerciseGroupInfoVM getUserExerciseInfo() {
    return this._data.userDetails;
  }
}
