class UserTodoTaskModel {
  List<Tasks> tasks;

  UserTodoTaskModel({this.tasks});

  UserTodoTaskModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int id;
  String name;
  String description;
  String duration;
  int appleReward;
  String fileName;
  bool completed;

  Tasks(
      {this.id,
      this.name,
      this.description,
      this.duration,
      this.appleReward,
      this.fileName,
      this.completed});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    duration = json['Duration'];
    appleReward = json['AppleReward'];
    fileName = json['FileName'];
    completed = json['Completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    data['AppleReward'] = this.appleReward;
    data['FileName'] = this.fileName;
    data['Completed'] = this.completed;
    return data;
  }
}
