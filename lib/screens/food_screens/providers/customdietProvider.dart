import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/food_screens/models/added_items.dart';

import '../models/custom_diet_model.dart';

class customdietprovider extends ChangeNotifier {
  CustomDietModel _recipeModel;
  int planId = null;

  setPlanId(int planId) {
    this.planId = planId;
  }

  getPlanId() {
    return this.planId;
  }

  setRecipeData(CustomDietModel recipe) {
    this._recipeModel = recipe;
    print("data set");
    notifyListeners();
  }

  CustomDietModel getAllData() {
    return this._recipeModel;
  }

  List<FoodList> getFoodList() {
    return this._recipeModel.foodList;
  }

  String getFavCuisines() {
    return this._recipeModel.favCuisine;
  }

  List<Cuisines> getAllCuisines() {
    return this._recipeModel.cuisines;
  }

  String getImagePath() {
    return this._recipeModel.imagePath;
  }

  int breakfastCount() {
    return this._recipeModel.breakFastCount;
  }

  int lunchCount() {
    return this._recipeModel.lunchFastCount;
  }

  int dinnerCount() {
    return this._recipeModel.dinnerFastCount;
  }

  int snacksCount() {
    return this._recipeModel.snackFastCount;
  }
}
