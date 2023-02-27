
import 'package:bandapp/screen/DashboardScreens/Intro_Video/introductionScreens/introduction_controller.dart';
import 'package:get/get.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(IntroductionController.new);
  }
}
