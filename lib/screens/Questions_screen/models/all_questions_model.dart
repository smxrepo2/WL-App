class GetAllQuestionsModel {
  String imagePath;
  List<String> questionsContent;
  List<Questoins> questoins;

  GetAllQuestionsModel({this.imagePath, this.questionsContent, this.questoins});

  GetAllQuestionsModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    questionsContent = json['QuestionsContent'].cast<String>();
    if (json['Questoins'] != null) {
      questoins = <Questoins>[];
      json['Questoins'].forEach((v) {
        questoins.add(new Questoins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    data['QuestionsContent'] = this.questionsContent;
    if (this.questoins != null) {
      data['Questoins'] = this.questoins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questoins {
  int id;
  String title;
  String question;
  String options;
  Null type;
  String fileName;
  int order;
  String createdAt;
  Null modifiedAt;

  Questoins(
      {this.id,
      this.title,
      this.question,
      this.options,
      this.type,
      this.fileName,
      this.order,
      this.createdAt,
      this.modifiedAt});

  Questoins.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    question = json['Question'];
    options = json['Options'];
    type = json['Type'];
    fileName = json['FileName'];
    order = json['Order'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Question'] = this.question;
    data['Options'] = this.options;
    data['Type'] = this.type;
    data['FileName'] = this.fileName;
    data['Order'] = this.order;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    return data;
  }
}

/// Add Gender Questions Model
class AddGenderQuestionRequestModel {
  int UserId;
  String Gender;
  int QuestionOrder;

  AddGenderQuestionRequestModel({this.UserId, this.Gender, this.QuestionOrder});

  AddGenderQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Gender = json['Gender'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Gender'] = Gender;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddGenderQuestionResponseModel {
  String response;

  AddGenderQuestionResponseModel({this.response});

  AddGenderQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Height Questions Model
class AddHeightQuestionRequestModel {
  int UserId;
  double Height;
  String HeightUnit;
  int QuestionOrder;

  AddHeightQuestionRequestModel(
      {this.UserId, this.Height, this.HeightUnit, this.QuestionOrder});

  AddHeightQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Height = json['Height'];
    HeightUnit = json['HeightUnit'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Height'] = Height;
    data['HeightUnit'] = HeightUnit;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddHeightQuestionResponseModel {
  String response;

  AddHeightQuestionResponseModel({this.response});

  AddHeightQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Weight Questions Model
class AddWeightQuestionRequestModel {
  int UserId;
  String WeightUnit;
  int Currentweight;
  int QuestionOrder;

  AddWeightQuestionRequestModel(
      {this.UserId, this.WeightUnit, this.Currentweight, this.QuestionOrder});

  AddWeightQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    WeightUnit = json['WeightUnit'];
    Currentweight = json['Currentweight'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['WeightUnit'] = WeightUnit;
    data['Currentweight'] = Currentweight;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddWeightQuestionResponseModel {
  String response;

  AddWeightQuestionResponseModel({this.response});

  AddWeightQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Weight Goal Questions Model
class AddGoalWeightQuestionRequestModel {
  int UserId;
  int GoalWeight;
  String WeightUnit;
  int QuestionOrder;

  AddGoalWeightQuestionRequestModel(
      {this.UserId, this.GoalWeight, this.WeightUnit, this.QuestionOrder});

  AddGoalWeightQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    GoalWeight = json['GoalWeight'];
    WeightUnit = json['WeightUnit'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['GoalWeight'] = GoalWeight;
    data['WeightUnit'] = WeightUnit;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddGoalWeightQuestionResponseModel {
  String response;

  AddGoalWeightQuestionResponseModel({this.response});

  AddGoalWeightQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add DOB Questions Model
class AddDOBQuestionRequestModel {
  int UserId;
  String DOB;
  int QuestionOrder;

  AddDOBQuestionRequestModel({this.UserId, this.DOB, this.QuestionOrder});

  AddDOBQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    DOB = json['DOB'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['DOB'] = DOB;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddDOBQuestionResponseModel {
  String response;

  AddDOBQuestionResponseModel({this.response});

  AddDOBQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Age Questions Model
class AddAgeQuestionRequestModel {
  int UserId;
  int Age;
  int QuestionOrder;

  AddAgeQuestionRequestModel({this.UserId, this.Age, this.QuestionOrder});

  AddAgeQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Age = json['Age'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Age'] = Age;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddAgeQuestionResponseModel {
  String response;

  AddAgeQuestionResponseModel({this.response});

  AddAgeQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Sleep Hour Questions Model
class AddSleepHourQuestionRequestModel {
  int UserId;
  int SleepTime;
  int QuestionOrder;

  AddSleepHourQuestionRequestModel(
      {this.UserId, this.SleepTime, this.QuestionOrder});

  AddSleepHourQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    SleepTime = json['SleepTime'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['SleepTime'] = SleepTime;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddSleepHourQuestionResponseModel {
  String response;

  AddSleepHourQuestionResponseModel({this.response});

  AddSleepHourQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Eat Type Questions Model
class AddEatTypeQuestionRequestModel {
  int UserId;
  String FoodType;
  int QuestionOrder;

  AddEatTypeQuestionRequestModel(
      {this.UserId, this.FoodType, this.QuestionOrder});

  AddEatTypeQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    FoodType = json['FoodType'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['FoodType'] = FoodType;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEatTypeQuestionResponseModel {
  String response;

  AddEatTypeQuestionResponseModel({this.response});

  AddEatTypeQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Cousin Questions Model
class AddCousinQuestionRequestModel {
  int UserId;
  String FavCuisine;
  int QuestionOrder;

  AddCousinQuestionRequestModel(
      {this.UserId, this.FavCuisine, this.QuestionOrder});

  AddCousinQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    FavCuisine = json['FavCuisine'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['FavCuisine'] = FavCuisine;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddCousinQuestionResponseModel {
  String response;

  AddCousinQuestionResponseModel({this.response});

  AddCousinQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Restaurant Questions Model
class AddFavouriteRestaurantQuestionRequestModel {
  int UserId;
  List<AddRestaurantQuestionModel> restaurants;
  int QuestionOrder;

  AddFavouriteRestaurantQuestionRequestModel(
      {this.UserId, this.restaurants, this.QuestionOrder});

  AddFavouriteRestaurantQuestionRequestModel.fromJson(
      Map<String, dynamic> json) {
    UserId = json['UserId'];
    QuestionOrder = json['QuestionOrder'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants.add(AddRestaurantQuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.UserId;
    data['QuestionOrder'] = this.QuestionOrder;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddRestaurantQuestionModel {
  int restuarantId;

  AddRestaurantQuestionModel({this.restuarantId});

  AddRestaurantQuestionModel.fromJson(Map<String, dynamic> json) {
    restuarantId = json['RestuarantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RestuarantId'] = this.restuarantId;
    return data;
  }
}

class AddFavouriteRestaurantQuestionResponseModel {
  String response;

  AddFavouriteRestaurantQuestionResponseModel({this.response});

  AddFavouriteRestaurantQuestionResponseModel.fromJson(
      Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Medical Questions Model
class AddMedicalConditionQuestionRequestModel {
  int UserId;
  String MedicalCondition;
  int QuestionOrder;

  AddMedicalConditionQuestionRequestModel(
      {this.UserId, this.MedicalCondition, this.QuestionOrder});

  AddMedicalConditionQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    MedicalCondition = json['MedicalCondition'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['MedicalCondition'] = MedicalCondition;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddMedicalConditionQuestionResponseModel {
  String response;

  AddMedicalConditionQuestionResponseModel({this.response});

  AddMedicalConditionQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add RestrictedFood Questions Model
class AddRestrictedFoodQuestionRequestModel {
  int UserId;
  String RestrictedFood;
  int QuestionOrder;

  AddRestrictedFoodQuestionRequestModel(
      {this.UserId, this.RestrictedFood, this.QuestionOrder});

  AddRestrictedFoodQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    RestrictedFood = json['RestrictedFood'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['RestrictedFood'] = RestrictedFood;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddRestrictedFoodQuestionResponseModel {
  String response;

  AddRestrictedFoodQuestionResponseModel({this.response});

  AddRestrictedFoodQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add WaterHabit Questions Model
class AddWaterHabitQuestionRequestModel {
  int UserId;
  String WaterHabit;
  int QuestionOrder;

  AddWaterHabitQuestionRequestModel(
      {this.UserId, this.WaterHabit, this.QuestionOrder});

  AddWaterHabitQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    WaterHabit = json['WaterHabit'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['WaterHabit'] = WaterHabit;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddWaterHabitQuestionResponseModel {
  String response;

  AddWaterHabitQuestionResponseModel({this.response});

  AddWaterHabitQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add LessSleep Questions Model
class AddLessSleepQuestionRequestModel {
  int UserId;
  String SevenSleeping;
  int QuestionOrder;

  AddLessSleepQuestionRequestModel(
      {this.UserId, this.SevenSleeping, this.QuestionOrder});

  AddLessSleepQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    SevenSleeping = json['SevenSleeping'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['SevenSleeping'] = SevenSleeping;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddLessSleepQuestionResponseModel {
  String response;

  AddLessSleepQuestionResponseModel({this.response});

  AddLessSleepQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Endurance Questions Model
class AddEnduranceQuestionRequestModel {
  int UserId;
  String MinExercise;
  int QuestionOrder;

  AddEnduranceQuestionRequestModel(
      {this.UserId, this.MinExercise, this.QuestionOrder});

  AddEnduranceQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    MinExercise = json['MinExercise'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['MinExercise'] = MinExercise;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEnduranceQuestionResponseModel {
  String response;

  AddEnduranceQuestionResponseModel({this.response});

  AddEnduranceQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Endurance Questions Model
class AddGymRoutineQuestionRequestModel {
  int UserId;
  String Routine;
  int QuestionOrder;

  AddGymRoutineQuestionRequestModel(
      {this.UserId, this.Routine, this.QuestionOrder});

  AddGymRoutineQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Routine = json['Routine'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Routine'] = Routine;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddGymRoutineQuestionResponseModel {
  String response;

  AddGymRoutineQuestionResponseModel({this.response});

  AddGymRoutineQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Mobility Questions Model
class AddMobilityQuestionRequestModel {
  int UserId;
  String LifeStyle;
  int QuestionOrder;

  AddMobilityQuestionRequestModel(
      {this.UserId, this.LifeStyle, this.QuestionOrder});

  AddMobilityQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    LifeStyle = json['LifeStyle'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['LifeStyle'] = LifeStyle;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddMobilityQuestionResponseModel {
  String response;

  AddMobilityQuestionResponseModel({this.response});

  AddMobilityQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Food Control Questions Model
class AddFoodControlQuestionRequestModel {
  int UserId;
  String Control;
  int QuestionOrder;

  AddFoodControlQuestionRequestModel(
      {this.UserId, this.Control, this.QuestionOrder});

  AddFoodControlQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Control = json['Control'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Control'] = Control;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddFoodControlQuestionResponseModel {
  String response;

  AddFoodControlQuestionResponseModel({this.response});

  AddFoodControlQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add thinking Food  Questions Model
class AddFoodThinkingQuestionRequestModel {
  int UserId;
  String SadEating;
  int QuestionOrder;

  AddFoodThinkingQuestionRequestModel(
      {this.UserId, this.SadEating, this.QuestionOrder});

  AddFoodThinkingQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    SadEating = json['SadEating'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['SadEating'] = SadEating;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddFoodThinkingQuestionResponseModel {
  String response;

  AddFoodThinkingQuestionResponseModel({this.response});

  AddFoodThinkingQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Past Diets  Questions Model
class AddPastDietsQuestionRequestModel {
  int UserId;
  String CraveFoods;
  int QuestionOrder;

  AddPastDietsQuestionRequestModel(
      {this.UserId, this.CraveFoods, this.QuestionOrder});

  AddPastDietsQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    CraveFoods = json['CraveFoods'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['CraveFoods'] = CraveFoods;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddPastDietsQuestionResponseModel {
  String response;

  AddPastDietsQuestionResponseModel({this.response});

  AddPastDietsQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Eat Stressed  Questions Model
class AddEatStressedQuestionRequestModel {
  int UserId;
  String Stress;
  int QuestionOrder;

  AddEatStressedQuestionRequestModel(
      {this.UserId, this.Stress, this.QuestionOrder});

  AddEatStressedQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Stress = json['Stress'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Stress'] = Stress;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEatStressedQuestionResponseModel {
  String response;

  AddEatStressedQuestionResponseModel({this.response});

  AddEatStressedQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Eat Stressed  Questions Model
class AddEatBoredQuestionRequestModel {
  int UserId;
  String BoredEating;
  int QuestionOrder;

  AddEatBoredQuestionRequestModel(
      {this.UserId, this.BoredEating, this.QuestionOrder});

  AddEatBoredQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    BoredEating = json['BoredEating'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['BoredEating'] = BoredEating;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEatBoredQuestionResponseModel {
  String response;

  AddEatBoredQuestionResponseModel({this.response});

  AddEatBoredQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Eat Stressed  Questions Model
class AddEatQuickerQuestionRequestModel {
  int UserId;
  String EatingRound;
  int QuestionOrder;

  AddEatQuickerQuestionRequestModel(
      {this.UserId, this.EatingRound, this.QuestionOrder});

  AddEatQuickerQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    EatingRound = json['EatingRound'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['EatingRound'] = EatingRound;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEatQuickerQuestionResponseModel {
  String response;

  AddEatQuickerQuestionResponseModel({this.response});

  AddEatQuickerQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Eat Snacks  Questions Model
class AddEatSnacksQuestionRequestModel {
  int UserId;
  String LateNightHabit;
  int QuestionOrder;

  AddEatSnacksQuestionRequestModel(
      {this.UserId, this.LateNightHabit, this.QuestionOrder});

  AddEatSnacksQuestionRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    LateNightHabit = json['LateNightHabit'];
    QuestionOrder = json['QuestionOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['LateNightHabit'] = LateNightHabit;
    data['QuestionOrder'] = QuestionOrder;
    return data;
  }
}

class AddEatSnacksQuestionResponseModel {
  String response;

  AddEatSnacksQuestionResponseModel({this.response});

  AddEatSnacksQuestionResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

// Add Mind Category
class AddMindCategoryRequestModel {
  int UserId;
  String Category;

  AddMindCategoryRequestModel({this.UserId, this.Category});

  AddMindCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    Category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = UserId;
    data['Category'] = Category;
    return data;
  }
}

class AddMindCategoryResponseModel {
  String response;

  AddMindCategoryResponseModel({this.response});

  AddMindCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

/// Add Payment Model
// "Amount" : 10.55,
// "Duration" : 30,
// "Name" : "Package Name",
// "Status": "paid",
// "UserId" : 105
class AddPaymentConfirmationRequestModel {
  double Amount;
  int Duration;
  String Name;
  String Status;
  int UserId;

  AddPaymentConfirmationRequestModel(
      {this.Amount, this.Duration, this.Name, this.Status, this.UserId});

  AddPaymentConfirmationRequestModel.fromJson(Map<String, dynamic> json) {
    Amount = json['Amount'];
    Duration = json['Duration'];
    Name = json['Name'];
    Status = json['Status'];
    UserId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Amount'] = Amount;
    data['Duration'] = Duration;
    data['Name'] = Name;
    data['Status'] = Status;
    data['UserId'] = UserId;
    return data;
  }
}

class AddPaymentConfirmationResponseModel {
  String response;

  AddPaymentConfirmationResponseModel({this.response});

  AddPaymentConfirmationResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}
