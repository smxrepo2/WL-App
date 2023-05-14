import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/exercise_screens/models/added_exercises.dart';
import 'package:weight_loser/screens/exercise_screens/models/custom_exercise_model.dart';

class addedexerciselistprovider extends ChangeNotifier {
  AddedExercisePlanItem _data = new AddedExercisePlanItem();

  setListItem(Burners burner) {
    _data.exeList.add(burner);
    notifyListeners();
  }

  setAddedItemId(int id) {
    _data.exeListId.add(id);
    notifyListeners();
  }

  deleteAll() {
    _data.exeList.clear();
    notifyListeners();
  }

  deleteAllItemId() {
    _data.exeListId.clear();
    notifyListeners();
  }

  List<Burners> getBurnerList() {
    return this._data.exeList;
  }

  List<int> getExerciseListId() {
    return this._data.exeListId;
  }

  deleteAddedFood(int id) {
    //_data.foodList
    this
        ._data
        .exeList
        .removeWhere((element) => int.parse(element.id.toString()) == id);
    print("Length after removal:" + _data.exeList.length.toString());
    notifyListeners();
  }

  deleteAddedFoodId(int id) {
    //_data.foodList
    this._data.exeListId.removeWhere((element) => element == id);
    print("Length after removal:" + _data.exeList.length.toString());
    notifyListeners();
  }
}
