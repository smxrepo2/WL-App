class CbtQuestions {
  String imagePath;
  List<Audioes> audioes;

  CbtQuestions({this.imagePath, this.audioes});

  CbtQuestions.fromJson(Map<String, dynamic> json) {
    imagePath = json['ImagePath'];
    if (json['audioes'] != null) {
      audioes = <Audioes>[];
      json['audioes'].forEach((v) {
        audioes.add(new Audioes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImagePath'] = this.imagePath;
    if (this.audioes != null) {
      data['audioes'] = this.audioes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Audioes {
  int id;
  int userId;
  String questionTitle;
  String question;
  String type;
  List<Options> options;

  Audioes(
      {this.id,
      this.userId,
      this.questionTitle,
      this.question,
      this.type,
      this.options});

  Audioes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    questionTitle = json['QuestionTitle'];
    question = json['Question'];
    type = json['Type'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['QuestionTitle'] = this.questionTitle;
    data['Question'] = this.question;
    data['Type'] = this.type;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int id;
  int questionId;
  String title;
  String fileName;
  bool isActive;
  String createdAt;
  bool isCorrect;
  Null modifiedAt;

  Options(
      {this.id,
      this.questionId,
      this.title,
      this.fileName,
      this.isActive,
      this.createdAt,
      this.isCorrect,
      this.modifiedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    questionId = json['QuestionId'];
    title = json['Title'];
    fileName = json['FileName'];
    isActive = json['IsActive'];
    createdAt = json['CreatedAt'];
    modifiedAt = json['ModifiedAt'];
    isCorrect = json["IsCorrect"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['QuestionId'] = this.questionId;
    data['Title'] = this.title;
    data['FileName'] = this.fileName;
    data['IsActive'] = this.isActive;
    data['CreatedAt'] = this.createdAt;
    data['ModifiedAt'] = this.modifiedAt;
    data['IsCorrect'] = this.isCorrect;
    return data;
  }
}
