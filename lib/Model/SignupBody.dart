import 'package:weight_loser/Model/customer_pkgs.dart';
import 'package:weight_loser/Model/rest_id.dart';

class SignUpBody {
  String userName;
  String email;
  String password;
  String name;
  int age;
  DietQuestions dietQuestions;
  List<RestId> restaurants;
  MindQuestions mindQuestions;
  ExerciseQuestions exerciseQuestions;
  CustomerPackages customerPackages;
  String facebookToken;
  String googleToken;
  String appleToken;

  SignUpBody(
      {this.userName,
      this.email,
      this.password,
      this.name,
      this.age,
      this.restaurants,
      this.dietQuestions,
      this.mindQuestions,
      this.exerciseQuestions,
      this.customerPackages,
      this.appleToken,
      this.facebookToken,
      this.googleToken});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    email = json['Email'];
    password = json['Password'];
    name = json['Name'];
    var resId = json['restaurants'];
    restaurants = resId.cast<RestId>() ?? [];
    age = json['Age'];
    customerPackages = json['customerPackages'] != null
        ? CustomerPackages.fromJson(json['customerPackages'])
        : "";
    exerciseQuestions = json['exerciseQuestions'] != null
        ? ExerciseQuestions.fromJson(json['exerciseQuestions'])
        : "";
    dietQuestions = json['dietQuestions'] != null
        ? DietQuestions.fromJson(json['dietQuestions'])
        : "";
    mindQuestions = json['mindQuestions'] != null
        ? MindQuestions.fromJson(json['mindQuestions'])
        : "";
    facebookToken = json['facebookToken'];
    googleToken = json['googleToken'];
    appleToken = json['appleToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['Email'] = email;
    data['Password'] = password;
    data['Name'] = name;
    data['Age'] = age;
    if (customerPackages != null) {
      data['customerPackages'] = customerPackages.toJson();
    }
    if (dietQuestions != null) {
      data['dietQuestions'] = dietQuestions.toJson();
    }
    data['restaurants'] = restaurants;
    if (mindQuestions != null) {
      data['mindQuestions'] = mindQuestions.toJson();
    }
    if (exerciseQuestions != null) {
      data['exerciseQuestions'] = exerciseQuestions.toJson();
    }
    data['facebookToken'] = facebookToken;
    data['googleToken'] = googleToken;
    data['appleToken'] = appleToken;
    return data;
  }
}

class SignUpRequestModel {
  String userName;
  String email;
  String password;
  String name;
  String UserDateTime;

  SignUpRequestModel(
      {this.userName,
        this.email,
        this.password,
        this.name,
         this.UserDateTime
});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    email = json['Email'];
    password = json['Password'];
    name = json['Name'];
    //UserDateTime=DateTime.tryParse(json['UserDateTime']);
     UserDateTime=json['UserDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['Email'] = email;
    data['Password'] = password;
    data['Name'] = name;
     data['UserDateTime']=UserDateTime;

    return data;
  }
}


dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

class DietQuestions {
  double height;
  String heightUnit;
  int currentWeight;
  String weightUnit;
  int goalWeight;
  String duration;
  String gender;
  String dOB;
  int sleepTime;
  String favCuisine;
  String noCuisine;
  String favRestuarant;
  String favFoods;
  String restrictedFood;
  String medicalCondition;
  String lifeStyle;
  String weightApps;
  String foodType;
  String allergies;
  DietQuestions(
      {this.height,
      this.heightUnit,
      this.currentWeight,
      this.weightUnit,
      this.goalWeight,
      this.duration,
      this.gender,
      this.dOB,
      this.sleepTime,
      this.favCuisine,
      this.noCuisine,
      this.favRestuarant,
      this.favFoods,
      this.restrictedFood,
      this.medicalCondition,
      this.lifeStyle,
      this.weightApps,
      this.allergies,
      this.foodType});

