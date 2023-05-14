class HomeScreenModel {
  HomeScreenModel({
    this.userId,
    this.imagePath,
    this.filterDate,
    this.budgetVm,
    this.waterList,
    this.breakfastList,
    this.luncheList,
    this.dinnerList,
    this.snackList,
    this.userExcerciseList,
  });

  int userId;
  String imagePath;
  DateTime filterDate;
  BudgetVm budgetVm;
  dynamic waterList;
  dynamic breakfastList;
  dynamic luncheList;
  dynamic dinnerList;
  dynamic snackList;
  dynamic userExcerciseList;

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) => HomeScreenModel(
    userId: json["userId"],
    imagePath: json["ImagePath"],
    filterDate: DateTime.parse(json["filter_date"]),
    budgetVm: BudgetVm.fromJson(json["budgetVM"]),
    waterList: json["waterList"],
    breakfastList: json["BreakfastList"],
    luncheList: json["LuncheList"],
    dinnerList: json["DinnerList"],
    snackList: json["SnackList"],
    userExcerciseList: json["UserExcerciseList"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "ImagePath": imagePath,
    "filter_date": filterDate.toIso8601String(),
    "budgetVM": budgetVm.toJson(),
    "waterList": waterList,
    "BreakfastList": breakfastList,
    "LuncheList": luncheList,
    "DinnerList": dinnerList,
    "SnackList": snackList,
    "UserExcerciseList": userExcerciseList,
  };
}

class BudgetVm {
  BudgetVm({
    this.budgetId,
    this.targetCalId,
    this.burnCalories,
    this.consCalories,
    this.userId,
    this.targetCalories,
    this.fat,
    this.carbs,
    this.protein,
    this.createdAt,
  });

  int budgetId;
  int targetCalId;
  int burnCalories;
  int consCalories;
  int userId;
  int targetCalories;
  double fat;
  double carbs;
  double protein;
  DateTime createdAt;

  factory BudgetVm.fromJson(Map<String, dynamic> json) => BudgetVm(
    budgetId: json["budget_Id"],
    targetCalId: json["target_cal_id"],
    burnCalories: json["Burn_Calories"],
    consCalories: json["Cons_Calories"],
    userId: json["UserId"],
    targetCalories: json["TargetCalories"],
    fat: json["fat"].toDouble(),
    carbs: json["Carbs"].toDouble(),
    protein: json["Protein"].toDouble(),
    createdAt: DateTime.parse(json["CreatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "budget_Id": budgetId,
    "target_cal_id": targetCalId,
    "Burn_Calories": burnCalories,
    "Cons_Calories": consCalories,
    "UserId": userId,
    "TargetCalories": targetCalories,
    "fat": fat,
    "Carbs": carbs,
    "Protein": protein,
    "CreatedAt": createdAt.toIso8601String(),
  };
}
