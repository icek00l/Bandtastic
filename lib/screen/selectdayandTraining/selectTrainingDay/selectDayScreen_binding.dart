// ignore_for_file: file_names

import 'package:bandapp/screen/selectdayandTraining/selectTrainingDay/selectDayScreen_controller.dart';
import 'package:get/get.dart';

class SelectDayScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SelectDayScreenController.new);
  }
}
