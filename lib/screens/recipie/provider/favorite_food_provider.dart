import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/recipie/model/favorite_food_model.dart';

class favoritefoodprovider extends ChangeNotifier {
  FavouriteFoodModel _recipeModel;

  setRecipeData(FavouriteFoodModel recipe) {
    this._recipeModel = recipe;
  }

  setFavorite(String foodId, index) {
    this._recipeModel.favoriteFoodVMs[index].foodId = foodId;
  }

  FavouriteFoodModel getAllData() {
    return this._recipeModel;
  }
}
