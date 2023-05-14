class ExerciseUserModel {
  List<ExerciseGroupInfoVM> exerciseGroupInfoVM;
  ExerciseGroupInfoVM userDetails;

  ExerciseUserModel({this.exerciseGroupInfoVM, this.userDetails});

  ExerciseUserModel.fromJson(Map<String, dynamic> json) {
    if (json['exerciseGroupInfoVM'] != null) {
      exerciseGroupInfoVM = <ExerciseGroupInfoVM>[];
      json['exerciseGroupInfoVM'].forEach((v) {
        exerciseGroupInfoVM.add(new ExerciseGroupInfoVM.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new ExerciseGroupInfoVM.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exerciseGroupInfoVM != null) {
      data['exerciseGroupInfoVM'] =
          this.exerciseGroupInfoVM.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    return data;
  }
}

class ExerciseGroupInfoVM {
  int sequemceNo;
  int burnerId;
  int groupId;
  String name;
  String category;
  String fileName;
  int participants;
  String startAt;
  int duration;
  int calories;
  int targetParticipants;
  int distance;
  int slotId;
  int userId;
  String userName;
  String userFileName;
  String userTime;
  int burnCalories;
  int userDistance;

  ExerciseGroupInfoVM(
      {this.sequemceNo,
      this.burnerId,
      this.groupId,
      this.name,
      this.category,
      this.fileName,
      this.participants,
      this.startAt,
      this.duration,
      this.calories,
      this.targetParticipants,
      this.distance,
      this.slotId,
      this.userId,
      this.userName,
      this.userFileName,
      this.userTime,
      this.burnCalories,
      this.userDistance});

  ExerciseGroupInfoVM.fromJson(Map<String, dynamic> json) {
    sequemceNo = json['SequemceNo'];
    burnerId = json['BurnerId'];
    groupId = json['GroupId'];
    name = json['Name'];
    category = json['Category'];
    fileName = json['FileName'];
    participants = json['Participants'];
    startAt = json['StartAt'];
    duration = json['Duration'];
    calories = json['Calories'];
    targetParticipants = json['TargetParticipants'];
    distance = json['Distance'];
    slotId = json['SlotId'];
    userId = json['UserId'];
    userName = json['UserName'];
    userFileName = json['UserFileName'];
    userTime = json['UserTime'];
    burnCalories = json['BurnCalories'];
    userDistance = json['UserDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SequemceNo'] = this.sequemceNo;
    data['BurnerId'] = this.burnerId;
    data['GroupId'] = this.groupId;
    data['Name'] = this.name;
    data['Category'] = this.category;
    data['FileName'] = this.fileName;
    data['Participants'] = this.participants;
    data['StartAt'] = this.startAt;
    data['Duration'] = this.duration;
    data['Calories'] = this.calories;
    data['TargetParticipants'] = this.targetParticipants;
    data['Distance'] = this.distance;
    data['SlotId'] = this.slotId;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['UserFileName'] = this.userFileName;
    data['UserTime'] = this.userTime;
    data['BurnCalories'] = this.burnCalories;
    data['UserDistance'] = this.userDistance;
    return data;
  }
}
