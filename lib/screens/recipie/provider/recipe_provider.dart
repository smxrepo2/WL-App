import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/recipie/model/recipe_model.dart';

class recipeprovider extends ChangeNotifier {
  RecipeModel _recipeModel;

  setRecipeData(RecipeModel recipe) {
    this._recipeModel = recipe;
  }

  RecipeModel getAllData() {
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
