// ignore_for_file: file_names

import 'package:bandapp/screen/selectdayandTraining/trainingExplanation/trainingScreen_controller.dart';
import 'package:get/get.dart';

class TrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(TrainingController.new);
  }
}
