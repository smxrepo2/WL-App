class MindPlanDashboardModel {
  String videoPath;
  List<VideosData> videosData;
  List<Blogs> blogs;

  MindPlanDashboardModel({this.videoPath, this.videosData, this.blogs});

  MindPlanDashboardModel.fromJson(Map<String, dynamic> json) {
    videoPath = json['videoPath'];
    if (json['videosData'] != null) {
      videosData = <VideosData>[];
      json['videosData'].forEach((v) {
        videosData.add(new VideosData.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoPath'] = this.videoPath;
    if (this.videosData != null) {
      data['videosData'] = this.videosData.map((v) => v.toJson()).toList();
    }
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
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
  String fromDate;
  String toDate;
  String createdAt;
  String modifiedAt;

  VideosData(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.videoFile,
      this.imageFile,
      this.userId,
      this.isFeatured,
      this.fromDate,
      this.toDate,
      this.createdAt,
      this.modifiedAt});

  VideosData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
    imageFile = json['ImageFile'];
    userId = json['UserId'];
    isFeatured = json['IsFeatured'];
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
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class Blogs {
  int id;
  String title;
  int blogTypeId;
  String description;
  String content;
  String fileName;
  String category;
  String subCategory;
  String cuisine;
  String createdAt;
  String modifiedAt;

  Blogs(
      {this.id,
      this.title,
      this.blogTypeId,
      this.description,
      this.content,
      this.fileName,
      this.category,
      this.subCategory,
      this.cuisine,
      this.createdAt,
      this.modifiedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    blogTypeId = json['BlogTypeId'];
    description = json['Description'];
    content = json['Content'];
    fileName = json['FileName'];
    category = json['Category'];
    subCategory = json['SubCategory'];
    cuisine = json['Cuisine'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['BlogTypeId'] = this.blogTypeId;
    data['Description'] = this.description;
    data['Content'] = this.content;
    data['FileName'] = this.fileName;
    data['Category'] = this.category;
    data['SubCategory'] = this.subCategory;
    data['Cuisine'] = this.cuisine;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
