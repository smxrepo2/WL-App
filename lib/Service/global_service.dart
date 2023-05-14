import 'package:get/get.dart';

import '../models/global_model.dart';
import '../utils/helper.dart';



class GlobalService extends GetxService {
  final global = Global().obs;

  Future<GlobalService> init() async {
    var response = await Helper.getJsonFile('config/global.json');
    global.value = Global.fromJson(response);
    return this;
  }

  String get baseUrl => global.value.laravelBaseUrl;
}
