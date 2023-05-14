// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  Dashboard({
    this.imagePath,
    this.profileVm,
    this.budgetVm,
    this.burners,
    this.blogs,
  });

  String imagePath;
  String profileVm;
  BudgetVm budgetVm;
  List<Burner> burners;
  List<Blog> blogs;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        imagePath: json["ImagePath"],
        profileVm: json["profileVM"],
        budgetVm: BudgetVm.fromJson(json["budgetVM"]),
        burners:
            List<Burner>.from(json["Burners"].map((x) => Burner.fromJson(x))),
        blogs: List<Blog>.from(json["Blogs"].map((x) => Blog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ImagePath": imagePath,
        "profileVM": profileVm,
        "budgetVM": budgetVm.toJson(),
        "Burners": List<dynamic>.from(burners.map((x) => x.toJson())),
        "Blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
      };
}

class Blog {
  Blog({
    this.id,
    this.title,
    this.blogTypeId,
    this.description,
    this.content,
    this.fileName,
    this.createdAt,
    this.modifiedAt,
  });

  int id;
  String title;
  int blogTypeId;
  String description;
  String content;
  String fileName;
  DateTime createdAt;
  DateTime modifiedAt;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["Id"],
        title: json["Title"],
        blogTypeId: json["BlogTypeId"],
        description: json["Description"],
        content: json["Content"],
        fileName: json["FileName"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        modifiedAt: json["ModifiedAt"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "BlogTypeId": blogTypeId,
        "Description": description,
        "Content": content,
        "FileName": fileName,
        "CreatedAt": createdAt.toIso8601String(),
        "ModifiedAt": modifiedAt == null ? null : modifiedAt.toIso8601String(),
      };
}

class BudgetVm {
  BudgetVm({
    this.budgetId,
    this.targetCalId,
    this.burnCalories,
    this.consCalories,
    this.userId,
    this.targetCalories,
    this.fat,
    this.carbs,
    this.protein,
    this.createdAt,
  });

  int budgetId;
  int targetCalId;
  int burnCalories;
  int consCalories;
  int userId;
  int targetCalories;
  int fat;
  int carbs;
  int protein;
  DateTime createdAt;

  factory BudgetVm.fromJson(Map<String, dynamic> json) => BudgetVm(
        budgetId: json["budget_Id"],
        targetCalId: json["target_cal_id"],
        burnCalories: json["Burn_Calories"],
        consCalories: json["Cons_Calories"],
        userId: json["UserId"],
        targetCalories: json["TargetCalories"],
        fat: json["fat"],
        carbs: json["Carbs"],
        protein: json["Protein"],
        createdAt: DateTime.parse(json["CreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "budget_Id": budgetId,
        "target_cal_id": targetCalId,
        "Burn_Calories": burnCalories,
        "Cons_Calories": consCalories,
        "UserId": userId,
        "TargetCalories": targetCalories,
        "fat": fat,
        "Carbs": carbs,
        "Protein": protein,
        "CreatedAt": createdAt.toIso8601String(),
      };
}

class Burner {
  Burner({
    this.id,
    this.burnerTypeId,
    this.name,
    this.description,
    this.duration,
    this.calories,
    this.fileName,
    this.createdAt,
    this.modifiedAt,
  });

  int id;
  int burnerTypeId;
  String name;
  Description description;
  int duration;
  double calories;
  String fileName;
  DateTime createdAt;
  DateTime modifiedAt;

  factory Burner.fromJson(Map<String, dynamic> json) => Burner(
        id: json["Id"],
        burnerTypeId: json["BurnerTypeId"],
        name: json["Name"],
        description: json["Description"] == null
            ? null
            : descriptionValues.map[json["Description"]],
        duration: json["Duration"],
        calories: json["Calories"].toDouble(),
        fileName: json["FileName"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        modifiedAt: json["ModifiedAt"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BurnerTypeId": burnerTypeId,
        "Name": name,
        "Description":
            description == null ? null : descriptionValues.reverse[description],
        "Duration": duration,
        "Calories": calories,
        "FileName": fileName,
        "CreatedAt": createdAt.toIso8601String(),
        "ModifiedAt": modifiedAt == null ? null : modifiedAt.toIso8601String(),
      };
}

enum Description { EMPTY, GENERAL }

final descriptionValues =
    EnumValues({"": Description.EMPTY, "general": Description.GENERAL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
