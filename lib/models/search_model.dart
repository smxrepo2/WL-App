class SearchFoodModel {
  var totalHits;
  var currentPage;
  var totalPages;
  List<int> pageList;
  FoodSearchCriteria foodSearchCriteria;
  List<Foods> foods;
  Aggregations aggregations;

  SearchFoodModel({this.totalHits, this.currentPage, this.totalPages, this.pageList, this.foodSearchCriteria, this.foods, this.aggregations});

  SearchFoodModel.fromJson(Map<String, dynamic> json) {
    totalHits = json['totalHits'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageList = json['pageList'].cast<int>();
    foodSearchCriteria = json['foodSearchCriteria'] != null ? new FoodSearchCriteria.fromJson(json['foodSearchCriteria']) : null;
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) { foods.add(new Foods.fromJson(v)); });
    }
    aggregations = json['aggregations'] != null ? new Aggregations.fromJson(json['aggregations']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalHits'] = this.totalHits;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['pageList'] = this.pageList;
    if (this.foodSearchCriteria != null) {
      data['foodSearchCriteria'] = this.foodSearchCriteria.toJson();
    }
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    if (this.aggregations != null) {
      data['aggregations'] = this.aggregations.toJson();
    }
    return data;
  }
}

class FoodSearchCriteria {
  String query;
  String generalSearchInput;
  var pageNumber;
  var numberOfResultsPerPage;
  var pageSize;
  bool requireAllWords;

  FoodSearchCriteria({this.query, this.generalSearchInput, this.pageNumber, this.numberOfResultsPerPage, this.pageSize, this.requireAllWords});

  FoodSearchCriteria.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    generalSearchInput = json['generalSearchInput'];
    pageNumber = json['pageNumber'];
    numberOfResultsPerPage = json['numberOfResultsPerPage'];
    pageSize = json['pageSize'];
    requireAllWords = json['requireAllWords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['generalSearchInput'] = this.generalSearchInput;
    data['pageNumber'] = this.pageNumber;
    data['numberOfResultsPerPage'] = this.numberOfResultsPerPage;
    data['pageSize'] = this.pageSize;
    data['requireAllWords'] = this.requireAllWords;
    return data;
  }
}

class Foods {
  var fdcId;
  String description;
  String lowercaseDescription;
  String dataType;
  String gtinUpc;
  String publishedDate;
  String brandOwner;
  String brandName;
  String subbrandName;
  String ingredients;
  String marketCountry;
  String foodCategory;
  String modifiedDate;
  String dataSource;
  String packageWeight;
  String servingSizeUnit;
  var servingSize;
  String allHighlightFields;
  var score;
  List<FoodNutrients> foodNutrients;
  String householdServingFullText;

  Foods({this.fdcId, this.description, this.lowercaseDescription, this.dataType, this.gtinUpc, this.publishedDate, this.brandOwner, this.brandName, this.subbrandName, this.ingredients, this.marketCountry, this.foodCategory, this.modifiedDate, this.dataSource, this.packageWeight, this.servingSizeUnit, this.servingSize, this.allHighlightFields, this.score, this.foodNutrients,  this.householdServingFullText});

  Foods.fromJson(Map<String, dynamic> json) {
    fdcId = json['fdcId'];
    description = json['description'];
    lowercaseDescription = json['lowercaseDescription'];
    dataType = json['dataType'];
    gtinUpc = json['gtinUpc'];
    publishedDate = json['publishedDate'];
    brandOwner = json['brandOwner'];
    brandName = json['brandName'];
    subbrandName = json['subbrandName'];
    ingredients = json['ingredients'];
    marketCountry = json['marketCountry'];
    foodCategory = json['foodCategory'];
    modifiedDate = json['modifiedDate'];
    dataSource = json['dataSource'];
    packageWeight = json['packageWeight'];
    servingSizeUnit = json['servingSizeUnit'];
    servingSize = json['servingSize'];
    allHighlightFields = json['allHighlightFields'];
    score = json['score'];
    if (json['foodNutrients'] != null) {
      foodNutrients = new List<FoodNutrients>();
      json['foodNutrients'].forEach((v) { foodNutrients.add(new FoodNutrients.fromJson(v)); });
    }

    householdServingFullText = json['householdServingFullText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fdcId'] = this.fdcId;
    data['description'] = this.description;
    data['lowercaseDescription'] = this.lowercaseDescription;
    data['dataType'] = this.dataType;
    data['gtinUpc'] = this.gtinUpc;
    data['publishedDate'] = this.publishedDate;
    data['brandOwner'] = this.brandOwner;
    data['brandName'] = this.brandName;
    data['subbrandName'] = this.subbrandName;
    data['ingredients'] = this.ingredients;
    data['marketCountry'] = this.marketCountry;
    data['foodCategory'] = this.foodCategory;
    data['modifiedDate'] = this.modifiedDate;
    data['dataSource'] = this.dataSource;
    data['packageWeight'] = this.packageWeight;
    data['servingSizeUnit'] = this.servingSizeUnit;
    data['servingSize'] = this.servingSize;
    data['allHighlightFields'] = this.allHighlightFields;
    data['score'] = this.score;
    if (this.foodNutrients != null) {
      data['foodNutrients'] = this.foodNutrients.map((v) => v.toJson()).toList();
    }

    data['householdServingFullText'] = this.householdServingFullText;
    return data;
  }
}

