class FoodRecipeModel {
  String foodId;
  String name;
  String servingSize;
  int calories;
  String fileName;
  String foodDetail;
  int quantity;

  FoodRecipeModel(
      {this.foodId,
        this.name,
        this.servingSize,
        this.calories,
        this.fileName,
        this.foodDetail,
        this.quantity});

  FoodRecipeModel.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    servingSize = json['ServingSize'];
    calories = json['Calories'];
    fileName = json['FileName'];
    foodDetail = json['Food_Detail'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['ServingSize'] = this.servingSize;
    data['Calories'] = this.calories;
    data['FileName'] = this.fileName;
    data['Food_Detail'] = this.foodDetail;
    data['Quantity'] = this.quantity;
    return data;
  }
}