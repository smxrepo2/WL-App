class UserDashboardModel {
  String imagePath;
  String videoPath;
  ProfileVM profileVM;
  BudgetVM budgetVM;
  List<ActiveExercisePlans> activeExercisePlans;
  List<ActiveFoodPlans> activeFoodPlans;
  MindPlans mindPlans;
  Meditation meditation;
  List<Blogs> blogs;

  UserDashboardModel(
      {this.imagePath,
        this.videoPath,
        this.profileVM,
        this.budgetVM,
        this.activeExercisePlans,
        this.activeFoodPlans,
        this.mindPlans,
        this.meditation,
        this.blogs});

  UserDashboardModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    videoPath = json['VideoPath'];
    profileVM = json['profileVM'] != null
        ? new ProfileVM.fromJson(json['profileVM'])
        : null;
    budgetVM = json['budgetVM'] != null
        ? new BudgetVM.fromJson(json['budgetVM'])
        : null;
    if (json['activeExercisePlans'] != null) {
      activeExercisePlans = new List<ActiveExercisePlans>();
      json['activeExercisePlans'].forEach((v) {
        activeExercisePlans.add(new ActiveExercisePlans.fromJson(v));
      });
    }
    if (json['activeFoodPlans'] != null) {
      activeFoodPlans = new List<ActiveFoodPlans>();
      json['activeFoodPlans'].forEach((v) {
        activeFoodPlans.add(new ActiveFoodPlans.fromJson(v));
      });
    }
    mindPlans = json['mindPlans'] != null
        ? new MindPlans.fromJson(json['mindPlans'])
        : null;
    meditation = json['meditation'] != null
        ? new Meditation.fromJson(json['meditation'])
        : null;
    if (json['Blogs'] != null) {
      blogs = new List<Blogs>();
      json['Blogs'].forEach((v) {
        blogs.add(new Blogs.fromJson(v));
      });
    }
  }

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
    if (this.mindPlans != null) {
      data['mindPlans'] = this.mindPlans.toJson();
    }
    if (this.meditation != null) {
      data['meditation'] = this.meditation.toJson();
    }
    if (this.blogs != null) {
      data['Blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileVM {
  int userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  String name;
  String dOB;
  Null country;
  int targetCal;
  int weight;
  int currentweight;
  int startWeight;
  int goalWeight;
  String weighingDay;
  Null imageUrl;
  int activityLevel;
  int goalId;
  int targetCalId;
  int profileId;
  int zipCode;
  int age;
  String gender;
  double height;
  Null imageFile;
  Null responseDto;

  ProfileVM(
      {this.userId,
        this.userName,
        this.email,
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
    targetCal = json['target_Cal'];
    weight = json['Weight'];
    currentweight = json['Currentweight'];
    startWeight = json['StartWeight'];
    goalWeight = json['GoalWeight'];
    weighingDay = json['WeighingDay'];
    imageUrl = json['ImageUrl'];
    activityLevel = json['ActivityLevel'];
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
    data['Currentweight'] = this.currentweight;
    data['StartWeight'] = this.startWeight;
    data['GoalWeight'] = this.goalWeight;
    data['WeighingDay'] = this.weighingDay;
    data['ImageUrl'] = this.imageUrl;
    data['ActivityLevel'] = this.activityLevel;
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
  int budgetId;
  int targetCalId;
  int burnCalories;
  int consCalories;
  int userId;
  int targetCalories;
  int fat;
  int carbs;
  int protein;
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
  double calories;
  String burnerImage;
  int burnerDuration;
  String day;
  int burnerId;
  String title;
  int totalCalories;
  String planTitle;
  String planDuration;
  String planImage;
  int planTypeId;

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
        this.planTypeId});

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
    return data;
  }
}

class ActiveFoodPlans {
  String foodId;
  String name;
  String description;
  String servingSize;
  double fat;
  double carbs;
  double protein;
  int calories;
  String foodImage;
  String day;
  int planId;
  String mealType;
  int totalCalories;
  String projectTitle;
  String projectDuration;
  String planImage;
  int planTypeId;

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

class MindPlans {
  int id;
  int planTypeId;
  String title;
  String description;
  String details;
  String fileName;
  String duration;
  int calories;
  String createdAt;
  Null modifiedAt;

  MindPlans(
      {this.id,
        this.planTypeId,
        this.title,
        this.description,
        this.details,
        this.fileName,
        this.duration,
        this.calories,
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
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class Meditation {
  int id;
  String title;
  String description;
  int duration;
  String videoFile;
  String createdAt;
  Null modifiedAt;

  Meditation(
      {this.id,
        this.title,
        this.description,
        this.duration,
        this.videoFile,
        this.createdAt,
        this.modifiedAt});

  Meditation.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
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
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class Blogs {
  int id;
  String title;
  int blogTypeId;
  String description;
  String content;
  String fileName;
  String createdAt;
  String modifiedAt;

  Blogs(
      {this.id,
        this.title,
        this.blogTypeId,
        this.description,
        this.content,
        this.fileName,
        this.createdAt,
        this.modifiedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    blogTypeId = json['BlogTypeId'];
    description = json['Description'];
    content = json['Content'];
    fileName = json['FileName'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['BlogTypeId'] = this.blogTypeId;
    data['Description'] = this.description;
    data['Content'] = this.content;
    data['FileName'] = this.fileName;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}