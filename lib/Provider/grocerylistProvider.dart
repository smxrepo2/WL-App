import 'package:flutter/cupertino.dart';
import 'package:weight_loser/models/grocery_model.dart';

class groceryprovider extends ChangeNotifier {
  GroceryListModel _groceryListModel;

  setGroceryList(GroceryListModel data) {
    this._groceryListModel = data;
    notifyListeners();
  }

  getGroceryList() {
    return this._groceryListModel;
  }

  getInnerGroceryList() {
    return this._groceryListModel.groceryList;
  }

  setGroceryListItem(bool set, i, index) {
    this._groceryListModel.groceryList[i].items[index].purchased = set;
    notifyListeners();
  }
}
