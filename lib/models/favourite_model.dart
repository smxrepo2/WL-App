class Favourite_model {
  String foodId;
  String name;
  String description;
  var servingSize;
  var calories;
  var fat;
  var protein;
  var carbs;
  String fileName;

  Favourite_model(
      {this.foodId,
      this.name,
      this.description,
      this.servingSize,
      this.calories,
      this.fat,
      this.protein,
      this.carbs,
      this.fileName});

  Favourite_model.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Description'];
    servingSize = json['ServingSize'];
    calories = json['Calories'];
    fat = json['fat'];
    protein = json['Protein'];
    carbs = json['Carbs'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['ServingSize'] = this.servingSize;
    data['Calories'] = this.calories;
    data['fat'] = this.fat;
    data['Protein'] = this.protein;
    data['Carbs'] = this.carbs;
    data['FileName'] = this.fileName;
    return data;
  }
}

class FavouriteExerciseModel {
  String imagePath;
  String videoPath;
  List<FavoriteExerciseVMs> favoriteExerciseVMs;

  FavouriteExerciseModel(
      {this.imagePath, this.videoPath, this.favoriteExerciseVMs});

  FavouriteExerciseModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    videoPath = json['videoPath'];
    if (json['favoriteExerciseVMs'] != null) {
      favoriteExerciseVMs = <FavoriteExerciseVMs>[];
      json['favoriteExerciseVMs'].forEach((v) {
        favoriteExerciseVMs.add(new FavoriteExerciseVMs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    data['videoPath'] = this.videoPath;
    if (this.favoriteExerciseVMs != null) {
      data['favoriteExerciseVMs'] =
          this.favoriteExerciseVMs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteExerciseVMs {
  int burnerId;
  String name;
  String fileName;
  int calories;
  int duration;
  int videoDuration;
  String videoFile;

  FavoriteExerciseVMs(
      {this.burnerId,
      this.name,
      this.fileName,
      this.calories,
      this.duration,
      this.videoDuration,
      this.videoFile});

  FavoriteExerciseVMs.fromJson(Map<String, dynamic> json) {
    burnerId = json['burnerId'];
    name = json['Name'];
    fileName = json['FileName'];
    calories = json['Calories'];
    duration = json['duration'];
    videoDuration = json['VideoDuration'];
    videoFile = json['VideoFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['burnerId'] = this.burnerId;
    data['Name'] = this.name;
    data['FileName'] = this.fileName;
    data['Calories'] = this.calories;
    data['duration'] = this.duration;
    data['VideoDuration'] = this.videoDuration;
    data['VideoFile'] = this.videoFile;
    return data;
  }
}

class FavouriteMindModel {
  int vidId;
  String title;
  String description;
  String videoFile;
  int duration;

  FavouriteMindModel(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.duration});

  FavouriteMindModel.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['Title'];
    description = json['Description'];
    videoFile = json['VideoFile'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vidId'] = this.vidId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['VideoFile'] = this.videoFile;
    data['duration'] = this.duration;
    return data;
  }
}
