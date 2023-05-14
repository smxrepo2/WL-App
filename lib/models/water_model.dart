class WaterModel {
  int id;
  int serving;
  int calories;
  String date;
  String createdAt;
  String modifiedAt;

  WaterModel(
      {this.id,
        this.serving,
        this.calories,
        this.date,
        this.createdAt,
        this.modifiedAt});

  WaterModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    serving = json['Serving'];
    calories = json['Calories'];
    date = json['Date'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Serving'] = this.serving;
    data['Calories'] = this.calories;
    data['Date'] = this.date;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}