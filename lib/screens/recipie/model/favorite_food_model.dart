class FavouriteFoodModel {
  String imagePath;
  List<FavoriteFoodVMs> favoriteFoodVMs;

  FavouriteFoodModel({this.imagePath, this.favoriteFoodVMs});

  FavouriteFoodModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    if (json['favoriteFoodVMs'] != null) {
      favoriteFoodVMs = <FavoriteFoodVMs>[];
      json['favoriteFoodVMs'].forEach((v) {
        favoriteFoodVMs.add(new FavoriteFoodVMs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    if (this.favoriteFoodVMs != null) {
      data['favoriteFoodVMs'] =
          this.favoriteFoodVMs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteFoodVMs {
  String foodId;
  String name;
  String description;
  int servingSize;
  int calories;
  int fat;
  int protein;
  int carbs;
  String fileName;

  FavoriteFoodVMs(
      {this.foodId,
      this.name,
      this.description,
      this.servingSize,
      this.calories,
      this.fat,
      this.protein,
      this.carbs,
      this.fileName});

  FavoriteFoodVMs.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Description'];
    servingSize = json['ServingSize'];
    calories = json['Calories'];
    fat = json['fat'];
    protein = json['Protein'];
    carbs = json['Carbs'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['ServingSize'] = this.servingSize;
    data['Calories'] = this.calories;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['Carbs'] = this.carbs;
    data['FileName'] = this.fileName;
    return data;
  }
}
