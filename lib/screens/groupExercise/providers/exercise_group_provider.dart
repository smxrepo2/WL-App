import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/groupExercise/models/exercise_group_model.dart';

class exercisegroupprovider extends ChangeNotifier {
  ExerciseGroupsModel _data;

  setExerciseGroups(ExerciseGroupsModel data) {
    this._data = data;
  }

  ExerciseGroupsModel getExerciseGroups() {
    return this._data;
  }

  ExerciseGroups getExerciseGroupData(int index) {
    return this._data.exerciseGroups[index];
  }

  List<int> getSlotAndGroupId(int index) {
    return [
      this._data.exerciseGroups[index].slotId,
      this._data.exerciseGroups[index].groupId
    ];
  }
}
