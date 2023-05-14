class ExceriseModel {
  int ueId;
  String exName;
  int burnCalories;
  int exBurnCal;
  int duration;
  String excerciseDate;
  String fileName;

  ExceriseModel(
      {this.ueId,
        this.exName,
        this.burnCalories,
        this.exBurnCal,
        this.duration,
        this.excerciseDate,
        this.fileName});

  ExceriseModel.fromJson(Map<String, dynamic> json) {
    ueId = json['ue_id'];
    exName = json['ex_name'];
    burnCalories = json['burn_calories'];
    exBurnCal = json['ex_burn_cal'];
    duration = json['Duration'];
    excerciseDate = json['ExcerciseDate'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ue_id'] = this.ueId;
    data['ex_name'] = this.exName;
    data['burn_calories'] = this.burnCalories;
    data['ex_burn_cal'] = this.exBurnCal;
    data['Duration'] = this.duration;
    data['ExcerciseDate'] = this.excerciseDate;
    data['FileName'] = this.fileName;
    return data;
  }
}