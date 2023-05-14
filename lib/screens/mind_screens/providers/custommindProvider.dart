import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/mind_screens/models/custom_mind_model.dart';

class custommindprovider extends ChangeNotifier {
  CustomMindModel _mindModel;
  int planId = null;

  setPlanId(int planId) {
    this.planId = planId;
  }

  getPlanId() {
    return this.planId;
  }

  setMindData(CustomMindModel data) {
    this._mindModel = data;
  }

  CustomMindModel getAllData() {
    return this._mindModel;
  }

  List<VideosData> getMindList() {
    return this._mindModel.videosData;
  }

  String getImagePath() {
    return this._mindModel.imagePath;
  }
}
