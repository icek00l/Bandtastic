import 'package:bandapp/screen/DashboardScreens/sessionScreen/session_controller.dart';
import 'package:get/get.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SessionController.new);
  }
}
