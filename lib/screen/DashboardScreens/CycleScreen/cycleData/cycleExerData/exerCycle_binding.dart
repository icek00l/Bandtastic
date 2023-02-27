// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/cycleExerData/exerCycle_controller.dart';
import 'package:get/get.dart';

class ExerDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ExerDataController.new);
  }
}
