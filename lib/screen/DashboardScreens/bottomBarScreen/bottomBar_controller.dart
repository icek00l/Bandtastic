// ignore_for_file: file_names, avoid_print

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomBarController extends GetxController {
  int currentBottomTab = 0;
  dynamic argumentData = Get.arguments;
  String route = '';
  PersistentTabController? tabController;

  @override
  void onInit() {
    if (argumentData != null) {
      route = argumentData["FirstTime"];
      print("route $route");
    }
    tabController = PersistentTabController(
        initialIndex: route == "1" ? 3 :route == "2" ? 1 : currentBottomTab);

    super.onInit();
  }
}
