class ScreenTextModel {
  List<ScreenText> screenText;
  List<Users> users;
  ScreenTextModel({this.screenText, this.users});
  ScreenTextModel.fromJson(Map<String, dynamic> json) {
    if (json['screenText'] != String) {
      screenText = <ScreenText>[];
      json['screenText'].forEach((v) {
        screenText.add(new ScreenText.fromJson(v));
      });
    }
    if (json['users'] != String) {
      users = <Users>[];
      json['users'].forEach((v) {
        users.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.screenText != String) {
      data['screenText'] = this.screenText.map((v) => v.toJson()).toList();
    }
    if (this.users != String) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScreenText {
  int id;
  String text;
  String type;
  String screenName;
  String createdAt;
  String modifiedAt;

  ScreenText(
      {this.id,
      this.text,
      this.type,
      this.screenName,
      this.createdAt,
      this.modifiedAt});

  ScreenText.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    text = json['Text'];
    type = json['Type'];
    screenName = json['ScreenName'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Text'] = this.text;
    data['Type'] = this.type;
    data['ScreenName'] = this.screenName;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

class Users {
  int userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  bool iVR;
  String name;
  String dOB;
  String country;
  int targetCal;
  int weight;
  int currentweight;
  int startWeight;
  int goalWeight;
  String weighingDay;
  String fileName;
  int activityLevel;
  int goalId;
  int targetCalId;
  int profileId;
  int zipCode;
  int age;
  String gender;
  String mobile;
  var height;
  String callDuration;
  String joiningDate;
  String imageFile;
  String responseDto;
  int planId;
  String type;
  String planName;
  String planImage;
  String cuisine;
  String streakLevel;
  String weightUnit;
  String heightUnit;
  String redeemStatus;

  Users(
      {this.userId,
      this.userName,
      this.email,
      this.userPassword,
      this.isConfirmed,
      this.iVR,
      this.name,
      this.dOB,
      this.country,
      this.targetCal,
      this.weight,
      this.currentweight,
      this.startWeight,
      this.goalWeight,
      this.weighingDay,
      this.fileName,
      this.activityLevel,
      this.goalId,
      this.targetCalId,
      this.profileId,
      this.zipCode,
      this.age,
      this.gender,
      this.mobile,
      this.height,
      this.callDuration,
      this.joiningDate,
      this.imageFile,
      this.responseDto,
      this.planId,
      this.type,
      this.planName,
      this.planImage,
      this.cuisine,
      this.streakLevel,
      this.weightUnit,
      this.heightUnit,
      this.redeemStatus});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['UserName'];
    email = json['Email'];
    userPassword = json['UserPassword'];
    isConfirmed = json['IsConfirmed'];
    iVR = json['IVR'];
    name = json['Name'];
    dOB = json['DOB'];
    country = json['Country'];
    targetCal = json['target_Cal'];
    weight = json['Weight'];
    currentweight = json['Currentweight'];
    startWeight = json['StartWeight'];
    goalWeight = json['GoalWeight'];
    weighingDay = json['WeighingDay'];
    fileName = json['FileName'];
    activityLevel = json['ActivityLevel'];
    goalId = json['goal_Id'];
    targetCalId = json['target_cal_Id'];
    profileId = json['profile_Id'];
    zipCode = json['ZipCode'];
    age = json['Age'];
    gender = json['Gender'];
    mobile = json['Mobile'];
    height = json['Height'];
    callDuration = json['CallDuration'];
    joiningDate = json['JoiningDate'];
    imageFile = json['ImageFile'];
    responseDto = json['responseDto'];
    planId = json['PlanId'];
    type = json['Type'];
    planName = json['PlanName'];
    planImage = json['PlanImage'];
    cuisine = json['Cuisine'];
    streakLevel = json['StreakLevel'];
    weightUnit = json['WeightUnit'];
    heightUnit = json['HeightUnit'];
    redeemStatus = json['RedeemStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['UserPassword'] = this.userPassword;
    data['IsConfirmed'] = this.isConfirmed;
    data['IVR'] = this.iVR;
    data['Name'] = this.name;
    data['DOB'] = this.dOB;
    data['Country'] = this.country;
    data['target_Cal'] = this.targetCal;
    data['Weight'] = this.weight;
    data['Currentweight'] = this.currentweight;
    data['StartWeight'] = this.startWeight;
    data['GoalWeight'] = this.goalWeight;
    data['WeighingDay'] = this.weighingDay;
    data['FileName'] = this.fileName;
    data['ActivityLevel'] = this.activityLevel;
    data['goal_Id'] = this.goalId;
    data['target_cal_Id'] = this.targetCalId;
    data['profile_Id'] = this.profileId;
    data['ZipCode'] = this.zipCode;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['Mobile'] = this.mobile;
    data['Height'] = this.height;
    data['CallDuration'] = this.callDuration;
    data['JoiningDate'] = this.joiningDate;
    data['ImageFile'] = this.imageFile;
    data['responseDto'] = this.responseDto;
    data['PlanId'] = this.planId;
    data['Type'] = this.type;
    data['PlanName'] = this.planName;
    data['PlanImage'] = this.planImage;
    data['Cuisine'] = this.cuisine;
    data['StreakLevel'] = this.streakLevel;
    data['WeightUnit'] = this.weightUnit;
    data['HeightUnit'] = this.heightUnit;
    data['RedeemStatus'] = this.redeemStatus;
    return data;
  }
}
