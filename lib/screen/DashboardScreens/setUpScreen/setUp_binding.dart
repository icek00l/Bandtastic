// ignore_for_file: file_names

import 'package:bandapp/screen/DashboardScreens/setUpScreen/setUp_controller.dart';
import 'package:get/get.dart';

class SetUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SetUpController.new);
  }
}
