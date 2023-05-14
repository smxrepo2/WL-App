class StatsModel {
  List<FoodSum> foodSum;
  List<TargetConsumeCal> targetConsumeCal;
  List<FoodByCal> foodByCal;

  StatsModel({this.foodSum, this.targetConsumeCal, this.foodByCal});

  StatsModel.fromJson(Map<String, dynamic> json) {
    if (json['foodSum'] != null) {
      foodSum = new List<FoodSum>();
      json['foodSum'].forEach((v) {
        foodSum.add(new FoodSum.fromJson(v));
      });
    }
    if (json['targetConsumeCal'] != null) {
      targetConsumeCal = new List<TargetConsumeCal>();
      json['targetConsumeCal'].forEach((v) {
        targetConsumeCal.add(new TargetConsumeCal.fromJson(v));
      });
    }
    if (json['foodByCal'] != null) {
      foodByCal = new List<FoodByCal>();
      json['foodByCal'].forEach((v) {
        foodByCal.add(new FoodByCal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodSum != null) {
      data['foodSum'] = this.foodSum.map((v) => v.toJson()).toList();
    }
    if (this.targetConsumeCal != null) {
      data['targetConsumeCal'] =
          this.targetConsumeCal.map((v) => v.toJson()).toList();
    }
    if (this.foodByCal != null) {
      data['foodByCal'] = this.foodByCal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodSum {
  int id;
  Null foodId;
  dynamic carbs;
  dynamic fat;
  dynamic protein;
  int servingSize;
  int consCalories;
  Null fName;
  String foodDate;

  FoodSum(
      {this.id,
      this.foodId,
      this.carbs,
      this.fat,
      this.protein,
      this.servingSize,
      this.consCalories,
      this.fName,
      this.foodDate});

  FoodSum.fromJson(Map<String, dynamic> json) {
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

class TargetConsumeCal {
  int consCal;
  int targetCal;

  TargetConsumeCal({this.consCal, this.targetCal});

  TargetConsumeCal.fromJson(Map<String, dynamic> json) {
    consCal = json['cons_Cal'];
    targetCal = json['target_Cal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cons_Cal'] = this.consCal;
    data['target_Cal'] = this.targetCal;
    return data;
  }
}

class FoodByCal {
  int id;
  String foodId;
  dynamic carbs;
  dynamic fat;
  dynamic protein;
  int servingSize;
  int consCalories;
  String fName;
  String foodDate;

  FoodByCal(
      {this.id,
      this.foodId,
      this.carbs,
      this.fat,
      this.protein,
      this.servingSize,
      this.consCalories,
      this.fName,
      this.foodDate});

  FoodByCal.fromJson(Map<String, dynamic> json) {
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
