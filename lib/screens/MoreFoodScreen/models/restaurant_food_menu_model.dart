class RestaurantFoodMenuModel {
  String imagePath;
  List<FoodDetails> foodDetails;

  RestaurantFoodMenuModel({this.imagePath, this.foodDetails});

  RestaurantFoodMenuModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    if (json['foodDetails'] != null) {
      foodDetails = <FoodDetails>[];
      json['foodDetails'].forEach((v) {
        foodDetails.add(new FoodDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    if (this.foodDetails != null) {
      data['foodDetails'] = this.foodDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodDetails {
  String restuarantId;
  String restaurantName;
  String foodId;
  String name;
  String description;
  String cuisine;
  String category;
  int servingSize;
  var calories;
  var fat;
  var protein;
  var carbs;
  var satFat;
  var sodium;
  var sugar;
  var sR;
  var tC;
  String unit;
  String fileName;

  FoodDetails(
      {this.restuarantId,
      this.restaurantName,
      this.foodId,
      this.name,
      this.description,
      this.cuisine,
      this.category,
      this.servingSize,
      this.calories,
      this.fat,
      this.protein,
      this.carbs,
      this.satFat,
      this.sodium,
      this.sugar,
      this.sR,
      this.tC,
      this.unit,
      this.fileName});

  FoodDetails.fromJson(Map<String, dynamic> json) {
    restuarantId = json['RestuarantId'];
    restaurantName = json['RestaurantName'];
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Description'];
    cuisine = json['Cuisine'];
    category = json['Category'];
    servingSize = json['ServingSize'];
    calories = json['Calories'];
    fat = json['fat'];
    protein = json['Protein'];
    carbs = json['Carbs'];
    satFat = json['SatFat'];
    sodium = json['Sodium'];
    sugar = json['Sugar'];
    sR = json['SR'];
    tC = json['TC'];
    unit = json['Unit'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RestuarantId'] = this.restuarantId;
    data['RestaurantName'] = this.restaurantName;
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Cuisine'] = this.cuisine;
    data['Category'] = this.category;
    data['ServingSize'] = this.servingSize;
    data['Calories'] = this.calories;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['Carbs'] = this.carbs;
    data['SatFat'] = this.satFat;
    data['Sodium'] = this.sodium;
    data['Sugar'] = this.sugar;
    data['SR'] = this.sR;
    data['TC'] = this.tC;
    data['Unit'] = this.unit;
    data['FileName'] = this.fileName;
    return data;
  }
}
