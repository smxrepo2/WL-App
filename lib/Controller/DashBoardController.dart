import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import '../Service/BaseService.dart';
import '../Model/DashboardModel.dart';

class DashboardController extends GetxController {
  static DashboardController get i => Get.find();

  var data = Dashboard().obs;
  var offset = 0.obs;
  int userid;
  @override
  void onInit()async {
    // called immediately after the widget is allocated memory
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid=prefs.getInt('userid');
    getDashboardData(userid);
    super.onInit();
  }

  rotate(value) {
    if (offset.value == 90) {
      offset.value = 0;
    } else
      offset.value = value;
    print(offset.value);
  }

  Future<void> getDashboardData(int userid) async {
    data.value = Dashboard.fromJson(await BaseService().baseGetAPI("api/dashboard/$userid"));
    print(data.toJson());
  }
}
