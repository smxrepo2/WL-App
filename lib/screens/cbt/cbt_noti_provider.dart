import 'package:flutter/cupertino.dart';
import 'package:weight_loser/models/daily_log_model.dart';
import 'package:weight_loser/models/get_cbt_questions.dart';

class cbtprovider extends ChangeNotifier {
  CbtQuestions _cbtQuestions;

  setQuestionsData(CbtQuestions noti) {
    this._cbtQuestions = noti;
    //notifyListeners();
  }

  getQuestionsData() {
    return this._cbtQuestions;
  }
}
