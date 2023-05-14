import 'package:flutter/cupertino.dart';
import 'package:weight_loser/Model/SignupBody.dart';

class questionprovider extends ChangeNotifier {
  SignUpBody signUpBody = SignUpBody();

  setSignUpBody(SignUpBody data) {
    this.signUpBody = data;
  }

  setGender(String data) {
    this.signUpBody.dietQuestions.gender = data;
    notifyListeners();
  }

  SignUpBody getSignUpBody() {
    return this.signUpBody;
  }
}
