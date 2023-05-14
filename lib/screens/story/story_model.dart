class StoryModel {
  var avgExerciseVideoCount;
  var exVideoCount;
  var exTotatVideos;
  var avgCalCount;
  var totalUserBurnCal;
  var goalBurnCal;
  var mindAvgVideoCount;
  var mindVideoCount;
  var totatMindVideos;
  var sleepcount;
  List<SleepHistory> sleepHistory;
  var userDietScore;
  var userDietAvgScore;
  var totalDietScore;
  var carbCount;
  var fatCount;
  var proteinCount;
  var calCount;
  var totalCalories;
  var perDayCal;
  var avgWaterCount;
  var totalWaterCount;
  var totalDays;
  WeightHistoryVM weightHistoryVM;
  List<SelfieVM> selfieVM;
  var activePlanDays;
  var cheatDays;
  String imagePath;

  StoryModel(
      {this.avgExerciseVideoCount,
      this.exVideoCount,
      this.exTotatVideos,
      this.avgCalCount,
      this.totalUserBurnCal,
      this.goalBurnCal,
      this.mindAvgVideoCount,
      this.mindVideoCount,
      this.totatMindVideos,
      this.sleepcount,
      this.sleepHistory,
      this.userDietScore,
      this.userDietAvgScore,
      this.totalDietScore,
      this.carbCount,
      this.fatCount,
      this.proteinCount,
      this.calCount,
      this.totalCalories,
      this.perDayCal,
      this.avgWaterCount,
      this.totalWaterCount,
      this.totalDays,
      this.weightHistoryVM,
      this.selfieVM,
      this.activePlanDays,
      this.cheatDays,
      this.imagePath});

  StoryModel.fromJson(Map<String, dynamic> json) {
    avgExerciseVideoCount = json['avgExerciseVideoCount'];
    exVideoCount = json['exVideoCount'];
    exTotatVideos = json['exTotatVideos'];
    avgCalCount = json['avgCalCount'];
    totalUserBurnCal = json['totalUserBurnCal'];
    goalBurnCal = json['goalBurnCal'];
    mindAvgVideoCount = json['mindAvgVideoCount'];
    mindVideoCount = json['mindVideoCount'];
    totatMindVideos = json['totatMindVideos'];
    sleepcount = json['sleepcount'];
    if (json['sleepHistory'] != null) {
      sleepHistory = <SleepHistory>[];
      json['sleepHistory'].forEach((v) {
        sleepHistory.add(new SleepHistory.fromJson(v));
      });
    }
    userDietScore = json['userDietScore'];
    userDietAvgScore = json['userDietAvgScore'];
    totalDietScore = json['totalDietScore'];
    carbCount = json['carbCount'];
    fatCount = json['fatCount'];
    proteinCount = json['proteinCount'];
    calCount = json['calCount'];
    totalCalories = json['totalCalories'];
    perDayCal = json['perDayCal'];
    avgWaterCount = json['avgWaterCount'];
    totalWaterCount = json['totalWaterCount'];
    totalDays = json['totalDays'];
    weightHistoryVM = json['weightHistoryVM'] != null
        ? new WeightHistoryVM.fromJson(json['weightHistoryVM'])
        : null;
    if (json['selfieVM'] != null) {
      selfieVM = <SelfieVM>[];
      json['selfieVM'].forEach((v) {
        selfieVM.add(new SelfieVM.fromJson(v));
      });
    }
    activePlanDays = json['activePlanDays'];
    cheatDays = json['cheatDays'];
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgExerciseVideoCount'] = this.avgExerciseVideoCount;
    data['exVideoCount'] = this.exVideoCount;
    data['exTotatVideos'] = this.exTotatVideos;
    data['avgCalCount'] = this.avgCalCount;
    data['totalUserBurnCal'] = this.totalUserBurnCal;
    data['goalBurnCal'] = this.goalBurnCal;
    data['mindAvgVideoCount'] = this.mindAvgVideoCount;
    data['mindVideoCount'] = this.mindVideoCount;
    data['totatMindVideos'] = this.totatMindVideos;
    data['sleepcount'] = this.sleepcount;
    if (this.sleepHistory != null) {
      data['sleepHistory'] = this.sleepHistory.map((v) => v.toJson()).toList();
    }
    data['userDietScore'] = this.userDietScore;
    data['userDietAvgScore'] = this.userDietAvgScore;
    data['totalDietScore'] = this.totalDietScore;
    data['carbCount'] = this.carbCount;
    data['fatCount'] = this.fatCount;
    data['proteinCount'] = this.proteinCount;
    data['calCount'] = this.calCount;
    data['totalCalories'] = this.totalCalories;
    data['perDayCal'] = this.perDayCal;
    data['avgWaterCount'] = this.avgWaterCount;
    data['totalWaterCount'] = this.totalWaterCount;
    data['totalDays'] = this.totalDays;
    if (this.weightHistoryVM != null) {
      data['weightHistoryVM'] = this.weightHistoryVM.toJson();
    }
    if (this.selfieVM != null) {
      data['selfieVM'] = this.selfieVM.map((v) => v.toJson()).toList();
    }
    data['activePlanDays'] = this.activePlanDays;
    data['cheatDays'] = this.cheatDays;
    data['ImagePath'] = this.imagePath;
    return data;
  }
}