class FoodNutrients {
  var nutrientId;
  String nutrientName;
  String nutrientNumber;
  String unitName;
  String derivationCode;
  String derivationDescription;
  var derivationId;
  var value;
  var foodNutrientSourceId;
  String foodNutrientSourceCode;
  String foodNutrientSourceDescription;
  var rank;
  var indentLevel;
  var foodNutrientId;
  var percentDailyValue;

  FoodNutrients({this.nutrientId, this.nutrientName, this.nutrientNumber, this.unitName, this.derivationCode, this.derivationDescription, this.derivationId, this.value, this.foodNutrientSourceId, this.foodNutrientSourceCode, this.foodNutrientSourceDescription, this.rank, this.indentLevel, this.foodNutrientId, this.percentDailyValue});

  FoodNutrients.fromJson(Map<String, dynamic> json) {
    nutrientId = json['nutrientId'];
    nutrientName = json['nutrientName'];
    nutrientNumber = json['nutrientNumber'];
    unitName = json['unitName'];
    derivationCode = json['derivationCode'];
    derivationDescription = json['derivationDescription'];
    derivationId = json['derivationId'];
    value = json['value'];
    foodNutrientSourceId = json['foodNutrientSourceId'];
    foodNutrientSourceCode = json['foodNutrientSourceCode'];
    foodNutrientSourceDescription = json['foodNutrientSourceDescription'];
    rank = json['rank'];
    indentLevel = json['indentLevel'];
    foodNutrientId = json['foodNutrientId'];
    percentDailyValue = json['percentDailyValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nutrientId'] = this.nutrientId;
    data['nutrientName'] = this.nutrientName;
    data['nutrientNumber'] = this.nutrientNumber;
    data['unitName'] = this.unitName;
    data['derivationCode'] = this.derivationCode;
    data['derivationDescription'] = this.derivationDescription;
    data['derivationId'] = this.derivationId;
    data['value'] = this.value;
    data['foodNutrientSourceId'] = this.foodNutrientSourceId;
    data['foodNutrientSourceCode'] = this.foodNutrientSourceCode;
    data['foodNutrientSourceDescription'] = this.foodNutrientSourceDescription;
    data['rank'] = this.rank;
    data['indentLevel'] = this.indentLevel;
    data['foodNutrientId'] = this.foodNutrientId;
    data['percentDailyValue'] = this.percentDailyValue;
    return data;
  }
}

class Aggregations {
  DataType dataType;
  Nutrients nutrients;

  Aggregations({this.dataType, this.nutrients});

  Aggregations.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'] != null ? new DataType.fromJson(json['dataType']) : null;
    nutrients = json['nutrients'] != null ? new Nutrients.fromJson(json['nutrients']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataType != null) {
      data['dataType'] = this.dataType.toJson();
    }
    if (this.nutrients != null) {
      data['nutrients'] = this.nutrients.toJson();
    }
    return data;
  }
}

class DataType {
  var branded;

  DataType({this.branded});

  DataType.fromJson(Map<String, dynamic> json) {
    branded = json['Branded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Branded'] = this.branded;
    return data;
  }
}

class Nutrients {



Nutrients.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}