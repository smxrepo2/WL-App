class IndividualExerciseModel {
  FiveKRun fiveKRun;

  IndividualExerciseModel({this.fiveKRun});

  IndividualExerciseModel.fromJson(Map<String, dynamic> json) {
    fiveKRun = json['fiveKRun'] != null
        ? new FiveKRun.fromJson(json['fiveKRun'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fiveKRun != null) {
      data['fiveKRun'] = this.fiveKRun.toJson();
    }
    return data;
  }
}

class FiveKRun {
  var fastWalkMeters;
  var slowWalkMeters;
  int day;

  FiveKRun({this.fastWalkMeters, this.slowWalkMeters, this.day});

  FiveKRun.fromJson(Map<String, dynamic> json) {
    fastWalkMeters = json['fastWalkMeters'];
    slowWalkMeters = json['slowWalkMeters'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fastWalkMeters'] = this.fastWalkMeters;
    data['slowWalkMeters'] = this.slowWalkMeters;
    data['day'] = this.day;
    return data;
  }
}
