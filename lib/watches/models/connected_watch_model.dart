class ConnectedWatchModel {
  UserDevices userDevices;

  ConnectedWatchModel({this.userDevices});

  ConnectedWatchModel.fromJson(Map<String, dynamic> json) {
    userDevices = json['userDevices'] != null
        ? new UserDevices.fromJson(json['userDevices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDevices != null) {
      data['userDevices'] = this.userDevices.toJson();
    }
    return data;
  }
}

class UserDevices {
  int id;
  int userId;
  String device;
  bool active;
  String createdAt;
  Null modifiedAt;

  UserDevices(
      {this.id,
      this.userId,
      this.device,
      this.active,
      this.createdAt,
      this.modifiedAt});

  UserDevices.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    device = json['Device'];
    active = json['Active'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Device'] = this.device;
    data['Active'] = this.active;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
