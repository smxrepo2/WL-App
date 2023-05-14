import 'package:flutter/cupertino.dart';

import '../Service/settingsService.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);
  //SettingsController(this._settingsService);
  final SettingsService _settingsService;

  Future<void> loadSettings() async {
    await _settingsService.setallNotiData();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }
}
