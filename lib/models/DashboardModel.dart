import 'package:weight_loser/models/MindPlanDashboardModel.dart';

class DashboardModel {
  String imagePath;
  String videoPath;
  ProfileVM profileVM;
  BudgetVM budgetVM;
  List<ActiveExercisePlans> activeExercisePlans;
  List<ActiveFoodPlans> activeFoodPlans;
  // List<ActiveMindPlan> activeMindPlanVMs;
  // ActiveMindPlan activeMindPlanVMs;
  MindPlans mindPlans;
  Meditation meditation;
  List<Blogs> blogs;
  var goalCarbCount;
  var goalProteinCount;
  var goalFatCount;

  DashboardModel(
      {this.imagePath,
      this.videoPath,
      this.profileVM,
      this.budgetVM,
      this.activeExercisePlans,
      this.activeFoodPlans,
      //this.activeMindPlanVMs,
      this.mindPlans,
      this.meditation,
      this.blogs,
      this.goalCarbCount,
      this.goalProteinCount,
      this.goalFatCount});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
      imagePath: json['ImagePath'],
      videoPath: json['VideoPath'],
      profileVM: json['profileVM'] != null
          ? new ProfileVM.fromJson(json['profileVM'])
          : null,
      budgetVM: json['budgetVM'] != null
          ? new BudgetVM.fromJson(json['budgetVM'])
          : null,
      activeExercisePlans: (json['activeExercisePlans'] != null)
          ? List<ActiveExercisePlans>.from(json["activeExercisePlans"]
              .map((x) => ActiveExercisePlans.fromJson(x)))
          : null,
      activeFoodPlans: (json['activeFoodPlans'] != null)
          ? List<ActiveFoodPlans>.from(
              json["activeFoodPlans"].map((x) => ActiveFoodPlans.fromJson(x)))
          : null,
      // activeMindPlanVMs: (json[' activeMindPlanVMs'] != null)
      //     ? List<ActiveMindPlan>.from(json[" activeMindPlanVMs"].map((x) => ActiveMindPlan.fromJson(x)))
      //     : null,
      //activeMindPlanVMs: json['mindPlans'] != null ? new ActiveMindPlan.fromJson(json['activeMindPlanVMs']) : null,
      mindPlans: json['mindPlans'] != null
          ? new MindPlans.fromJson(json['mindPlans'])
          : null,
      meditation: json['meditation'] != null
          ? new Meditation.fromJson(json['meditation'])
          : null,
      blogs: json['Blogs'] != null
          ? List<Blogs>.from(json["Blogs"].map((x) => Blogs.fromJson(x)))
          : null,
      goalCarbCount: json['goalCarbCount'],
      goalFatCount: json['goalFatCount'],
      goalProteinCount: json['goalProteinCount']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    data['VideoPath'] = this.videoPath;
    if (this.profileVM != null) {
      data['profileVM'] = this.profileVM.toJson();
    }
    if (this.budgetVM != null) {
      data['budgetVM'] = this.budgetVM.toJson();
    }
    if (this.activeExercisePlans != null) {
      data['activeExercisePlans'] =
          this.activeExercisePlans.map((v) => v.toJson()).toList();
    }
    if (this.activeFoodPlans != null) {
      data['activeFoodPlans'] =
          this.activeFoodPlans.map((v) => v.toJson()).toList();
    }
    // if (this.activeMindPlanVMs != null) {
    //   data['activeMindPlan'] = this.activeMindPlanVMs.map((v) => v.toJson()).toList();
    // }
    // if (this.activeMindPlanVMs != null) {
    //   data['activeMindPlan'] = this.activeMindPlanVMs.toJson();
    // }
    if (this.mindPlans != null) {
      data['mindPlans'] = this.mindPlans.toJson();
    }
    if (this.meditation != null) {
      data['meditation'] = this.meditation.toJson();
    }
    if (this.blogs != null) {
      data['Blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    data['goalCarbCount'] = this.goalCarbCount;
    data['goalProteinCount'] = this.goalProteinCount;
    data['goalFatCount'] = this.goalFatCount;
    return data;
  }
}

class ProfileVM {
  var userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  String name;
  String dOB;
  String country;
  var targetCal;
  var weight;
  var currentweight;
  var startWeight;
  var goalWeight;
  String weighingDay;
  String imageUrl;
  var activityLevel;
  String fileName;
  var goalId;
  var targetCalId;
  var profileId;
  var zipCode;
  var age;
  String gender;
  var height;
  String imageFile;
  String streakLevel;
  String responseDto;

