import 'package:flutter/cupertino.dart';
import 'package:weight_loser/notifications/notificationmodel.dart';

class waternotiprovider extends ChangeNotifier {
  waterNotifications _waternotifications;

  setwaterNotifications(waterNotifications noti) {
    this._waternotifications = noti;
    //notifyListeners();
  }
}

class sleepnotiprovider extends ChangeNotifier {
  sleepNotifications _sleepnotifications;

  setsleepNotifications(sleepNotifications noti) {
    this._sleepnotifications = noti;
    //notifyListeners();
  }
}

class weightnotiprovider extends ChangeNotifier {
  weightNotifications _weightnotifications;

  setweightNotifications(weightNotifications noti) {
    this._weightnotifications = noti;
    //notifyListeners();
  }
}

class selfienotiprovider extends ChangeNotifier {
  selfieNotifications _selfienotifications;

  setselfieNotifications(selfieNotifications noti) {
    this._selfienotifications = noti;
    //notifyListeners();
  }
}

class mindnotiprovider extends ChangeNotifier {
  mindNotifications _mindnotifications;

  setmindNotifications(mindNotifications noti) {
    this._mindnotifications = noti;
    //notifyListeners();
  }
}

class restaurantnotiprovider extends ChangeNotifier {
  restaurantNotifications _restaurantnotifications;

  setrestaurantNotifications(restaurantNotifications noti) {
    this._restaurantnotifications = noti;
    //notifyListeners();
  }
}

class exercisenotiprovider extends ChangeNotifier {
  exerciseNotifications _exercisenotifications;

  setexerciseNotifications(exerciseNotifications noti) {
    this._exercisenotifications = noti;
    //notifyListeners();
  }
}

class earlysnacksnotiprovider extends ChangeNotifier {
  earlysnacksNotifications _earlysnacksnotifications;

  setearlysnacksNotifications(earlysnacksNotifications noti) {
    this._earlysnacksnotifications = noti;
    //notifyListeners();
  }
}

class breakfastnotiprovider extends ChangeNotifier {
  breakfastNotifications _breakfastnotifications;

  setbreakfastNotifications(breakfastNotifications noti) {
    this._breakfastnotifications = noti;
    //notifyListeners();
  }
}

class morningsnacksnotiprovider extends ChangeNotifier {
  morningsnacksNotifications _morningsnacksnotifications;

  setmorningsnacksNotifications(morningsnacksNotifications noti) {
    this._morningsnacksnotifications = noti;
    //notifyListeners();
  }
}

class lunchnotiprovider extends ChangeNotifier {
  lunchNotifications _lunchnotifications;

  setlunchNotifications(lunchNotifications noti) {
    this._lunchnotifications = noti;
    //notifyListeners();
  }
}

class afternoonnotiprovider extends ChangeNotifier {
  afternoonNotifications _afternoonnotifications;

  setafternoonNotifications(afternoonNotifications noti) {
    this._afternoonnotifications = noti;
    //notifyListeners();
  }
}

class dinnernotiprovider extends ChangeNotifier {
  dinnerNotifications _dinnernotifications;

  setdinnerNotifications(dinnerNotifications noti) {
    this._dinnernotifications = noti;
    //notifyListeners();
  }
}

class snacksnotiprovider extends ChangeNotifier {
  snacksNotifications _snacksnotifications;

  setsnacksNotifications(snacksNotifications noti) {
    this._snacksnotifications = noti;
    //notifyListeners();
  }
}
