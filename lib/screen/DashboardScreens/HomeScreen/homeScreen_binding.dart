// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeScreenController.new);
  }
}
