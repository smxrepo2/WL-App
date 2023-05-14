class ActivePlanModel {
  int planId;
  String title;
  String fileName;
  String duration;
  String description;
  String planType;

  ActivePlanModel(
      {this.planId,
        this.title,
        this.fileName,
        this.duration,
        this.description,
        this.planType});

  ActivePlanModel.fromJson(Map<String, dynamic> json) {
    planId = json['PlanId'];
    title = json['Title'];
    fileName = json['FileName'];
    duration = json['duration'];
    description = json['Description'];
    planType = json['PlanType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlanId'] = this.planId;
    data['Title'] = this.title;
    data['FileName'] = this.fileName;
    data['duration'] = this.duration;
    data['Description'] = this.description;
    data['PlanType'] = this.planType;
    return data;
  }
}