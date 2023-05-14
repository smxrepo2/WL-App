class MindDetailModel {
  List<MindPlans> mindPlans;
  String imagePath;
  String videoPath;

  MindDetailModel({this.mindPlans, this.imagePath, this.videoPath});

  MindDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['mindPlans'] != null) {
      mindPlans = <MindPlans>[];
      json['mindPlans'].forEach((v) {
        mindPlans.add(new MindPlans.fromJson(v));
      });
    }
    imagePath = json['ImagePath'];
    videoPath = json['VideoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mindPlans != null) {
      data['mindPlans'] = this.mindPlans.map((v) => v.toJson()).toList();
    }
    data['ImagePath'] = this.imagePath;
    data['VideoPath'] = this.videoPath;
    return data;
  }
}

class MindPlans {
  int vidId;
  String title;
  String description;
  String videoFile;
  String imageFile;
  int duration;
  String day;
  String planTitle;
  int planId;
  int mindPlanId;

  MindPlans(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.imageFile,
      this.duration,
      this.day,
      this.planTitle,
      this.planId,
      this.mindPlanId});

  MindPlans.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['Title'];
    description = json['Description'];
    videoFile = json['VideoFile'];
    imageFile = json['ImageFile'];
    duration = json['Duration'];
    day = json['Day'];
    planTitle = json['PlanTitle'];
    planId = json['PlanId'];
    mindPlanId = json['MindPlanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vidId'] = this.vidId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['VideoFile'] = this.videoFile;
    data['ImageFile'] = this.imageFile;
    data['Duration'] = this.duration;
    data['Day'] = this.day;
    data['PlanTitle'] = this.planTitle;
    data['PlanId'] = this.planId;
    data['MindPlanId'] = this.mindPlanId;
    return data;
  }
}
