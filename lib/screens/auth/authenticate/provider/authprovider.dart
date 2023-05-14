import 'package:flutter/cupertino.dart';
import 'package:weight_loser/screens/auth/authenticate/model/authmodel.dart';

class   AuthModeprovider extends ChangeNotifier {
  final authModel _auth = authModel();
  setData(bool noti) {
    _auth.isGoogleOrFB = noti;
    notifyListeners();
  }

  getData() {
    return _auth.isGoogleOrFB;
  }
}
