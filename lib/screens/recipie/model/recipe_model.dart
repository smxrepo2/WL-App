class RecipeModel {
  List<FoodList> foodList;
  String favCuisine;
  List<Cuisines> cuisines;
  int totalCount;
  int breakFastCount;
  int lunchFastCount;
  int dinnerFastCount;
  int snackFastCount;
  String imagePath;

  RecipeModel(
      {this.foodList,
      this.favCuisine,
      this.cuisines,
      this.totalCount,
      this.breakFastCount,
      this.lunchFastCount,
      this.dinnerFastCount,
      this.snackFastCount,
      this.imagePath});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    if (json['foodList'] != null) {
      foodList = <FoodList>[];
      json['foodList'].forEach((v) {
        foodList.add(new FoodList.fromJson(v));
      });
    }
    favCuisine = json['favCuisine'];
    if (json['cuisines'] != null) {
      cuisines = <Cuisines>[];
      json['cuisines'].forEach((v) {
        cuisines.add(new Cuisines.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    breakFastCount = json['breakFastCount'];
    lunchFastCount = json['lunchFastCount'];
    dinnerFastCount = json['dinnerFastCount'];
    snackFastCount = json['snackFastCount'];
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodList != null) {
      data['foodList'] = this.foodList.map((v) => v.toJson()).toList();
    }
    data['favCuisine'] = this.favCuisine;
    if (this.cuisines != null) {
      data['cuisines'] = this.cuisines.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['breakFastCount'] = this.breakFastCount;
    data['lunchFastCount'] = this.lunchFastCount;
    data['dinnerFastCount'] = this.dinnerFastCount;
    data['snackFastCount'] = this.snackFastCount;
    data['ImagePath'] = this.imagePath;
    return data;
  }
}

class FoodList {
  String foodId;
  String name;
  String cuisine;
  String description;
  String servingSize;
  var fat;
  var carbs;
  var protein;
  var calories;
  String fileName;
  String day;
  int foodPlanId;
  int planId;
  String mealType;
  String planServingSize;
  String ingredients;
  bool isAllergic;
  String allergicFood;
  int phase;

  FoodList(
      {this.foodId,
      this.name,
      this.cuisine,
      this.description,
      this.servingSize,
      this.fat,
      this.carbs,
      this.protein,
      this.calories,
      this.fileName,
      this.day,
      this.foodPlanId,
      this.planId,
      this.mealType,
      this.planServingSize,
      this.ingredients,
      this.isAllergic,
      this.allergicFood,
      this.phase});

  FoodList.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    cuisine = json['Cuisine'];
    description = json['Description'];
    servingSize = json['ServingSize'];
    fat = json['fat'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    calories = json['Calories'];
    fileName = json['FileName'];
    day = json['Day'];
    foodPlanId = json['FoodPlanId'];
    planId = json['PlanId'];
    mealType = json['MealType'];
    planServingSize = json['PlanServingSize'];
    ingredients = json['Ingredients'];
    isAllergic = json['IsAllergic'];
    allergicFood = json['AllergicFood'];
    phase = json['Phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Cuisine'] = this.cuisine;
    data['Description'] = this.description;
    data['ServingSize'] = this.servingSize;
    data['fat'] = this.fat;
    data['Carbs'] = this.carbs;
    data['Protein'] = this.protein;
    data['Calories'] = this.calories;
    data['FileName'] = this.fileName;
    data['Day'] = this.day;
    data['FoodPlanId'] = this.foodPlanId;
    data['PlanId'] = this.planId;
    data['MealType'] = this.mealType;
    data['PlanServingSize'] = this.planServingSize;
    data['Ingredients'] = this.ingredients;
    data['IsAllergic'] = this.isAllergic;
    data['AllergicFood'] = this.allergicFood;
    data['Phase'] = this.phase;
    return data;
  }
}

class Cuisines {
  int id;
  String cuisineName;
  String country;
  String type;
  String createdAt;
  Null modifiedAt;

  Cuisines(
      {this.id,
      this.cuisineName,
      this.country,
      this.type,
      this.createdAt,
      this.modifiedAt});

  Cuisines.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cuisineName = json['CuisineName'];
    country = json['Country'];
    type = json['Type'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CuisineName'] = this.cuisineName;
    data['Country'] = this.country;
    data['Type'] = this.type;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