class SleepHistory {
  String sleepTime;
  String sleepType;

  SleepHistory({this.sleepTime, this.sleepType});

  SleepHistory.fromJson(Map<String, dynamic> json) {
    sleepTime = json['SleepTime'];
    sleepType = json['SleepType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SleepTime'] = this.sleepTime;
    data['SleepType'] = this.sleepType;
    return data;
  }
}

class WeightHistoryVM {
  var avgWeight;
  List<Goals> goals;

  WeightHistoryVM({this.avgWeight, this.goals});

  WeightHistoryVM.fromJson(Map<String, dynamic> json) {
    avgWeight = json['AvgWeight'];
    if (json['goals'] != null) {
      goals = <Goals>[];
      json['goals'].forEach((v) {
        goals.add(new Goals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvgWeight'] = this.avgWeight;
    if (this.goals != null) {
      data['goals'] = this.goals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Goals {
  var id;
  var goalId;
  var userId;
  var currentWeight;
  var goalWeight;
  Null weighingDay;
  var activityLevel;
  var targetCalories;
  String createdAt;
  Null modifiedAt;

  Goals(
      {this.id,
      this.goalId,
      this.userId,
      this.currentWeight,
      this.goalWeight,
      this.weighingDay,
      this.activityLevel,
      this.targetCalories,
      this.createdAt,
      this.modifiedAt});

  Goals.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    goalId = json['GoalId'];
    userId = json['UserId'];
    currentWeight = json['CurrentWeight'];
    goalWeight = json['GoalWeight'];
    weighingDay = json['WeighingDay'];
    activityLevel = json['ActivityLevel'];
    targetCalories = json['TargetCalories'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['GoalId'] = this.goalId;
    data['UserId'] = this.userId;
    data['CurrentWeight'] = this.currentWeight;
    data['GoalWeight'] = this.goalWeight;
    data['WeighingDay'] = this.weighingDay;
    data['ActivityLevel'] = this.activityLevel;
    data['TargetCalories'] = this.targetCalories;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class SelfieVM {
  var id;
  var userId;
  var weight;
  var waist;
  String dated;
  String imageName;
  String createdAt;
  Null modifiedAt;

  SelfieVM(
      {this.id,
      this.userId,
      this.weight,
      this.waist,
      this.dated,
      this.imageName,
      this.createdAt,
      this.modifiedAt});

  SelfieVM.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    weight = json['Weight'];
    waist = json['Waist'];
    dated = json['Dated'];
    imageName = json['ImageName'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Weight'] = this.weight;
    data['Waist'] = this.waist;
    data['Dated'] = this.dated;
    data['ImageName'] = this.imageName;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
