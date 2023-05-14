class CustomExerciseModel {
  String imagePath;
  String videoPath;
  List<Burners> burners;

  CustomExerciseModel({this.imagePath, this.videoPath, this.burners});

  CustomExerciseModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    videoPath = json['VideoPath'];
    if (json['burners'] != null) {
      burners = <Burners>[];
      json['burners'].forEach((v) {
        burners.add(new Burners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    data['VideoPath'] = this.videoPath;
    if (this.burners != null) {
      data['burners'] = this.burners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Burners {
  int id;
  int burnerTypeId;
  String name;
  String description;
  int duration;
  int calories;
  String fileName;
  String videoFile;
  String type;
  String category;
  int videoDuration;
  String createdAt;
  String modifiedAt;

  Burners(
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

  Burners.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    burnerTypeId = json['BurnerTypeId'];
    name = json['Name'];
    description = json['Description'];
    duration = json['Duration'];
    calories = json['Calories'];
    fileName = json['FileName'] == null ? "" : json['FileName'];
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