  DietQuestions.fromJson(Map<String, dynamic> json) {
    height = json['Height'] ?? 0.0;
    heightUnit = json['HeightUnit'] ?? "";
    currentWeight = json['CurrentWeight'];
    weightUnit = json['WeightUnit'];
    goalWeight = json['GoalWeight'];
    duration = json['Duration'];
    gender = json['Gender'];
    dOB = json['DOB'];
    // JSON.encode(json['DOB'], toEncodable: myEncode);

    sleepTime = json['SleepTime'];
    favCuisine = json['FavCuisine'];
    noCuisine = json['NoCuisine'];
    favRestuarant = json['FavRestuarant'];
    favFoods = json['FavFoods'];
    restrictedFood = json['RestrictedFood'];
    medicalCondition = json['MedicalCondition'];
    lifeStyle = json['LifeStyle'];
    weightApps = json['WeightApps'];
    foodType = json['FoodType'];
    allergies = json['Allergies'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Height'] = height;
    data['HeightUnit'] = heightUnit;
    data['CurrentWeight'] = currentWeight;
    data['WeightUnit'] = weightUnit;
    data['GoalWeight'] = goalWeight;
    data['Duration'] = duration;
    data['Gender'] = gender;
    data['DOB'] = dOB;
    data['SleepTime'] = sleepTime;
    data['FavCuisine'] = favCuisine;
    data['NoCuisine'] = noCuisine;
    data['FavRestuarant'] = favRestuarant;
    data['FavFoods'] = favFoods;
    data['RestrictedFood'] = restrictedFood;
    data['MedicalCondition'] = medicalCondition;
    data['LifeStyle'] = lifeStyle;
    data['WeightApps'] = weightApps;
    data['FoodType'] = foodType;
    data['Allergies'] = allergies;
    return data;
  }
}
class MindQuestions {
  String control;
  String preoccupied;
  String freeFood;
  String eatingRound;
  String cravings;
  String craveFoods;
  String stressedEating;
  String sadEating;
  String boredEating;
  String lonelyEating;
  String dailyEating;
  String sevenSleeping;
  String largeEating;
  String watchingEating;
  String freeTimeEating;
  String waterHabit;
  String lateNightHabit;
  String category;
  MindQuestions(
      {this.control,
      this.preoccupied,
      this.freeFood,
      this.eatingRound,
      this.cravings,
      this.craveFoods,
      this.stressedEating,
      this.sadEating,
      this.boredEating,
      this.lonelyEating,
      this.dailyEating,
      this.sevenSleeping,
      this.largeEating,
      this.watchingEating,
      this.freeTimeEating,
      this.waterHabit,
      this.lateNightHabit,
      this.category});
  MindQuestions.fromJson(Map<String, dynamic> json) {
    control = json['Control'] ?? "";
    preoccupied = json['Preoccupied'] ?? "";
    freeFood = json['FreeFood'] ?? "";
    eatingRound = json['EatingRound'] ?? "";
    cravings = json['Cravings'] ?? "";
    craveFoods = json['CraveFoods'] ?? "";
    stressedEating =
        json['StressedEating'] ?? "";
    sadEating = json['SadEating'] ?? "";
    boredEating = json['BoredEating'] ?? "";
    lonelyEating = json['LonelyEating'] ?? "";
    dailyEating = json['DailyEating'] ?? "";
    sevenSleeping = json['SevenSleeping'] ?? "";
    largeEating = json['LargeEating'] ?? "";
    watchingEating =
        json['WatchingEating'] ?? "";
    freeTimeEating =
        json['FreeTimeEating'] ?? "";
    waterHabit = json['WaterHabit'] ?? "";
    lateNightHabit =
        json['LateNightHabit'] ?? "";
    category = json['Category'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Control'] = control;
    data['Preoccupied'] = preoccupied;
    data['FreeFood'] = freeFood;
    data['EatingRound'] = eatingRound;
    data['Cravings'] = cravings;
    data['CraveFoods'] = craveFoods;
    data['StressedEating'] = stressedEating;
    data['SadEating'] = sadEating;
    data['BoredEating'] = boredEating;
    data['LonelyEating'] = lonelyEating;
    data['DailyEating'] = dailyEating;
    data['SevenSleeping'] = sevenSleeping;
    data['LargeEating'] = largeEating;
    data['WatchingEating'] = watchingEating;
    data['FreeTimeEating'] = freeTimeEating;
    data['WaterHabit'] = waterHabit;
    data['LateNightHabit'] = lateNightHabit;
    data['Category'] = category;
    return data;
  }
}
class ExerciseQuestions {
  String routine;
  int activityLevel;
  String memberShip;
  String exerciseType;
  String bodyType;
  String minExercise;

  ExerciseQuestions(
      {this.routine,
      this.activityLevel,
      this.memberShip,
      this.exerciseType,
      this.bodyType,
      this.minExercise});

  ExerciseQuestions.fromJson(Map<String, dynamic> json) {
    routine = json['Routine'] ?? "";
    activityLevel = json['ActivityLevel'] ?? 0;
    memberShip = json['MemberShip'] ?? "";
    exerciseType = json['ExerciseType'] ?? "";
    bodyType = json['BodyType'] ?? "";
    minExercise = json['MinExercise'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Routine'] = routine;
    data['ActivityLevel'] = activityLevel;
    data['MemberShip'] = memberShip;
    data['ExerciseType'] = exerciseType;
    data['BodyType'] = bodyType;
    data['MinExercise'] = minExercise;
    return data;
  }
}
