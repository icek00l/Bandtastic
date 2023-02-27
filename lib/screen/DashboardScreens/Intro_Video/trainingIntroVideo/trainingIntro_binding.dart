// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/Intro_Video/trainingIntroVideo/trainingIntro_controller.dart';
import 'package:get/get.dart';

class TrainIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(TrainIntroController.new);
  }
}
