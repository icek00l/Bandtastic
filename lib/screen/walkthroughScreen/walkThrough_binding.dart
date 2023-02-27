// ignore_for_file: file_names

import 'package:bandapp/screen/walkthroughScreen/walkThrough_controller.dart';
import 'package:get/get.dart';

class WalkThroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WalkThroughController.new);
  }
}
