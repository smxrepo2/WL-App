class ExercisePlanModel {
  ExercisePlanModel({
    this.burners,
    this.imagePath,
    this.videoPath,
  });

  List<Burners> burners;
  String imagePath;
  String videoPath;

  factory ExercisePlanModel.fromJson(Map<String, dynamic> json) => ExercisePlanModel(
    burners: List<Burners>.from(json["burners"].map((x) => Burners.fromJson(x))),
    imagePath: json["ImagePath"],
    videoPath: json['VideoPath'],
    // videoPath: VideoPath.fromJson(json["VideoPath"]),
  );

  Map<String, dynamic> toJson() => {
    "burners": List<dynamic>.from(burners.map((x) => x.toJson())),
    "ImagePath": imagePath,
    "VideoPath":videoPath,
    //"VideoPath": videoPath.toJson(),
  };
}

class Burners {
  Burners({
    this.name,
    this.calories,
    this.fileName,
    this.duration,
    this.day,
    this.burnerId,
    this.title,
    this.exercisePlanId,
    this.planId,
    this.videoFile,
  });

  String name;
  double calories;
  String fileName;
  int duration;
  String day;
  int burnerId;
  String title;
  int exercisePlanId;
  int planId;
  String videoFile;

  factory Burners.fromJson(Map<String, dynamic> json) => Burners(
    name: json["Name"],
    calories: json["Calories"].toDouble(),
    fileName: json["FileName"],
    duration: json["Duration"],
    day: json["Day"],
    burnerId: json["BurnerId"],
    title: json["Title"],
    exercisePlanId: json["ExercisePlanId"],
    planId: json["PlanId"],
    videoFile: json["VideoFile"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Calories": calories,
    "FileName": fileName,
    "Duration": duration,
    "Day": day,
    "BurnerId": burnerId,
    "Title": title,
    "ExercisePlanId": exercisePlanId,
    "PlanId": planId,
    "VideoFile": videoFile,
  };
}

class VideoPath {
  VideoPath({
    this.fileName,
    this.contentType,
    this.fileDownloadName,
    this.lastModified,
    this.entityTag,
    this.enableRangeProcessing,
  });

  String fileName;
  String contentType;
  String fileDownloadName;
  dynamic lastModified;
  dynamic entityTag;
  bool enableRangeProcessing;

  factory VideoPath.fromJson(Map<String, dynamic> json) => VideoPath(
    fileName: json["FileName"],
    contentType: json["ContentType"],
    fileDownloadName: json["FileDownloadName"],
    lastModified: json["LastModified"],
    entityTag: json["EntityTag"],
    enableRangeProcessing: json["EnableRangeProcessing"],
  );

  Map<String, dynamic> toJson() => {
    "FileName": fileName,
    "ContentType": contentType,
    "FileDownloadName": fileDownloadName,
    "LastModified": lastModified,
    "EntityTag": entityTag,
    "EnableRangeProcessing": enableRangeProcessing,
  };
}
