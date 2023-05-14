class ActiveMind1 {
  List<CtiveMindPlanVMs> ctiveMindPlanVMs;
  String imagePath;
  String videoPath;

  ActiveMind1({this.ctiveMindPlanVMs, this.imagePath, this.videoPath});

  ActiveMind1.fromJson(Map<String, dynamic> json) {
    if (json['ctiveMindPlanVMs'] != null) {
      ctiveMindPlanVMs = <CtiveMindPlanVMs>[];
      json['ctiveMindPlanVMs'].forEach((v) {
        ctiveMindPlanVMs.add(new CtiveMindPlanVMs.fromJson(v));
      });
    }
    imagePath = json['ImagePath'];
    videoPath = json['VideoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ctiveMindPlanVMs != null) {
      data['ctiveMindPlanVMs'] =
          this.ctiveMindPlanVMs.map((v) => v.toJson()).toList();
    }
    data['ImagePath'] = this.imagePath;
    data['VideoPath'] = this.videoPath;
    return data;
  }
}

class CtiveMindPlanVMs {
  int vidId;
  String title;
  String description;
  String videoFile;
  int duration;
  String day;
  String planTitle;
  int mindPlanId;
  int totalCalories;
  Null planDuration;
  String planImage;
  int planTypeId;

  CtiveMindPlanVMs(
      {this.vidId,
        this.title,
        this.description,
        this.videoFile,
        this.duration,
        this.day,
        this.planTitle,
        this.mindPlanId,
        this.totalCalories,
        this.planDuration,
        this.planImage,
        this.planTypeId});

  CtiveMindPlanVMs.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['Title'];
    description = json['Description'];
    videoFile = json['VideoFile'];
    duration = json['Duration'];
    day = json['Day'];
    planTitle = json['PlanTitle'];
    mindPlanId = json['MindPlanId'];
    totalCalories = json['TotalCalories'];
    planDuration = json['PlanDuration'];
    planImage = json['PlanImage'];
    planTypeId = json['PlanTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vidId'] = this.vidId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['VideoFile'] = this.videoFile;
    data['Duration'] = this.duration;
    data['Day'] = this.day;
    data['PlanTitle'] = this.planTitle;
    data['MindPlanId'] = this.mindPlanId;
    data['TotalCalories'] = this.totalCalories;
    data['PlanDuration'] = this.planDuration;
    data['PlanImage'] = this.planImage;
    data['PlanTypeId'] = this.planTypeId;
    return data;
  }
}