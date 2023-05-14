import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/food_screens/models/custom_diet_model.dart';

import '../models/added_items.dart';

class addedfoodlistprovider extends ChangeNotifier {
  AddedFoodPlanItem _data = new AddedFoodPlanItem();

  setListItem(FoodList foodItem) {
    _data.foodList.add(foodItem);
    notifyListeners();
  }

  setAddedItemId(int id) {
    _data.foodListId.add(id);
    notifyListeners();
  }

  deleteAll() {
    _data.foodList.clear();
    notifyListeners();
  }

  deleteAllItemId() {
    _data.foodListId.clear();
    notifyListeners();
  }

  List<FoodList> getFoodList() {
    return this._data.foodList;
  }

  List<int> getFoodListId() {
    return this._data.foodListId;
  }

  deleteAddedFood(int id) {
    //_data.foodList
    this
        ._data
        .foodList
        .removeWhere((element) => int.parse(element.foodId) == id);
    print("Length after removal:" + _data.foodList.length.toString());
    notifyListeners();
  }

  deleteAddedFoodId(int id) {
    //_data.foodList
    this._data.foodListId.removeWhere((element) => element == id);
    print("Length after removal:" + _data.foodList.length.toString());
    notifyListeners();
  }
}
