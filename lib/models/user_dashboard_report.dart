class UserDashboardReport {
  var avgExerciseVideoCount;
  var exVideoCount;
  var exTotatVideos;
  var avgCalCount;
  var totalBurnCal;
  var mindAvgVideoCount;
  var mindVideoCount;
  var totatMindVideos;
  var sleepcount;
  var goalBurnCal;
  var totalUserBurnCal;
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
  int totalWaterCount;
  int totalDays;
  WeightHistoryVM weightHistoryVM;

  UserDashboardReport(
      {this.avgExerciseVideoCount,
      this.exVideoCount,
      this.exTotatVideos,
      this.avgCalCount,
      this.totalBurnCal,
      this.mindAvgVideoCount,
      this.mindVideoCount,
      this.totatMindVideos,
      this.sleepcount,
      this.totalUserBurnCal,
      this.goalBurnCal,
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
      this.weightHistoryVM});

  UserDashboardReport.fromJson(Map<String, dynamic> json) {
    avgExerciseVideoCount = json['avgExerciseVideoCount'];
    exVideoCount = json['exVideoCount'];
    exTotatVideos = json['exTotatVideos'];
    totalUserBurnCal = json['totalUserBurnCal'];
    goalBurnCal = json['goalBurnCal'];
    avgCalCount = json['avgCalCount'];
    totalBurnCal = json['totalBurnCal'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgExerciseVideoCount'] = this.avgExerciseVideoCount;
    data['exVideoCount'] = this.exVideoCount;
    data['exTotatVideos'] = this.exTotatVideos;
    data['avgCalCount'] = this.avgCalCount;
    data['totalBurnCal'] = this.totalBurnCal;
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
    data['totalUserBurnCal'] = this.totalUserBurnCal;
    data['goalBurnCal'] = this.goalBurnCal;
    if (this.weightHistoryVM != null) {
      data['weightHistoryVM'] = this.weightHistoryVM.toJson();
    }
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
  int id;
  int goalId;
  int userId;
  int currentWeight;
  int goalWeight;
  var weighingDay;
  int activityLevel;
  int targetCalories;
  String createdAt;
  String modifiedAt;

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
