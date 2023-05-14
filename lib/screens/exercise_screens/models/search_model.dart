class CustomExerciseSearch {
  int id;
  int burnerTypeId;
  String name;
  Null description;
  int duration;
  int calories;
  String fileName;
  String videoFile;
  Null type;
  Null category;
  int videoDuration;
  Null createdAt;
  Null modifiedAt;

  CustomExerciseSearch(
      {this.id,
      this.burnerTypeId,
      this.name,
      this.description,
      this.duration,
      this.calories,
      this.fileName,
      this.videoFile,
      this.type,
      this.category,
      this.videoDuration,
      this.createdAt,
      this.modifiedAt});

  CustomExerciseSearch.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    burnerTypeId = json['BurnerTypeId'];
    name = json['Name'];
    description = json['Description'];
    duration = json['Duration'];
    calories = json['Calories'];
    fileName = json['FileName'];
    videoFile = json['VideoFile'];
    type = json['Type'];
    category = json['Category'];
    videoDuration = json['VideoDuration'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BurnerTypeId'] = this.burnerTypeId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    data['Calories'] = this.calories;
    data['FileName'] = this.fileName;
    data['VideoFile'] = this.videoFile;
    data['Type'] = this.type;
    data['Category'] = this.category;
    data['VideoDuration'] = this.videoDuration;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
