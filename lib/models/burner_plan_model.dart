class BurnerPlanModel {
  String imagePath;
  String videoPath;
  List<Burners> burners;

  BurnerPlanModel({this.imagePath, this.videoPath, this.burners});

  BurnerPlanModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    videoPath = json['videoPath'];
    if (json['burners'] != null) {
      burners = new List<Burners>();
      json['burners'].forEach((v) {
        burners.add(new Burners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    data['videoPath'] = this.videoPath;
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
  var calories;
  String fileName;
  String videoFile;
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
        this.createdAt,
        this.modifiedAt});

  Burners.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    burnerTypeId = json['BurnerTypeId'];
    name = json['Name'];
    description = json['Description'];
    duration = json['Duration'];
    calories = json['Calories'];
    fileName = json['FileName'];
    videoFile = json['VideoFile'];
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
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}