import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/auth/authenticate/model/googleFBModel.dart';

class googleprovider extends ChangeNotifier {
  googleFBModel _auth = googleFBModel();
  setName(String name) {
    _auth.name = name;
    //notifyListeners();
  }

  setEmail(String email) {
    _auth.email = email;
  }

  getName() {
    return _auth.name;
  }

  getEmail() {
    return _auth.email;
  }
}
