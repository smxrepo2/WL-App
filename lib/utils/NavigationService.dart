import 'package:get/get.dart';

class NavigationService {
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return Get.toNamed(
        routeName); //Modular.navigatorKey.currentState.pushNamed(routeName);
  }

  goBack() {
    return Get.back(); //Modular.navigatorKey.currentState.pop();
  }
}
