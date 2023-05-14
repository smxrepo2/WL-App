import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';

class CustomMindProviderModel {
  String title, duration;
  var imageFile;
  List<MindVideoModel> mindItem;

  CustomMindProviderModel(
      this.title, this.duration, this.imageFile, this.mindItem);
}

class MindVideoModel {
  String videoId, day;
  String filename, duration, name, imageFile;

  MindVideoModel(this.videoId, this.day, this.filename, this.imageFile,
      this.duration, this.name);
}
