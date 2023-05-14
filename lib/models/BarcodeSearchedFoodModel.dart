class BarcodeSearchedFoodModel {
  String code;
  Product product;
  int status;

  BarcodeSearchedFoodModel({this.code, this.product});

  BarcodeSearchedFoodModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  Nutriments nutriments;
  String servingQuantity;
  String brands;

  Product({this.nutriments, this.servingQuantity, this.brands});

  Product.fromJson(Map<String, dynamic> json) {
    nutriments = json['nutriments'] != null
        ? new Nutriments.fromJson(json['nutriments'])
        : null;
    servingQuantity = json['serving_quantity'];
    brands = json['brands'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nutriments != null) {
      data['nutriments'] = this.nutriments.toJson();
    }
    data['serving_quantity'] = this.servingQuantity;
    data['brands'] = this.brands;
    return data;
  }
}

class Nutriments {
  var carbohydrates;
  var energyKcal;
  var fat;
  var proteins;

  Nutriments({this.carbohydrates, this.energyKcal, this.fat, this.proteins});

  Nutriments.fromJson(Map<String, dynamic> json) {
    carbohydrates = json['carbohydrates'];
    energyKcal = json['energy-kcal'];
    fat = json['fat'];
    proteins = json['proteins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carbohydrates'] = this.carbohydrates;
    data['energy-kcal'] = this.energyKcal;
    data['fat'] = this.fat;
    data['proteins'] = this.proteins;
    return data;
  }
}
