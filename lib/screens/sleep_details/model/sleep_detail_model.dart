class SleepDetailModel {
  int sleepTime;
  String sleepcount;
  List<SleepHistory> sleepHistory;
  ProfileVM profileVM;
  List<Meditation> meditation;
  int day;

  SleepDetailModel(
      {this.sleepTime,
      this.sleepcount,
      this.sleepHistory,
      this.profileVM,
      this.meditation,
      this.day});

  SleepDetailModel.fromJson(Map<String, dynamic> json) {
    sleepTime = json['sleepTime'];
    sleepcount = json['sleepcount'];
    if (json['sleepHistory'] != null) {
      sleepHistory = <SleepHistory>[];
      json['sleepHistory'].forEach((v) {
        sleepHistory.add(new SleepHistory.fromJson(v));
      });
    }
    profileVM = json['profileVM'] != null
        ? new ProfileVM.fromJson(json['profileVM'])
        : null;
    if (json['meditation'] != null) {
      meditation = <Meditation>[];
      json['meditation'].forEach((v) {
        meditation.add(new Meditation.fromJson(v));
      });
    }
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sleepTime'] = this.sleepTime;
    data['sleepcount'] = this.sleepcount;
    if (this.sleepHistory != null) {
      data['sleepHistory'] = this.sleepHistory.map((v) => v.toJson()).toList();
    }
    if (this.profileVM != null) {
      data['profileVM'] = this.profileVM.toJson();
    }
    if (this.meditation != null) {
      data['meditation'] = this.meditation.map((v) => v.toJson()).toList();
    }
    data['day'] = this.day;
    return data;
  }
}

class SleepHistory {
  String sleepTime;
  String sleepType;

  SleepHistory({this.sleepTime, this.sleepType});

  SleepHistory.fromJson(Map<String, dynamic> json) {
    sleepTime = json['SleepTime'];
    sleepType = json['SleepType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SleepTime'] = this.sleepTime;
    data['SleepType'] = this.sleepType;
    return data;
  }
}

class ProfileVM {
  int userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  bool iVR;
  String name;
  String dOB;
  var country;
  var targetCal;
  var weight;
  var currentweight;
  var startWeight;
  var goalWeight;
  var weighingDay;
  String fileName;
  var activityLevel;
  var goalId;
  var targetCalId;
  var profileId;
  var zipCode;
  var age;
  String gender;
  var mobile;
  var height;
  var callDuration;
  String joiningDate;
  var imageFile;
  var responseDto;
  var planId;
  var type;
  var planName;
  var planImage;
  var cuisine;
  String streakLevel;
  String weightUnit;
  String heightUnit;
  String redeemStatus;

  ProfileVM(
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

  ProfileVM.fromJson(Map<String, dynamic> json) {
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

class Meditation {
  int id;
  String title;
  String description;
  int duration;
  String videoFile;
  String imageFile;
  int userId;
  bool isFeatured;
  int calories;
  var fromDate;
  var toDate;
  String createdAt;
  var modifiedAt;

  Meditation(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.videoFile,
      this.imageFile,
      this.userId,
      this.isFeatured,
      this.calories,
      this.fromDate,
      this.toDate,
      this.createdAt,
      this.modifiedAt});

  Meditation.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    duration = json['Duration'];
    videoFile = json['VideoFile'];
    imageFile = json['ImageFile'];
    userId = json['UserId'];
    isFeatured = json['IsFeatured'];
    calories = json['Calories'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
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
    data['ImageFile'] = this.imageFile;
    data['UserId'] = this.userId;
    data['IsFeatured'] = this.isFeatured;
    data['Calories'] = this.calories;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}
