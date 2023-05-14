class FoodModel {
  int id;
  String name;
  String description;
  String foodId;
  String fileName;
  var servingSize;
  var houseHoldServing;
  dynamic fat;
  dynamic protein;
  dynamic carbs;
  var calories;
  String createdAt;
  String modifiedAt;

  FoodModel(
      {this.id,
        this.name,
        this.description,
        this.foodId,
        this.fileName,
        this.servingSize,
        this.houseHoldServing,
        this.fat,
        this.protein,
        this.carbs,
        this.calories,
        this.createdAt,
        this.modifiedAt});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    foodId = json['FoodId'];
    fileName = json['FileName'];
    servingSize = json['ServingSize'];
    houseHoldServing = json['HouseHoldServing'];
    fat = json['fat'];
    protein = json['Protein'];
    carbs = json['Carbs'];
    calories = json['Calories'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['FoodId'] = this.foodId;
    data['FileName'] = this.fileName;
    data['ServingSize'] = this.servingSize;
    data['HouseHoldServing'] = this.houseHoldServing;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['Carbs'] = this.carbs;
    data['Calories'] = this.calories;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class FoodModel1 {
  FoodRecipie foodRecipie;
  FoodDetails foodDetails;

  FoodModel1({this.foodRecipie, this.foodDetails});

  FoodModel1.fromJson(Map<String, dynamic> json) {
    foodRecipie = json['foodRecipie'] != null
        ? new FoodRecipie.fromJson(json['foodRecipie'])
        : null;
    foodDetails = json['foodDetails'] != null
        ? new FoodDetails.fromJson(json['foodDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodRecipie != null) {
      data['foodRecipie'] = this.foodRecipie.toJson();
    }
    if (this.foodDetails != null) {
      data['foodDetails'] = this.foodDetails.toJson();
    }
    return data;
  }
}

class FoodRecipie {
  int id;
  int planId;
  int restuarantId;
  String foodId;
  String description;
  String procedure;
  String grocery;
  String items;
  int servingSize;
  String createdAt;
  String modifiedAt;

  FoodRecipie(
      {this.id,
        this.planId,
        this.restuarantId,
        this.foodId,
        this.description,
        this.procedure,
        this.grocery,
        this.items,
        this.servingSize,
        this.createdAt,
        this.modifiedAt});

  FoodRecipie.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    planId = json['PlanId'];
    restuarantId = json['RestuarantId'];
    foodId = json['FoodId'];
    description = json['Description'];
    procedure = json['Procedure'];
    grocery = json['Grocery'];
    items = json['Items'];
    servingSize = json['ServingSize'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PlanId'] = this.planId;
    data['RestuarantId'] = this.restuarantId;
    data['FoodId'] = this.foodId;
    data['Description'] = this.description;
    data['Procedure'] = this.procedure;
    data['Grocery'] = this.grocery;
    data['Items'] = this.items;
    data['ServingSize'] = this.servingSize;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class FoodDetails {
  int id;
  String name;
  String description;
  String foodId;
  String fileName;
  int servingSize;
  Null houseHoldServing;
  int fat;
  int protein;
  int satFat;
  int sodium;
  int fiber;
  int sugar;
  int carbs;
  int tC;
  int sR;
  int calories;
  Null unit;
  String cuisine;
  String category;
  int restuarantId;
  String createdAt;
  String modifiedAt;

  FoodDetails(
      {this.id,
        this.name,
        this.description,
        this.foodId,
        this.fileName,
        this.servingSize,
        this.houseHoldServing,
        this.fat,
        this.protein,
        this.satFat,
        this.sodium,
        this.fiber,
        this.sugar,
        this.carbs,
        this.tC,
        this.sR,
        this.calories,
        this.unit,
        this.cuisine,
        this.category,
        this.restuarantId,
        this.createdAt,
        this.modifiedAt});

  FoodDetails.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    foodId = json['FoodId'];
    fileName = json['FileName'];
    servingSize = json['ServingSize'];
    houseHoldServing = json['HouseHoldServing'];
    fat = json['fat'];
    protein = json['Protein'];
    satFat = json['SatFat'];
    sodium = json['Sodium'];
    fiber = json['Fiber'];
    sugar = json['Sugar'];
    carbs = json['Carbs'];
    tC = json['TC'];
    sR = json['SR'];
    calories = json['Calories'];
    unit = json['Unit'];
    cuisine = json['Cuisine'];
    category = json['Category'];
    restuarantId = json['RestuarantId'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['FoodId'] = this.foodId;
    data['FileName'] = this.fileName;
    data['ServingSize'] = this.servingSize;
    data['HouseHoldServing'] = this.houseHoldServing;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['SatFat'] = this.satFat;
    data['Sodium'] = this.sodium;
    data['Fiber'] = this.fiber;
    data['Sugar'] = this.sugar;
    data['Carbs'] = this.carbs;
    data['TC'] = this.tC;
    data['SR'] = this.sR;
    data['Calories'] = this.calories;
    data['Unit'] = this.unit;
    data['Cuisine'] = this.cuisine;
    data['Category'] = this.category;
    data['RestuarantId'] = this.restuarantId;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}