import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weight_loser/models/no_internet_model.dart';

class ConnectionService with ChangeNotifier {
  NoInternetModel connection;

  setInternet(bool value) {
    this.connection.isConnected = value;
    notifyListeners();
  }

  getInternet() {
    return this.connection.isConnected;
  }
}
