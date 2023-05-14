import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';

class allquestionprovider extends ChangeNotifier {
  GetAllQuestionsModel _allQuestionsModel;
  setAllQuestions(GetAllQuestionsModel data) {
    this._allQuestionsModel = _allQuestionsModel;
    //notifyListeners();
  }

  GetAllQuestionsModel get getAllQuestions => _allQuestionsModel;
/*
  GetAllQuestionsModel getAllQuestions() {
    return this._allQuestionsModel;
  }
  */
}