  ProfileVM(
      {this.userId,
      this.userName,
      this.email,
      this.streakLevel,
      this.userPassword,
      this.isConfirmed,
      this.name,
      this.dOB,
      this.country,
      this.targetCal,
      this.weight,
      this.currentweight,
      this.startWeight,
      this.goalWeight,
      this.weighingDay,
      this.imageUrl,
      this.activityLevel,
      this.fileName,
      this.goalId,
      this.targetCalId,
      this.profileId,
      this.zipCode,
      this.age,
      this.gender,
      this.height,
      this.imageFile,
      this.responseDto});

  ProfileVM.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['UserName'];
    email = json['Email'];
    userPassword = json['UserPassword'];
    isConfirmed = json['IsConfirmed'];
    name = json['Name'];
    dOB = json['DOB'];
    country = json['Country'];
    streakLevel = json['StreakLevel'] == null ? '1' : json['StreakLevel'];
    targetCal = json['target_Cal'];
    weight = json['Weight'];
    currentweight = json['Currentweight'];
    startWeight = json['StartWeight'];
    goalWeight = json['GoalWeight'];
    weighingDay = json['WeighingDay'];
    imageUrl = json['ImageUrl'];
    activityLevel = json['ActivityLevel'];
    fileName = json['FileName'];
    goalId = json['goal_Id'];
    targetCalId = json['target_cal_Id'];
    profileId = json['profile_Id'];
    zipCode = json['ZipCode'];
    age = json['Age'];
    gender = json['Gender'];
    height = json['Height'];
    imageFile = json['ImageFile'];
    responseDto = json['responseDto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['UserPassword'] = this.userPassword;
    data['IsConfirmed'] = this.isConfirmed;
    data['Name'] = this.name;
    data['DOB'] = this.dOB;
    data['Country'] = this.country;
    data['target_Cal'] = this.targetCal;
    data['Weight'] = this.weight;
    data['StreakLevel'] = this.streakLevel;
    data['Currentweight'] = this.currentweight;
    data['StartWeight'] = this.startWeight;
    data['GoalWeight'] = this.goalWeight;
    data['WeighingDay'] = this.weighingDay;
    data['ImageUrl'] = this.imageUrl;
    data['ActivityLevel'] = this.activityLevel;
    data['FileName'] = this.fileName;
    data['goal_Id'] = this.goalId;
    data['target_cal_Id'] = this.targetCalId;
    data['profile_Id'] = this.profileId;
    data['ZipCode'] = this.zipCode;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['Height'] = this.height;
    data['ImageFile'] = this.imageFile;
    data['responseDto'] = this.responseDto;
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

class ActiveExercisePlans {
  String name;
  var calories;
  String burnerImage;
  var burnerDuration;
  String day;
  var burnerId;
  String title;
  var totalCalories;
  String planTitle;
  String planDuration;
  String planImage;
  var planTypeId;
  String videoFile;
  ActiveExercisePlans(
      {this.name,
      this.calories,
      this.burnerImage,
      this.burnerDuration,
      this.day,
      this.burnerId,
      this.title,
      this.totalCalories,
      this.planTitle,
      this.planDuration,
      this.planImage,
      this.planTypeId,
      this.videoFile});

  ActiveExercisePlans.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    calories = json['Calories'];
    burnerImage = json['BurnerImage'];
    burnerDuration = json['BurnerDuration'];
    day = json['Day'];
    burnerId = json['BurnerId'];
    title = json['Title'];
    totalCalories = json['TotalCalories'];
    planTitle = json['PlanTitle'];
    planDuration = json['PlanDuration'];
    planImage = json['PlanImage'];
    planTypeId = json['PlanTypeId'];
    videoFile = json['VideoFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Calories'] = this.calories;
    data['BurnerImage'] = this.burnerImage;
    data['BurnerDuration'] = this.burnerDuration;
    data['Day'] = this.day;
    data['BurnerId'] = this.burnerId;
    data['Title'] = this.title;
    data['TotalCalories'] = this.totalCalories;
    data['PlanTitle'] = this.planTitle;
    data['PlanDuration'] = this.planDuration;
    data['PlanImage'] = this.planImage;
    data['PlanTypeId'] = this.planTypeId;
    data['VideoFile'] = this.videoFile;
    return data;
  }
}

class ActiveFoodPlans {
  String foodId;
  String name;
  String description;
  String servingSize;
  var fat;
  var carbs;
  var protein;
  var calories;
  String foodImage;
  String day;
  var planId;
  String mealType;
  var totalCalories;
  String projectTitle;
  String projectDuration;
  String planImage;
  var planTypeId;

