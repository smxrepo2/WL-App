class UserFoodItems {
  List<FoodHistory> foodHistory;
  List<CustomFood> customFood;

  UserFoodItems({this.foodHistory, this.customFood});

  UserFoodItems.fromJson(Map<String, dynamic> json) {
    if (json['foodHistory'] != null) {
      foodHistory = [];
      json['foodHistory'].forEach((v) {
        foodHistory.add(new FoodHistory.fromJson(v));
      });
    }
    if (json['customFood'] != null) {
      customFood = [];
      json['customFood'].forEach((v) {
        customFood.add(new CustomFood.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodHistory != null) {
      data['foodHistory'] = this.foodHistory.map((v) => v.toJson()).toList();
    }
    if (this.customFood != null) {
      data['customFood'] = this.customFood.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodHistory {
  var id;
  var foodId;
  var carbs;
  var fat;
  var protein;
  var servingSize;
  var consCalories;
  String fName;
  String foodDate;

  FoodHistory(
      {this.id,
        this.foodId,
        this.carbs,
        this.fat,
        this.protein,
        this.servingSize,
        this.consCalories,
        this.fName,
        this.foodDate});

  FoodHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    foodId = json['FoodId'];
    carbs = json['Carbs'];
    fat = json['fat'];
    protein = json['Protein'];
    servingSize = json['ServingSize'];
    consCalories = json['cons_calories'];
    fName = json['f_name'];
    foodDate = json['food_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FoodId'] = this.foodId;
    data['Carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['ServingSize'] = this.servingSize;
    data['cons_calories'] = this.consCalories;
    data['f_name'] = this.fName;
    data['food_date'] = this.foodDate;
    return data;
  }
}

class CustomFood {
  var id;
  var userId;
  String name;
  String description;
  String foodId;
  String fileName;
  var servingSize;
  var houseHoldServing;
  var fat;
  var protein;
  var sodium;
  var sugar;
  var carbs;
  var fiber;
  var calories;
  String createdAt;
  String modifiedAt;

  CustomFood(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.foodId,
        this.fileName,
        this.servingSize,
        this.houseHoldServing,
        this.fat,
        this.protein,
        this.sodium,
        this.sugar,
        this.carbs,
        this.fiber,
        this.calories,
        this.createdAt,
        this.modifiedAt});

  CustomFood.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    name = json['Name'];
    description = json['Description'];
    foodId = json['FoodId'];
    fileName = json['FileName'];
    servingSize = json['ServingSize'];
    houseHoldServing = json['HouseHoldServing'];
    fat = json['fat'];
    protein = json['Protein'];
    sodium = json['Sodium'];
    sugar = json['Sugar'];
    carbs = json['Carbs'];
    fiber = json['Fiber'];
    calories = json['Calories'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['FoodId'] = this.foodId;
    data['FileName'] = this.fileName;
    data['ServingSize'] = this.servingSize;
    data['HouseHoldServing'] = this.houseHoldServing;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['Sodium'] = this.sodium;
    data['Sugar'] = this.sugar;
    data['Carbs'] = this.carbs;
    data['Fiber'] = this.fiber;
    data['Calories'] = this.calories;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}