class Plans {
  int id;
  int planTypeId;
  String title;
  String description;
  String details;
  String fileName;
  String duration;
  int calories;
  String createdAt;
  String modifiedAt;

  Plans(
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

  Plans.fromJson(Map<String, dynamic> json) {
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