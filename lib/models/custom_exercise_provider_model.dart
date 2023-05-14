import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';

class CustomExerciseProviderModel{

  String title,duration;
  var imageFile;
  List<ExerciseSetModel> exerciseItem;
  List<List<ExerciseSetModel>> sets=[];

  CustomExerciseProviderModel(
      this.title, this.duration, this.imageFile, this.exerciseItem,this.sets);
}
class ExerciseSetModel{
  int burnerId;
  String day,setName;
  String filename,calories,exerciseDuration,name;

  ExerciseSetModel(this.burnerId, this.day, this.setName, this.filename,
      this.calories, this.exerciseDuration, this.name);
}
