class UserProfileData {
  ProfileVMs profileVMs;
  String streakLevel;
  String customerPackage;
  String imagepath;

  UserProfileData(
      {this.profileVMs,
      this.streakLevel,
      this.customerPackage,
      this.imagepath});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    profileVMs = json['profileVMs'] != null
        ? new ProfileVMs.fromJson(json['profileVMs'])
        : null;
    streakLevel = json['streakLevel'];
    customerPackage = json['customerPackage'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileVMs != null) {
      data['profileVMs'] = this.profileVMs.toJson();
    }
    data['streakLevel'] = this.streakLevel;
    data['customerPackage'] = this.customerPackage;
    data['imagepath'] = this.imagepath;
    return data;
  }
}

class ProfileVMs {
  int userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  bool iVR;
  String name;
  String dOB;
  var country;
  int targetCal;
  int weight;
  int currentweight;
  int startWeight;
  int goalWeight;
  var weighingDay;
  String fileName;
  int activityLevel;
  int goalId;
  int targetCalId;
  int profileId;
  int zipCode;
  int age;
  String gender;
  var mobile;
  double height;
  var callDuration;
  String joiningDate;
  String imageFile;
  String responseDto;

  ProfileVMs(
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
      this.responseDto});

  ProfileVMs.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
