class CustomMindModel {
  String videoPath;
  String imagePath;
  List<VideosData> videosData;

  CustomMindModel({this.videoPath, this.imagePath, this.videosData});

  CustomMindModel.fromJson(Map<String, dynamic> json) {
    videoPath = json['videoPath'];
    imagePath = json['imagePath'];
    if (json['videosData'] != null) {
      videosData = <VideosData>[];
      json['videosData'].forEach((v) {
        videosData.add(new VideosData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoPath'] = this.videoPath;
    data['imagePath'] = this.imagePath;
    if (this.videosData != null) {
      data['videosData'] = this.videosData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideosData {
  int id;
  String title;
  String description;
  int duration;
  String videoFile;
  String imageFile;
  int userId;
  bool isFeatured;
  int calories;
  Null fromDate;
  Null toDate;
  String createdAt;
  Null modifiedAt;

  VideosData(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.videoFile,
      this.imageFile,
      this.userId,
      this.isFeatured,
      this.calories,
      this.fromDate,
      this.toDate,
      this.createdAt,
      this.modifiedAt});

  VideosData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'] == null ? "" : json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
    imageFile = json['ImageFile'] == null ? "" : json['ImageFile'];
    userId = json['UserId'];
    isFeatured = json['IsFeatured'];
    calories = json['Calories'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    data['VideoFile'] = this.videoFile;
    data['ImageFile'] = this.imageFile;
    data['UserId'] = this.userId;
    data['IsFeatured'] = this.isFeatured;
    data['Calories'] = this.calories;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
