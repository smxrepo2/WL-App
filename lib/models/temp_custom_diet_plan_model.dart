import 'food_model.dart';

class TempCustomDietPlanModel{

  String dinnerTime,morningTime,lunchTime,title,duration;
  var imageFile;
  List<TempDietFoodPlanItem> foodItems;

  TempCustomDietPlanModel(this.dinnerTime, this.morningTime, this.lunchTime,
      this.title, this.duration, this.foodItems,this.imageFile);
}
class TempDietFoodPlanItem{
  String FoodId,day,description,mealType;
  String filename,calories,servingSize,name;

  TempDietFoodPlanItem(this.FoodId, this.day, this.description, this.mealType,
      this.filename, this.calories, this.servingSize, this.name);
}