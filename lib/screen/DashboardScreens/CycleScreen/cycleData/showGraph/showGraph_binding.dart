// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/CycleScreen/cycleData/showGraph/showGraph_controller.dart';
import 'package:get/get.dart';

class ShowGraphBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ShowGraphController.new);
  }
}
