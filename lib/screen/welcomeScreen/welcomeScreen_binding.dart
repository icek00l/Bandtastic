// ignore_for_file: file_names

import 'package:bandapp/screen/welcomeScreen/welcomeScreen_controller.dart';
import 'package:get/get.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WelcomeController.new);
  }
}
