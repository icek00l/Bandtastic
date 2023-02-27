// ignore_for_file: file_names

import 'package:bandapp/screen/UserData/emailScreen/emailScreen_controller.dart';
import 'package:get/get.dart';

class EmailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EmailScreenController.new);
  }
}