  ActiveFoodPlans(
      {this.foodId,
      this.name,
      this.description,
      this.servingSize,
      this.fat,
      this.carbs,
      this.protein,
      this.calories,
      this.foodImage,
      this.day,
      this.planId,
      this.mealType,
      this.totalCalories,
      this.projectTitle,
      this.projectDuration,
      this.planImage,
      this.planTypeId});

  ActiveFoodPlans.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Description'];
    servingSize = json['ServingSize'];
    fat = json['fat'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    calories = json['Calories'];
    foodImage = json['FoodImage'];
    day = json['Day'];
    planId = json['PlanId'];
    mealType = json['MealType'];
    totalCalories = json['TotalCalories'];
    projectTitle = json['ProjectTitle'];
    projectDuration = json['ProjectDuration'];
    planImage = json['PlanImage'];
    planTypeId = json['PlanTypeId'];
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
    data['FoodImage'] = this.foodImage;
    data['Day'] = this.day;
    data['PlanId'] = this.planId;
    data['MealType'] = this.mealType;
    data['TotalCalories'] = this.totalCalories;
    data['ProjectTitle'] = this.projectTitle;
    data['ProjectDuration'] = this.projectDuration;
    data['PlanImage'] = this.planImage;
    data['PlanTypeId'] = this.planTypeId;
    return data;
  }
}

class ActiveMindPlan {
  int vidId;
  String title;
  String description;
  String videoFile;
  int duration;
  String day;
  String planTitle;
  int mindPlanId;
  int totalCalories;
  Null planDuration;
  String planImage;
  int planTypeId;

  ActiveMindPlan(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.duration,
      this.day,
      this.planTitle,
      this.mindPlanId,
      this.totalCalories,
      this.planDuration,
      this.planImage,
      this.planTypeId});

  ActiveMindPlan.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['Title'];
    description = json['Description'];
    videoFile = json['VideoFile'];
    duration = json['Duration'];
    day = json['Day'];
    planTitle = json['PlanTitle'];
    mindPlanId = json['MindPlanId'];
    totalCalories = json['TotalCalories'];
    planDuration = json['PlanDuration'];
    planImage = json['PlanImage'];
    planTypeId = json['PlanTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vidId'] = this.vidId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['VideoFile'] = this.videoFile;
    data['Duration'] = this.duration;
    data['Day'] = this.day;
    data['PlanTitle'] = this.planTitle;
    data['MindPlanId'] = this.mindPlanId;
    data['TotalCalories'] = this.totalCalories;
    data['PlanDuration'] = this.planDuration;
    data['PlanImage'] = this.planImage;
    data['PlanTypeId'] = this.planTypeId;
    return data;
  }
}

class MindPlans {
  var id;
  var planTypeId;
  String title;
  String description;
  String details;
  String fileName;
  String duration;
  var calories;
  var userId;
  String createdAt;
  String modifiedAt;

  MindPlans(
      {this.id,
      this.planTypeId,
      this.title,
      this.description,
      this.details,
      this.fileName,
      this.duration,
      this.calories,
      this.userId,
      this.createdAt,
      this.modifiedAt});

  MindPlans.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    planTypeId = json['PlanTypeId'];
    title = json['Title'];
    description = json['Description'];
    details = json['Details'];
    fileName = json['FileName'];
    duration = json['duration'];
    calories = json['Calories'];
    userId = json['UserId'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PlanTypeId'] = this.planTypeId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Details'] = this.details;
    data['FileName'] = this.fileName;
    data['duration'] = this.duration;
    data['Calories'] = this.calories;
    data['UserId'] = this.userId;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class Meditation {
  var id;
  String title;
  String description;
  var duration;
  String videoFile;
  int userId;
  String createdAt;
  String modifiedAt;

  Meditation(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.videoFile,
      this.userId,
      this.createdAt,
      this.modifiedAt});

  Meditation.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
    userId = json['UserId'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    data['VideoFile'] = this.videoFile;
    data['UserId'] = this.userId;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
