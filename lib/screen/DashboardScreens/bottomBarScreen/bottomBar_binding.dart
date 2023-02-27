// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/HomeScreen/homeScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:bandapp/screen/DashboardScreens/bottomBarScreen/bottomBar_controller.dart';
import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BottomBarController.new);
    Get.lazyPut(HomeScreenController.new);
    Get.lazyPut(SessionController.new);
    Get.lazyPut(WeekCycleController.new);
    Get.lazyPut(IntroductionController.new);
    Get.lazyPut(SetUpController.new);
  }
}
