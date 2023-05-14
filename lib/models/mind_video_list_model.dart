class MindVideoListModel {
  String videoPath;
  List<Videos> userVideos;
  List<Videos> videos;

  MindVideoListModel({this.videoPath, this.userVideos, this.videos});

  MindVideoListModel.fromJson(Map<String, dynamic> json) {
    videoPath = json['videoPath'];
    if (json['UserVideos'] != null) {
      userVideos = new List<Videos>();
      json['UserVideos'].forEach((v) {
        userVideos.add(new Videos.fromJson(v));
      });
    }
    if (json['Videos'] != null) {
      videos = new List<Videos>();
      json['Videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoPath'] = this.videoPath;
    if (this.userVideos != null) {
      data['UserVideos'] = this.userVideos.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['Videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class UserVideos {
//   int id;
//   String title;
//   String description;
//   int duration;
//   String videoFile;
//   int userId;
//   String createdAt;
//   String modifiedAt;
//
//   UserVideos(
//       {this.id,
//         this.title,
//         this.description,
//         this.duration,
//         this.videoFile,
//         this.userId,
//         this.createdAt,
//         this.modifiedAt});
//
//   UserVideos.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     title = json['Title'];
//     description = json['Description'];
//     duration = json['Duration'];
//     videoFile = json['VideoFile'];
//     userId = json['UserId'];
//     createdAt = json['CreatedAt'];
//     modifiedAt = json['ModifiedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Title'] = this.title;
//     data['Description'] = this.description;
//     data['Duration'] = this.duration;
//     data['VideoFile'] = this.videoFile;
//     data['UserId'] = this.userId;
//     data['CreatedAt'] = this.createdAt;
//     data['ModifiedAt'] = this.modifiedAt;
//     return data;
//   }
// }

class Videos {
  int id;
  String title;
  String description;
  int duration;
  String videoFile;
  String imageFile;
  int userId;
  String createdAt;
  String modifiedAt;

  Videos(
      {this.id,
        this.title,
        this.description,
        this.duration,
        this.videoFile,
        this.imageFile,
        this.userId,
        this.createdAt,
        this.modifiedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
    imageFile=json['ImageFile'];
    userId = json['UserId'];
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
    data['ImageFile']=this.imageFile;
    data['UserId'] = this.userId;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}