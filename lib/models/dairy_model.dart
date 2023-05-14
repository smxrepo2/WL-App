import 'package:weight_loser/models/water_model.dart';

import 'exercise_item_model.dart';

class Dairy {
  var userId;
  String imagePath;
  String filterDate;
  BudgetVM budgetVM;
  List<WaterModel> waterList;
  List<BreakfastList> breakfastList;
  List<LuncheList> luncheList;
  List<DinnerList> dinnerList;
  List<SnackList> snackList;
  List<ExceriseModel> userExcerciseList;

  Dairy(
      {this.userId,
        this.imagePath,
        this.filterDate,
        this.budgetVM,
        this.waterList,
        this.breakfastList,
        this.luncheList,
        this.dinnerList,
        this.snackList,
        this.userExcerciseList});

  Dairy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    imagePath = json['ImagePath'];
    filterDate = json['filter_date'];
    budgetVM = json['budgetVM'] != null
        ? new BudgetVM.fromJson(json['budgetVM'])
        : null;
    if (json['waterList'] != null) {
      waterList = new List<WaterModel>();
      json['waterList'].forEach((v) {
        waterList.add(new WaterModel.fromJson(v));
      });
    }
    if (json['BreakfastList'] != null) {
      breakfastList = new List<BreakfastList>();
      json['BreakfastList'].forEach((v) {
        breakfastList.add(new BreakfastList.fromJson(v));
      });
    }
    if (json['LuncheList'] != null) {
      luncheList = new List<LuncheList>();
      json['LuncheList'].forEach((v) {
        luncheList.add(new LuncheList.fromJson(v));
      });
    }
    if (json['DinnerList'] != null) {
      dinnerList = new List<DinnerList>();
      json['DinnerList'].forEach((v) {
        dinnerList.add(new DinnerList.fromJson(v));
      });
    }
    if (json['SnackList'] != null) {
      snackList = new List<SnackList>();
      json['SnackList'].forEach((v) {
        snackList.add(new SnackList.fromJson(v));
      });
    }
    if (json['UserExcerciseList'] != null) {
      userExcerciseList = new List<ExceriseModel>();
      json['UserExcerciseList'].forEach((v) {
        userExcerciseList.add(new ExceriseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['ImagePath'] = this.imagePath;
    data['filter_date'] = this.filterDate;
    if (this.budgetVM != null) {
      data['budgetVM'] = this.budgetVM.toJson();
    }
    if (this.waterList != null) {
      data['waterList'] = this.waterList.map((v) => v.toJson()).toList();
    }
    if (this.breakfastList != null) {
      data['BreakfastList'] =
          this.breakfastList.map((v) => v.toJson()).toList();
    }
    if (this.luncheList != null) {
      data['LuncheList'] = this.luncheList.map((v) => v.toJson()).toList();
    }
    if (this.dinnerList != null) {
      data['DinnerList'] = this.dinnerList.map((v) => v.toJson()).toList();
    }
    if (this.snackList != null) {
      data['SnackList'] = this.snackList.map((v) => v.toJson()).toList();
    }
    if (this.userExcerciseList != null) {
      data['UserExcerciseList'] =
          this.userExcerciseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetVM {
  var budgetId;
  var targetCalId;
  var burnCalories;
  var consCalories;
  var userId;
  var targetCalories;
  var fat;
  var carbs;
  var protein;
  String createdAt;

  BudgetVM(
      {this.budgetId,
        this.targetCalId,
        this.burnCalories,
        this.consCalories,
        this.userId,
        this.targetCalories,
        this.fat,
        this.carbs,
        this.protein,
        this.createdAt});

  BudgetVM.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_Id'];
    targetCalId = json['target_cal_id'];
    burnCalories = json['Burn_Calories'];
    consCalories = json['Cons_Calories'];
    userId = json['UserId'];
    targetCalories = json['TargetCalories'];
    fat = json['fat'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['budget_Id'] = this.budgetId;
    data['target_cal_id'] = this.targetCalId;
    data['Burn_Calories'] = this.burnCalories;
    data['Cons_Calories'] = this.consCalories;
    data['UserId'] = this.userId;
    data['TargetCalories'] = this.targetCalories;
    data['fat'] = this.fat;
    data['Carbs'] = this.carbs;
    data['Protein'] = this.protein;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}


class BreakfastList {
  var bfId;
  var consCalories;
  String fName;
  String bfDate;

  BreakfastList({this.bfId, this.consCalories, this.fName, this.bfDate});

  BreakfastList.fromJson(Map<String, dynamic> json) {
    bfId = json['bf_id'];
    consCalories = json['cons_calories'];
    fName = json['f_name'];
    bfDate = json['bf_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bf_id'] = this.bfId;
    data['cons_calories'] = this.consCalories;
    data['f_name'] = this.fName;
    data['bf_date'] = this.bfDate;
    return data;
  }
}

class LuncheList {
  var lId;
  var consCalories;
  String fName;
  String lDate;

  LuncheList({this.lId, this.consCalories, this.fName, this.lDate});

  LuncheList.fromJson(Map<String, dynamic> json) {
    lId = json['l_id'];
    consCalories = json['cons_calories'];
    fName = json['f_name'];
    lDate = json['l_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['l_id'] = this.lId;
    data['cons_calories'] = this.consCalories;
    data['f_name'] = this.fName;
    data['l_date'] = this.lDate;
    return data;
  }
}

class DinnerList {
  var dId;
  var consCalories;
  String fName;
  String dDate;

  DinnerList({this.dId, this.consCalories, this.fName, this.dDate});

  DinnerList.fromJson(Map<String, dynamic> json) {
    dId = json['d_id'];
    consCalories = json['cons_calories'];
    fName = json['f_name'];
    dDate = json['d_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d_id'] = this.dId;
    data['cons_calories'] = this.consCalories;
    data['f_name'] = this.fName;
    data['d_date'] = this.dDate;
    return data;
  }
}

class SnackList {
  var snckId;
  var consCalories;
  String fName;
  String snckDate;

  SnackList({this.snckId, this.consCalories, this.fName, this.snckDate});

  SnackList.fromJson(Map<String, dynamic> json) {
    snckId = json['snck_id'];
    consCalories = json['cons_calories'];
    fName = json['f_name'];
    snckDate = json['snck_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['snck_id'] = this.snckId;
    data['cons_calories'] = this.consCalories;
    data['f_name'] = this.fName;
    data['snck_date'] = this.snckDate;
    return data;
  }
}

