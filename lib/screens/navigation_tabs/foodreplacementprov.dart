import 'package:flutter/cupertino.dart';
import 'package:weight_loser/models/food-replace-nav.dart';

class replacementnotiprovider extends ChangeNotifier {
  foodreplacenav _food = foodreplacenav();

  setData(int noti) {
    print("datafortab: $noti");
    _food.setter(noti);
    notifyListeners();
  }

  getData() {
    return _food.getter();
  }
}
