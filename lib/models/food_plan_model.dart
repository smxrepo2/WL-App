class  FoodPlanModel {
  List<Foods> foods;
  String imagePath;

  FoodPlanModel({this.foods, this.imagePath});

  FoodPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    data['ImagePath'] = this.imagePath;
    return data;
  }
}

class Foods {
  var foodId;
  var name;
  var description;
  var servingSize;
  var fat;
  var carbs;
  var protein;
  var calories;
  var fileName;
  var day;
  var mealType;

  Foods(
      {this.foodId,
        this.name,
        this.description,
        this.servingSize,
        this.fat,
        this.carbs,
        this.protein,
        this.calories,
        this.fileName,
        this.day,
        this.mealType});

  Foods.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Description'];
    servingSize = json['ServingSize'];
    fat = json['fat'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    calories = json['Calories'];
    fileName = json['FileName'];
    day = json['Day'];
    mealType = json['MealType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['ServingSize'] = this.servingSize;
    data['fat'] = this.fat;
    data['Carbs'] = this.carbs;
    data['Protein'] = this.protein;
    data['Calories'] = this.calories;
    data['FileName'] = this.fileName;
    data['Day'] = this.day;
    data['MealType'] = this.mealType;
    return data;
  }
}