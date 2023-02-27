import 'package:bandapp/screen/DashboardScreens/sessionScreen/sessionMultiScreen/InEndSession/End_controller.dart';
import 'package:get/get.dart';

class EndSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EndSessionController.new);
  }
}
