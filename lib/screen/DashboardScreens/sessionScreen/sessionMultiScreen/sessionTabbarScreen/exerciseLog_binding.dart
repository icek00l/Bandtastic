// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/sessionTabbarScreen/exerciseLog_controller.dart';
import 'package:get/get.dart';

class ExerciseLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ExerciseLogController.new);
  }
}
