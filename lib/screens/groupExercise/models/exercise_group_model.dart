class ExerciseGroupsModel {
  List<ExerciseGroups> exerciseGroups;

  ExerciseGroupsModel({this.exerciseGroups});

  ExerciseGroupsModel.fromJson(Map<String, dynamic> json) {
    if (json['exerciseGroups'] != null) {
      exerciseGroups = <ExerciseGroups>[];
      json['exerciseGroups'].forEach((v) {
        exerciseGroups.add(new ExerciseGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exerciseGroups != null) {
      data['exerciseGroups'] =
          this.exerciseGroups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExerciseGroups {
  int groupId;
  int burnerId;
  var name;
  var category;
  var fileName;
  int participants;
  String startAt;
  int duration;
  var calories;
  int targetParticipants;
  int distance;
  int slotId;

  ExerciseGroups(
      {this.groupId,
      this.burnerId,
      this.name,
      this.category,
      this.fileName,
      this.participants,
      this.startAt,
      this.duration,
      this.calories,
      this.targetParticipants,
      this.distance,
      this.slotId});

  ExerciseGroups.fromJson(Map<String, dynamic> json) {
    groupId = json['GroupId'];
    burnerId = json['BurnerId'];
    name = json['Name'] == null ? "Not Available" : json['Name'];
    category = json['Category'] == null ? "No Category" : json['Category'];
    fileName = json['FileName'] == null ? "" : json['FileName'];
    participants = json['Participants'];
    startAt = json['StartAt'];
    duration = json['Duration'];
    calories = json['Calories'];
    targetParticipants = json['TargetParticipants'];
    distance = json['Distance'];
    slotId = json['SlotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupId'] = this.groupId;
    data['BurnerId'] = this.burnerId;
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
    return data;
  }
}
