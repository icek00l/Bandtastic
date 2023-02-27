// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleScreen_controller.dart';
import 'package:get/get.dart';

class WeekCycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WeekCycleController.new);
  }
}
