import 'package:flutter/material.dart';
import 'package:weight_loser/models/DashboardModel.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel _dashboardModel;

  void setDashboardModel(DashboardModel model) {
    _dashboardModel = model;
    notifyListeners();
  }

  DashboardModel get dashboardModel => _dashboardModel;
}
