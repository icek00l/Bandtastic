// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleWeekData/weekCycle_controller.dart';
import 'package:get/get.dart';

class WeekDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WeekDataController.new);
  }
}
