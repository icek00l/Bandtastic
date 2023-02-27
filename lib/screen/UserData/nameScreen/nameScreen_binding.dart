// ignore_for_file: file_names

import 'package:bandapp/screen/UserData/nameScreen/nameScreen_controller.dart';
import 'package:get/get.dart';

class NameScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NameScreenController.new);
  }
}
