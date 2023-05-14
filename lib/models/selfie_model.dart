class SelfieModel {
  String imagePath;
  List<UltimateSelfies> ultimateSelfies;

  SelfieModel({this.imagePath, this.ultimateSelfies});

  SelfieModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    if (json['ultimateSelfies'] != null) {
      ultimateSelfies = new List<UltimateSelfies>();
      json['ultimateSelfies'].forEach((v) {
        ultimateSelfies.add(new UltimateSelfies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    if (this.ultimateSelfies != null) {
      data['ultimateSelfies'] =
          this.ultimateSelfies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UltimateSelfies {
  int id;
  int userId;
  int weight;
  int waist;
  String dated;
  String imageName;
  String createdAt;
  String modifiedAt;

  UltimateSelfies(
      {this.id,
        this.userId,
        this.weight,
        this.waist,
        this.dated,
        this.imageName,
        this.createdAt,
        this.modifiedAt});

  UltimateSelfies.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    weight = json['Weight'];
    waist = json['Waist'];
    dated = json['Dated'];
    imageName = json['ImageName'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Weight'] = this.weight;
    data['Waist'] = this.waist;
    data['Dated'] = this.dated;
    data['ImageName'] = this.imageName;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}