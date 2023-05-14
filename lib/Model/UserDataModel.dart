// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);
class UserDataModel {
  UserDataModel({
    this.name,
    this.password,
    this.user,
    this.profileVM,
    this.keyToken,
    this.message,
    this.status,
    this.paid,
    this.responseDto,
  });

  String name;
  int status;
  bool paid;
  dynamic password;
  UserLocal user;
  ProfileVMModel profileVM;
  String keyToken;
  dynamic message;
  ResponseDto responseDto;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json["Name"],
      password: json["Password"],
      user: json["user"] != null ? UserLocal.fromJson(json["user"]) : null,
      profileVM: json["profileVM"] != null
          ? ProfileVMModel.fromJson(json["profileVM"])
          : null,
      keyToken: json["keyToken"],
      message: json["Message"],
      responseDto: json["responseDto"] != null
          ? ResponseDto.fromJson(json["responseDto"])
          : null,
      status: json['Status'],
      paid: json['Paid']);
      
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Password": password,
        "user": user?.toJson(),
        "profileVM": profileVM?.toJson(),
        "keyToken": keyToken,
        "Message": message,
        "Status": status,
        "responseDto": responseDto?.toJson(),
      };
}

class ResponseDto {
  ResponseDto({
    this.status,
    this.message,
    this.exception,
  });

  bool status;
  String message;
  dynamic exception;

  factory ResponseDto.fromJson(Map<String, dynamic> json) => ResponseDto(
        status: json["Status"],
        message: json["Message"],
        exception: json["Exception"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Exception": exception,
      };
}

class UserLocal {
  UserLocal({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.otp,
    this.isConfirmed,
    this.questionOrder,
    this.createdAt,
    this.modifiedAt,
  });

  int id;
  String userName;
  String email;
  String password;
  bool otp;
  bool isConfirmed;
  int questionOrder;
  DateTime createdAt;
  dynamic modifiedAt;

  factory UserLocal.fromJson(Map<String, dynamic> json) => UserLocal(
        id: json["Id"],
        userName: json["UserName"],
        email: json["Email"],
        password: json["Password"],
        otp: json["OTP"],
        isConfirmed: json["IsConfirmed"],
        questionOrder: json["QuestionOrder"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        modifiedAt: json["ModifiedAt"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Email": email,
        "Password": password,
        "OTP": otp,
        "IsConfirmed": isConfirmed,
        "QuestionOrder": questionOrder,
        "CreatedAt": createdAt.toIso8601String(),
        "ModifiedAt": modifiedAt,
      };
}

class ProfileVMModel {
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
  int weighingDay;
  String fileName;
  int activityLevel;
  int goalId;
  int targetCalId;
  int profileId;
  int zipCode;
  int age;
  String gender;
  String mobile;
  double height;
  int callDuration;
  String joiningDate;
  String imageFile;
  String responseDto;
  int planId;
  String type;
  String planName;
  String planImage;
  String cuisine;
  String restrictedFood;
  int streakLevel;
  String weightUnit;
  String heightUnit;
  String redeemStatus;
  int questionOrder;
  int totalFavCuisines;

  ProfileVMModel(
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
      this.restrictedFood,
      this.streakLevel,
      this.weightUnit,
      this.heightUnit,
      this.redeemStatus,
      this.questionOrder,
      this.totalFavCuisines});

  ProfileVMModel.fromJson(Map<String, dynamic> json) {
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
    height = json['Height'].toDouble();
    callDuration = json['CallDuration'];
    joiningDate = json['JoiningDate'];
    imageFile = json['ImageFile'];
    responseDto = json['responseDto'];
    planId = json['PlanId'];
    type = json['Type'];
    planName = json['PlanName'];
    planImage = json['PlanImage'];
    cuisine = json['Cuisine'];
    restrictedFood = json['RestrictedFood'];
    streakLevel = json['StreakLevel'];
    weightUnit = json['WeightUnit'];
    heightUnit = json['HeightUnit'];
    redeemStatus = json['RedeemStatus'];
    questionOrder = json['QuestionOrder'];
    totalFavCuisines = json['TotalFavCuisines'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['UserName'] = userName;
    data['Email'] = email;
    data['UserPassword'] = userPassword;
    data['IsConfirmed'] = isConfirmed;
    data['IVR'] = iVR;
    data['Name'] = name;
    data['DOB'] = dOB;
    data['Country'] = country;
    data['target_Cal'] = targetCal;
    data['Weight'] = weight;
    data['Currentweight'] = currentweight;
    data['StartWeight'] = startWeight;
    data['GoalWeight'] = goalWeight;
    data['WeighingDay'] = weighingDay;
    data['FileName'] = fileName;
    data['ActivityLevel'] = activityLevel;
    data['goal_Id'] = goalId;
    data['target_cal_Id'] = targetCalId;
    data['profile_Id'] = profileId;
    data['ZipCode'] = zipCode;
    data['Age'] = age;
    data['Gender'] = gender;
    data['Mobile'] = mobile;
    data['Height'] = height;
    data['CallDuration'] = callDuration;
    data['JoiningDate'] = joiningDate;
    data['ImageFile'] = imageFile;
    data['responseDto'] = responseDto;
    data['PlanId'] = planId;
    data['Type'] = type;
    data['PlanName'] = planName;
    data['PlanImage'] = planImage;
    data['Cuisine'] = cuisine;
    data['RestrictedFood'] = restrictedFood;
    data['StreakLevel'] = streakLevel;
    data['WeightUnit'] = weightUnit;
    data['HeightUnit'] = heightUnit;
    data['RedeemStatus'] = redeemStatus;
    data['QuestionOrder'] = questionOrder;
    data['TotalFavCuisines'] = totalFavCuisines;
    return data;
  }
}
