class UserGoalData {
  List<Goals> goals;

  UserGoalData({this.goals});

  UserGoalData.fromJson(Map<String, dynamic> json) {
    if (json['goals'] != null) {
      goals = <Goals>[];
      json['goals'].forEach((v) {
        goals.add(new Goals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  var modifiedAt;

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
